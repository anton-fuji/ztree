# ztree 🌲

**A fast and minimal directory tree CLI written in Zig.**  
Supports colorful output and Nerd Fonts icons.

---

## ✨ Features

- 📁 Recursive directory tree visualization
- 🎨 ANSI color support (optional)
- 🔤 Nerd Fonts icons (optional)
- ⚡ Zero-cost abstractions with Zig
- 🧩 Simple and modular design

---

## 📦 Project Structure

```
src/
├── main.zig      Entry point and help output
├── config.zig    CLI config and argument parsing
├── tree.zig      Directory traversal and rendering
├── icons.zig     Nerd Fonts icon mappings
└── color.zig     ANSI color helpers
build.zig         Build configuration
```

---

## 🚀 Getting Started

### Requirements

- Zig `0.13.0` or later  
  https://ziglang.org/download/

### Build

```bash
zig build
```

The binary will be generated at:

```bash
./zig-out/bin/ztree
```

---

## 🛠 Usage

```bash
ztree                      # Show current directory
ztree ~/projects           # Show specified directory
ztree -a                   # Include hidden files
ztree -d                   # Directories only
ztree -L 2                 # Limit depth to 2
ztree --no-icons           # Disable icons
ztree --no-color           # Disable colors
ztree -a -L 3 ~/projects   # Combined example
```

---

## 📸 Example Output

```
.
├── src
│   ├── color.zig
│   ├── config.zig
│   ├── icons.zig
│   ├── main.zig
│   └── tree.zig
└── build.zig

1 directory, 6 files
```

---

## 🎨 Icons

Icon support requires a Nerd Fonts-compatible font:

https://www.nerdfonts.com/

If your environment does not support it, use:

```bash
ztree --no-icons
```

Supported file types include:

```
.zig .rs .py .js .ts .go .c .cpp
.md .json .yaml .toml .html .css
.png .jpg .mp4 .mp3 .zip .tar
... and 50+ more
```

---

## 🧠 Internals

### `config.zig`

Handles CLI parsing and configuration.

Returns a tagged union `ParseResult`:

- `config` → valid configuration
- `help` → display help message
- `err` → invalid arguments

---

### `tree.zig`

Responsible for directory traversal and rendering.

- Recursive walking
- Sorting (directories first)
- Tree formatting via `printTree()`

---

### `icons.zig`

Maps file extensions to Nerd Fonts glyphs.

- Implemented as a `comptime` array
- Zero runtime overhead
- Supports special filenames like:
  - `Makefile`
  - `Dockerfile`
  - `.gitignore`

---

### `color.zig`

ANSI color utilities.

- Provides `maybeColor()`
- Automatically disables color when `--no-color` is set

---

## 🧪 Roadmap

- [ ] `-p` : Show full path
- [ ] `-s` : Show file size
- [ ] `--ignore <glob>` : Ignore patterns
- [ ] `-J` : JSON output
- [ ] `-H` : HTML output

---

## 📄 License

[MIT License]()
