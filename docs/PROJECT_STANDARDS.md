# Project documentation and quality standards

- Keep the main README text-focused, with a navigable project index; screenshots belong in their individual project directories.
- Each project README should describe the problem, dataset provenance, methods, outputs, reproduction steps, limitations, and tools.
- Use a project-specific requirements file for Python projects and document the working directory expected by notebooks.
- Keep data preprocessing inside cross-validation or train-only pipelines when measuring model generalisation.
- Report a baseline, holdout metrics, and training-only cross-validation where appropriate. Never invent performance figures.
- Verify dataset redistribution rights and disclose missing original inputs rather than claiming complete reproduction.
- Use descriptive filenames for new work. Rename historical artifacts only after updating all links and references.
- Prefer authentic dashboard screenshots over mockups. Place them under the corresponding project's images directory.
- Quality CI checks syntax and file structure; it does not establish that a notebook runs end-to-end or that a model is accurate.
