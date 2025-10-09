# Collapse Output Extension For Quarto

A Quarto extension that provides the ability to collapse code cell outputs in HTML documents using collapsible `<details>` elements.

## Installation

```bash
quarto add mcanouil/quarto-collapse-output
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Usage

Add the filter to your document's YAML header:

```yaml
filters:
  - collapse-output
```

### Configuration Options

You can configure the extension using the `extensions.collapse-output` section:

```yaml
extensions:
  collapse-output:
    method: lua  # or "javascript" (default: "lua")
```

#### Method Option

- **`lua`** (default): Processes the collapse using Lua at build time.
  The output is wrapped in HTML `<details>` elements during rendering.
- **`javascript`**: Delegates the collapse to JavaScript at runtime.
  The JavaScript file will be loaded and handle the collapse dynamically.

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

### Code Cell Options

- **`output-fold`**: Set to `true` to enable collapsing for the cell's output.
- **`output-summary`**: Customise the summary text (default: "Code Output").

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

Outputs of `example.qmd`:

- [HTML](https://m.canouil.dev/quarto-collapse-output/)
