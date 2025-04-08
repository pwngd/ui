# Documentation

## Setup

```lua
local ui_lib = loadstring(...)()
local window = ui_lib:CreateWindow({
    name = "My UI", -- Window title
    size = UDim2.new(0.3, 0, 0.3, 0), -- Default size
    aspectRatio = 1.6, -- Window aspect ratio
    theme = ui_lib.themes.default -- (optional) Change theme
})
```

---

## Public API

### `ui_lib:CreateWindow(config)`
Creates a new UI window.

- **config** (table)
  - `name` (string) — Window name/title.
  - `size` (UDim2) — Window size.
  - `aspectRatio` (number) — Aspect ratio (width/height).
  - `theme` (table) — Theme to apply (optional).

---

### `window:CreatePage(pageConfig)`
Creates a new page (tab).

- **pageConfig** (table)
  - `name` (string) — Name of the page.

**Returns:** `Page` object

---

### `Page:CreateModule(moduleConfig)`
Creates a new module (container for inputs/buttons).

- **moduleConfig** (table)
  - `name` (string) — Module title.
  - `size` (UDim2) — (optional) Module size.

**Returns:** `Module` object

---

### `Module:CreateInput(inputConfig)`
Creates an editable or read-only text input.

- **inputConfig** (table)
  - `name` (string) — Input label.
  - `text` (string) — Default text.
  - `placeholder` (string) — Placeholder text.
  - `editable` (boolean) — If input can be edited (default: true).
  - `inputType` (string) — `"number"` to validate numeric input.

**Returns:**  
Object with:
- `.value` — Current input value.
- `.Changed:Connect(callback)` — Fired when input changes.

---

### `Module:CreateCheckbox(checkboxConfig)`
Creates a checkbox.

- **checkboxConfig** (table)
  - `name` (string) — Label.
  - `defaultState` (boolean) — (optional) Default checked state.

**Returns:**  
Object with:
- `.value` — Current checkbox state.
- `.Changed:Connect(callback)` — Fired when toggled.

---

### `Module:CreateButton(buttonConfig)`
Creates a clickable button.

- **buttonConfig** (table)
  - `name` (string) — Button text.

**Returns:**  
Object with:
- `.Changed:Connect(callback)` — Fired when button is clicked.

---

### `Module:CreateSlider(sliderConfig)`
Creates a slider.

- **sliderConfig** (table)
  - `name` (string) — Label.
  - `range` (table) — `{min, max}` (e.g., `{0, 100}`).
  - `value` (number) — Default starting value.
  - `prefix` (string) — (optional) Text after the number (e.g., "%").
  - `step` (number) — (optional) Step rounding (default: `0.01`).

**Returns:**  
Object with:
- `.value` — Current slider value.
- `.Changed:Connect(callback)` — Fired when slider value changes.

---

### `window:JumpTo(page)`
Programmatically switch to a page.

- **page** (Page object) — Target page created with `CreatePage`.

---

### `ui_lib.Destroy()`
Destroys the UI library and clears resources.

---

## Themes

You can use built-in themes:

- `ui_lib.themes.default`
- `ui_lib.themes.blue`
- `ui_lib.themes.red`
- `ui_lib.themes.green`

Or create your own by copying and editing a theme table.

---

# Example Usage

```lua
local ui = ui_lib:CreateWindow({ name = "Example" })
local mainPage = ui:CreatePage({ name = "Main" })
local mainModule = mainPage:CreateModule({ name = "Main Module" })

local input = mainModule:CreateInput({ name = "Username", placeholder = "Enter here..." })
input.Changed:Connect(function(newValue)
    print("Input changed to:", newValue)
end)

local checkbox = mainModule:CreateCheckbox({ name = "Enable feature" })
checkbox.Changed:Connect(function(state)
    print("Checkbox state:", state)
end)

local button = mainModule:CreateButton({ name = "Click Me" })
button.Changed:Connect(function()
    print("Button clicked!")
end)

local slider = mainModule:CreateSlider({ name = "Volume", range = {0, 100}, value = 50, prefix = "%" })
slider.Changed:Connect(function(value)
    print("Slider value:", value)
end)
```

---

# Notes
- Avoid duplicate page names.
- `Settings` page is created automatically.
- All `.Changed` events use `:Connect` to listen for updates.
- Themes can be merged or customized easily.
