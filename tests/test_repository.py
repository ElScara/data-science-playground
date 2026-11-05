"""Structural regression checks, requiring no external dependencies."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'scripts'))
from check_repository import check


class PortfolioTests(unittest.TestCase):
    def test_python_and_notebook_structure(self):
        self.assertEqual(check(), [])

    def test_capstone_input(self):
        self.assertTrue((ROOT / '07_Capstone_project/zomato_cleaned.csv').is_file())

    def test_python_requirements(self):
        for directory in [
            '07_Capstone_project',
            '02_Python_Basics/App_rating_prediction',
            '05_Machine_Learning_Python/Student_social_media_addiction',
            '05_Machine_Learning_Python/mercedes_benz_greener_manufacturing',
        ]:
            with self.subTest(directory=directory):
                self.assertTrue((ROOT / directory / 'requirements.txt').is_file())


if __name__ == '__main__':
    unittest.main()
