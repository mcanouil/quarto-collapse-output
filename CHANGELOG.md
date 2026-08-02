# Changelog

## Unreleased

### Refactoring

- refactor: Target the Quarto Wizard v2 extension schema in `_schema.yml`, renaming `enum-case-insensitive` to `enumCaseInsensitive`.

## 1.5.1 (2026-08-01)

### Documentation

- docs: Add a documentation website under `docs/`, built on the `atelier` project type and published to <https://m.canouil.dev/quarto-collapse-output/>.
- docs: Trim `README.md` to a landing page pointing at the website, and `example.qmd` to a short starting point to copy.
- docs: Add the Pages workflow, which renders `docs/` on pull requests and deploys it from the release tag.
- docs: Add the Quarto Extensions Updates workflow, scanning `docs` for the website's own dependencies.
- docs: Fold real executed output on the website rather than hand-written cell markup, so every fold is produced by the filter from a cell that ran.
- docs: Add an R page alongside the Python one, run through knitr, so the website shows the filter folding output from both engines.
- docs: Add an renv environment at the repository root, shared by the website through `docs/.Rprofile`, so there is one lockfile rather than two to keep in step. Dependencies are declared in `DESCRIPTION`, marked `Type: project`, and resolved with renv's explicit snapshot type, rather than discovered by scanning the sources.

## 1.5.0 (2026-05-31)

### New Features

- feat: Add `collapse-all-outputs` document option with per-cell `output-fold` override.
- feat: Add `default-open` option and per-cell `output-open` override for the initial state.
- feat: Add `auto-collapse-size` threshold to force-collapse outputs above a line count.
- feat: Add `output-types` option to restrict folding to specific output kinds (stdout, stderr, display, output).
- feat: Add separate `stdout`/`stderr` folding with distinct default summaries.
- feat: Add `summary-template` with `{type}` and `{lines}` placeholders.
- feat: Add `summaries` mapping for per-output-type summary overrides.

### Bug Fixes

- fix: Remove redundant nested `if method == 'javascript'` branch in `collapse-output.lua` (dead code).
- fix: Reset filter configuration at every Meta pass to avoid state bleed across batch renders.

### Refactoring

- refactor: Factor configuration parsing into typed helpers with warning emission for invalid values.

### Documentation

- docs: Document new options, attributes, and templates in README, schema, and snippets.

## 1.4.1 (2026-04-15)

### Refactoring

- refactor: Synchronise shared module (`logging.lua`) with canonical version.

## 1.4.0 (2026-03-23)

### Refactoring

- refactor: Replace monolithic `utils.lua` with focused modules (`string.lua`, `logging.lua`, `metadata.lua`, `pandoc-helpers.lua`, `html.lua`, `paths.lua`, `colour.lua`).

## 1.3.1 (2026-02-21)

### New Features

- feat: Rename element-attributes to attributes in schema (#27).

## 1.3.0 (2026-02-21)

### New Features

- feat: Add extension-provided code snippets (#25).
- feat: Add _schema.yml for configuration validation and IDE support (#22).

## 1.2.1 (2026-02-11)

### Bug Fixes

- fix: Update copyright year.
- fix: Use british english spelling.

## 1.2.0 (2025-10-25)

### Documentation

- docs: Add author information to example.qmd.
- docs: Add output section for example.qmd in README.

## 1.1.0 (2025-10-24)

### Refactoring

- refactor: Enhance collapse-output extension (#17).

## 1.0.0 (2025-10-09)

### Bug Fixes

- fix: Remove print to have a formatted table output.
