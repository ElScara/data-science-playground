"""Dependency-free checks of Python files and notebook JSON."""
import ast
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def check():
    problems = []
    for path in ROOT.rglob('*.py'):
        if '.git' in path.parts or '.venv' in path.parts:
            continue
        try:
            ast.parse(path.read_text(encoding='utf-8'), filename=str(path))
        except (SyntaxError, UnicodeError) as error:
            problems.append(f'{path}: {error}')
    for path in ROOT.rglob('*.ipynb'):
        try:
            data = json.loads(path.read_text(encoding='utf-8'))
            if not isinstance(data.get('cells'), list):
                raise ValueError('missing notebook cells')
            for index, cell in enumerate(data['cells']):
                if cell.get('cell_type') == 'code' and not isinstance(cell.get('source'), (list, str)):
                    raise ValueError(f'invalid source in cell {index}')
        except (ValueError, UnicodeError) as error:
            problems.append(f'{path}: {error}')
    return problems


if __name__ == '__main__':
    problems = check()
    for problem in problems:
        print(problem)
    print(f'{len(problems)} static issue(s)')
    raise SystemExit(bool(problems))
