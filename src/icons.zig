const std = @import("std");

/// コードポイントは nerdfont Python パッケージで検証済み
pub const Icon = struct {
    glyph: []const u8,
    color: ?[]const u8,
};

pub const icon_dir:     Icon = .{ .glyph = "\u{f07b} ", .color = "\x1b[1;34m" }; // nf-fa-folder
pub const icon_dir_open:Icon = .{ .glyph = "\u{f07c} ", .color = "\x1b[1;34m" }; // nf-fa-folder_open
pub const icon_default: Icon = .{ .glyph = "\u{f15b} ", .color = null };           // nf-fa-file

// ─── File extension table ───────────────────────────────────────
const ExtEntry = struct { ext: []const u8, icon: Icon };

const ext_table = [_]ExtEntry{
    // --- Zig ---
    .{ .ext = "zig",  .icon = .{ .glyph = "\u{e6a9} ", .color = "\x1b[33m" } }, // nf-seti-zig
    .{ .ext = "zon",  .icon = .{ .glyph = "\u{e6a9} ", .color = "\x1b[33m" } }, // nf-seti-zig

    // --- C / C++ ---
    .{ .ext = "c",    .icon = .{ .glyph = "\u{e61e} ", .color = "\x1b[34m" } }, // nf-custom-c
    .{ .ext = "h",    .icon = .{ .glyph = "\u{e61e} ", .color = "\x1b[36m" } }, // nf-custom-c
    .{ .ext = "cpp",  .icon = .{ .glyph = "\u{e61d} ", .color = "\x1b[34m" } }, // nf-custom-cpp
    .{ .ext = "cc",   .icon = .{ .glyph = "\u{e61d} ", .color = "\x1b[34m" } }, // nf-custom-cpp
    .{ .ext = "hpp",  .icon = .{ .glyph = "\u{e61d} ", .color = "\x1b[36m" } }, // nf-custom-cpp

    // --- Rust ---
    .{ .ext = "rs",   .icon = .{ .glyph = "\u{e7a8} ", .color = "\x1b[91m" } }, // nf-dev-rust

    // --- Python ---
    .{ .ext = "py",   .icon = .{ .glyph = "\u{e606} ", .color = "\x1b[33m" } }, // nf-seti-python
    .{ .ext = "pyi",  .icon = .{ .glyph = "\u{e606} ", .color = "\x1b[33m" } },

    // --- Ruby ---
    .{ .ext = "rb",   .icon = .{ .glyph = "\u{e739} ", .color = "\x1b[31m" } }, // nf-dev-ruby
    .{ .ext = "erb",  .icon = .{ .glyph = "\u{e739} ", .color = "\x1b[31m" } },

    // --- Shell ---
    .{ .ext = "sh",   .icon = .{ .glyph = "\u{e795} ", .color = "\x1b[32m" } }, // nf-dev-terminal
    .{ .ext = "bash", .icon = .{ .glyph = "\u{e795} ", .color = "\x1b[32m" } },
    .{ .ext = "zsh",  .icon = .{ .glyph = "\u{e795} ", .color = "\x1b[32m" } },
    .{ .ext = "fish", .icon = .{ .glyph = "\u{e795} ", .color = "\x1b[32m" } },

    // --- JavaScript / TypeScript ---
    .{ .ext = "js",   .icon = .{ .glyph = "\u{e781} ", .color = "\x1b[33m" } }, // nf-dev-javascript
    .{ .ext = "mjs",  .icon = .{ .glyph = "\u{e781} ", .color = "\x1b[33m" } },
    .{ .ext = "cjs",  .icon = .{ .glyph = "\u{e781} ", .color = "\x1b[33m" } },
    .{ .ext = "ts",   .icon = .{ .glyph = "\u{e628} ", .color = "\x1b[34m" } }, // nf-seti-typescript
    .{ .ext = "jsx",  .icon = .{ .glyph = "\u{e7ba} ", .color = "\x1b[36m" } }, // nf-dev-react
    .{ .ext = "tsx",  .icon = .{ .glyph = "\u{e7ba} ", .color = "\x1b[34m" } }, // nf-dev-react

    // --- Web ---
    .{ .ext = "html", .icon = .{ .glyph = "\u{e736} ", .color = "\x1b[91m" } }, // nf-dev-html5
    .{ .ext = "htm",  .icon = .{ .glyph = "\u{e736} ", .color = "\x1b[91m" } },
    .{ .ext = "css",  .icon = .{ .glyph = "\u{e749} ", .color = "\x1b[35m" } }, // nf-dev-css3
    .{ .ext = "scss", .icon = .{ .glyph = "\u{e749} ", .color = "\x1b[35m" } },
    .{ .ext = "sass", .icon = .{ .glyph = "\u{e749} ", .color = "\x1b[35m" } },
    .{ .ext = "vue",  .icon = .{ .glyph = "\u{e8dc} ", .color = "\x1b[32m" } }, // nf-dev-vuejs
    .{ .ext = "svelte",.icon= .{ .glyph = "\u{e697} ", .color = "\x1b[91m" } }, // nf-seti-svelte

    // --- Go ---
    .{ .ext = "go",   .icon = .{ .glyph = "\u{e724} ", .color = "\x1b[36m" } }, // nf-dev-go

    // --- Java / Kotlin / Scala ---
    .{ .ext = "java", .icon = .{ .glyph = "\u{e738} ", .color = "\x1b[31m" } }, // nf-dev-java
    .{ .ext = "class",.icon = .{ .glyph = "\u{e738} ", .color = "\x1b[31m" } },
    .{ .ext = "kt",   .icon = .{ .glyph = "\u{e81b} ", .color = "\x1b[35m" } }, // nf-dev-kotlin
    .{ .ext = "kts",  .icon = .{ .glyph = "\u{e81b} ", .color = "\x1b[35m" } },
    .{ .ext = "scala",.icon = .{ .glyph = "\u{e737} ", .color = "\x1b[31m" } }, // nf-dev-scala

    // --- PHP ---
    .{ .ext = "php",  .icon = .{ .glyph = "\u{e73d} ", .color = "\x1b[35m" } }, // nf-dev-php

    // --- Swift ---
    .{ .ext = "swift",.icon = .{ .glyph = "\u{e755} ", .color = "\x1b[91m" } }, // nf-dev-swift

    // --- Haskell ---
    .{ .ext = "hs",   .icon = .{ .glyph = "\u{e777} ", .color = "\x1b[35m" } }, // nf-dev-haskell
    .{ .ext = "lhs",  .icon = .{ .glyph = "\u{e777} ", .color = "\x1b[35m" } },

    // --- Lua ---
    .{ .ext = "lua",  .icon = .{ .glyph = "\u{e620} ", .color = "\x1b[34m" } }, // nf-seti-lua

    // --- Elixir ---
    .{ .ext = "ex",   .icon = .{ .glyph = "\u{e62d} ", .color = "\x1b[35m" } }, // nf-custom-elixir
    .{ .ext = "exs",  .icon = .{ .glyph = "\u{e62d} ", .color = "\x1b[35m" } },

    // --- R ---
    .{ .ext = "r",    .icon = .{ .glyph = "\u{e881} ", .color = "\x1b[34m" } }, // nf-dev-r
    .{ .ext = "rmd",  .icon = .{ .glyph = "\u{e881} ", .color = "\x1b[34m" } },

    // --- データ・設定 ---
    .{ .ext = "json", .icon = .{ .glyph = "\u{e60b} ", .color = "\x1b[33m" } }, // nf-seti-json
    .{ .ext = "yaml", .icon = .{ .glyph = "\u{e615} ", .color = "\x1b[31m" } }, // nf-seti-config
    .{ .ext = "yml",  .icon = .{ .glyph = "\u{e615} ", .color = "\x1b[31m" } },
    .{ .ext = "toml", .icon = .{ .glyph = "\u{e615} ", .color = "\x1b[33m" } },
    .{ .ext = "xml",  .icon = .{ .glyph = "\u{e60b} ", .color = "\x1b[33m" } },
    .{ .ext = "csv",  .icon = .{ .glyph = "\u{f0ce} ", .color = "\x1b[32m" } }, // nf-fa-table
    .{ .ext = "sql",  .icon = .{ .glyph = "\u{e706} ", .color = "\x1b[34m" } }, // nf-dev-database
    .{ .ext = "db",   .icon = .{ .glyph = "\u{e706} ", .color = "\x1b[34m" } },

    // --- ドキュメント ---
    .{ .ext = "md",   .icon = .{ .glyph = "\u{e73e} ", .color = "\x1b[37m" } }, // nf-dev-markdown
    .{ .ext = "mdx",  .icon = .{ .glyph = "\u{e73e} ", .color = "\x1b[37m" } },
    .{ .ext = "txt",  .icon = .{ .glyph = "\u{f15c} ", .color = "\x1b[37m" } }, // nf-fa-file_text
    .{ .ext = "pdf",  .icon = .{ .glyph = "\u{eaeb} ", .color = "\x1b[31m" } }, // nf-cod-file_pdf
    .{ .ext = "doc",  .icon = .{ .glyph = "\u{f1c2} ", .color = "\x1b[34m" } }, // nf-fa-file_word_o
    .{ .ext = "docx", .icon = .{ .glyph = "\u{f1c2} ", .color = "\x1b[34m" } },

    // --- 画像 ---
    .{ .ext = "png",  .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[35m" } }, // nf-fa-image
    .{ .ext = "jpg",  .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[35m" } },
    .{ .ext = "jpeg", .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[35m" } },
    .{ .ext = "gif",  .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[35m" } },
    .{ .ext = "svg",  .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[33m" } },
    .{ .ext = "webp", .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[35m" } },
    .{ .ext = "ico",  .icon = .{ .glyph = "\u{f03e} ", .color = "\x1b[33m" } },

    // --- 動画 ---
    .{ .ext = "mp4",  .icon = .{ .glyph = "\u{f03d} ", .color = "\x1b[36m" } }, // nf-fa-video_camera
    .{ .ext = "mov",  .icon = .{ .glyph = "\u{f03d} ", .color = "\x1b[36m" } },
    .{ .ext = "avi",  .icon = .{ .glyph = "\u{f03d} ", .color = "\x1b[36m" } },
    .{ .ext = "mkv",  .icon = .{ .glyph = "\u{f03d} ", .color = "\x1b[36m" } },

    // --- 音声 ---
    .{ .ext = "mp3",  .icon = .{ .glyph = "\u{f001} ", .color = "\x1b[35m" } }, // nf-fa-music
    .{ .ext = "wav",  .icon = .{ .glyph = "\u{f001} ", .color = "\x1b[35m" } },
    .{ .ext = "flac", .icon = .{ .glyph = "\u{f001} ", .color = "\x1b[35m" } },
    .{ .ext = "ogg",  .icon = .{ .glyph = "\u{f001} ", .color = "\x1b[35m" } },

    // --- アーカイブ ---
    .{ .ext = "zip",  .icon = .{ .glyph = "\u{f1c6} ", .color = "\x1b[33m" } }, // nf-fa-file_archive_o
    .{ .ext = "tar",  .icon = .{ .glyph = "\u{f1c6} ", .color = "\x1b[33m" } },
    .{ .ext = "gz",   .icon = .{ .glyph = "\u{f1c6} ", .color = "\x1b[33m" } },
    .{ .ext = "xz",   .icon = .{ .glyph = "\u{f1c6} ", .color = "\x1b[33m" } },
    .{ .ext = "7z",   .icon = .{ .glyph = "\u{f1c6} ", .color = "\x1b[33m" } },
    .{ .ext = "bz2",  .icon = .{ .glyph = "\u{f1c6} ", .color = "\x1b[33m" } },

    // --- バイナリ・ライブラリ ---
    .{ .ext = "exe",  .icon = .{ .glyph = "\u{f17a} ", .color = "\x1b[32m" } }, // nf-fa-windows
    .{ .ext = "so",   .icon = .{ .glyph = "\u{f471} ", .color = "\x1b[33m" } }, // nf-oct-file_binary
    .{ .ext = "a",    .icon = .{ .glyph = "\u{f471} ", .color = "\x1b[33m" } },
    .{ .ext = "dylib",.icon = .{ .glyph = "\u{f471} ", .color = "\x1b[33m" } },
    .{ .ext = "dll",  .icon = .{ .glyph = "\u{f471} ", .color = "\x1b[33m" } },

    // --- ロック・依存 ---
    .{ .ext = "lock", .icon = .{ .glyph = "\u{f023} ", .color = "\x1b[37m" } }, // nf-fa-lock

    // --- 環境・設定 ---
    .{ .ext = "env",  .icon = .{ .glyph = "\u{f013} ", .color = "\x1b[33m" } }, // nf-fa-gear
    .{ .ext = "ini",  .icon = .{ .glyph = "\u{e615} ", .color = "\x1b[37m" } }, // nf-seti-config
    .{ .ext = "conf", .icon = .{ .glyph = "\u{e615} ", .color = "\x1b[37m" } },
    .{ .ext = "cfg",  .icon = .{ .glyph = "\u{e615} ", .color = "\x1b[37m" } },
    .{ .ext = "vim",  .icon = .{ .glyph = "\u{e62b} ", .color = "\x1b[32m" } }, // nf-custom-vim
};

const SpecialEntry = struct { name: []const u8, icon: Icon };

const special_table = [_]SpecialEntry{
    .{ .name = "Makefile",       .icon = .{ .glyph = "\u{e673} ", .color = "\x1b[31m" } }, // nf-seti-makefile
    .{ .name = "makefile",       .icon = .{ .glyph = "\u{e673} ", .color = "\x1b[31m" } },
    .{ .name = "GNUmakefile",    .icon = .{ .glyph = "\u{e673} ", .color = "\x1b[31m" } },
    .{ .name = "Dockerfile",     .icon = .{ .glyph = "\u{e7b0} ", .color = "\x1b[34m" } }, // nf-dev-docker
    .{ .name = "LICENSE",        .icon = .{ .glyph = "\u{f0a3} ", .color = "\x1b[33m" } }, // nf-fa-certificate
    .{ .name = "LICENSE.md",     .icon = .{ .glyph = "\u{f0a3} ", .color = "\x1b[33m" } },
    .{ .name = "README",         .icon = .{ .glyph = "\u{e73e} ", .color = "\x1b[36m" } }, // nf-dev-markdown
    .{ .name = "README.md",      .icon = .{ .glyph = "\u{e73e} ", .color = "\x1b[36m" } },
    .{ .name = ".gitignore",     .icon = .{ .glyph = "\u{e702} ", .color = "\x1b[91m" } }, // nf-dev-git
    .{ .name = ".gitattributes", .icon = .{ .glyph = "\u{e702} ", .color = "\x1b[91m" } },
    .{ .name = ".gitmodules",    .icon = .{ .glyph = "\u{e702} ", .color = "\x1b[91m" } },
    .{ .name = ".env",           .icon = .{ .glyph = "\u{f013} ", .color = "\x1b[33m" } }, // nf-fa-gear
    .{ .name = ".env.local",     .icon = .{ .glyph = "\u{f013} ", .color = "\x1b[33m" } },
    .{ .name = "go.mod",         .icon = .{ .glyph = "\u{e724} ", .color = "\x1b[36m" } }, // nf-dev-go
    .{ .name = "go.sum",         .icon = .{ .glyph = "\u{e724} ", .color = "\x1b[36m" } },
    .{ .name = "Cargo.toml",     .icon = .{ .glyph = "\u{e7a8} ", .color = "\x1b[91m" } }, // nf-dev-rust
    .{ .name = "Cargo.lock",     .icon = .{ .glyph = "\u{e7a8} ", .color = "\x1b[91m" } },
    .{ .name = "build.zig",      .icon = .{ .glyph = "\u{e6a9} ", .color = "\x1b[33m" } }, // nf-seti-zig
    .{ .name = "build.zig.zon",  .icon = .{ .glyph = "\u{e6a9} ", .color = "\x1b[33m" } },
    .{ .name = "package.json",   .icon = .{ .glyph = "\u{e71e} ", .color = "\x1b[33m" } }, // nf-dev-npm
    .{ .name = "package-lock.json",.icon=.{ .glyph = "\u{e71e} ", .color = "\x1b[37m" } },
    .{ .name = "tsconfig.json",  .icon = .{ .glyph = "\u{e628} ", .color = "\x1b[34m" } }, // nf-seti-typescript
    .{ .name = ".vimrc",         .icon = .{ .glyph = "\u{e62b} ", .color = "\x1b[32m" } }, // nf-custom-vim
    .{ .name = ".nvimrc",        .icon = .{ .glyph = "\u{e62b} ", .color = "\x1b[32m" } },
};

// ─── Public API ─────────────────────────────────────────────
pub fn getIcon(filename: []const u8) Icon {
    for (special_table) |s| {
        if (std.mem.eql(u8, s.name, filename)) return s.icon;
    }

    const ext = getExtension(filename) orelse return icon_default;
    for (ext_table) |entry| {
        if (std.ascii.eqlIgnoreCase(entry.ext, ext)) return entry.icon;
    }

    return icon_default;
}

/// "foo.tar.gz" → "gz"、"foo.zig" → "zig"、".foo" → null
fn getExtension(filename: []const u8) ?[]const u8 {
    var i: usize = filename.len;
    while (i > 0) {
        i -= 1;
        if (filename[i] == '.') {
            if (i == 0) return null;
            return filename[i + 1 ..];
        }
    }
    return null;
}
