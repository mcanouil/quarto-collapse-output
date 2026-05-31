# Collapse Output Extension For Quarto

A Quarto extension that provides the ability to collapse code cell outputs in HTML documents using collapsible `<details>` elements.

## Installation

```bash
quarto add mcanouil/quarto-collapse-output@1.4.1
```

This will install the extension under the `_extensions` subdirectory.

If you are using version control, you will want to check in this directory.

## Usage

To use the extension, add the following to your document's front matter:

```yaml
filters:
  - collapse-output
```

### Configuration

You can configure the extension using the `extensions.collapse-output` section:

```yaml
extensions:
  collapse-output:
    method: lua
    collapse-all-outputs: false
    default-open: false
    auto-collapse-size: 20
    output-types: stdout, stderr, display
    summary-template: "{type} ({lines} lines)"
    summaries:
      stdout: "Console output"
      stderr: "Warnings and errors"
```

#### Options

- **`method`** (default `lua`): Choose between server-side (`lua`) and client-side (`javascript`) rendering.
- **`collapse-all-outputs`** (default `false`): Wrap every cell output in a collapsible element. Per-cell `output-fold: false` still suppresses folding.
- **`default-open`** (default `false`): Set the initial state of the collapsible element.
- **`auto-collapse-size`** (default unset): When set, any output with at least this many lines is forced closed, regardless of `default-open`.
- **`output-types`** (default all): Restrict folding to a subset of `stdout`, `stderr`, `display`, `output`.
- **`summary-template`** (default `"{type}"`): Template used when no explicit `output-summary` is given. Supports `{type}` and `{lines}`.
- **`summaries`**: Per-output-type summary text overrides.

#### Method Option

- **`lua`** (default): Processes the collapse using Lua at build time. The output is wrapped in HTML `<details>` elements during rendering.
- **`javascript`**: Delegates the collapse to JavaScript at runtime. The JavaScript file is loaded and handles the collapse dynamically.

### Using `output-fold` Code Cell Option

To collapse output for a specific code cell, use the `output-fold: true` code cell option:

````markdown
```{language}
#| output-fold: true

# Your code here
```
````

You can also customise the summary text with the `output-summary` code cell option:

````markdown
```{language}
#| output-fold: true
#| output-summary: "Click to view results"

# Your code here
```
````

To override the global `default-open` setting per cell, use `output-open`:

````markdown
```{language}
#| output-fold: true
#| output-open: true

# Your code here
```
````

### Code Cell Options

- **`output-fold`**: Set to `true` to enable collapsing for the cell's output. Set to `false` to opt out when `collapse-all-outputs` is enabled.
- **`output-summary`**: Customise the summary text. Overrides `summary-template` and `summaries` for this cell.
- **`output-open`**: Set the initial open/closed state for this cell, overriding `default-open`.

## Use Cases

The collapse output extension is particularly useful for:

- **Long outputs**: Hide lengthy console output, tables, or plots by default.
- **Tutorial documents**: Keep code visible whilst hiding output until needed.
- **Reports**: Show results on demand without cluttering the main document.
- **Interactive exploration**: Allow readers to selectively view outputs of interest.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

Output of `example.qmd`:

- [HTML](https://m.canouil.dev/quarto-collapse-output/)

## Notes

- The `output-fold` code cell option only works with HTML output formats.
- When using the Lua method (default), the collapse is applied at build time.
- When using the JavaScript method, the collapse happens in the browser.
- The default summary text follows the configured `summary-template` (or a per-type label if `output-types` is restricted).
- Both `output-fold` and `output-summary` are code cell options (use `#|` prefix).
