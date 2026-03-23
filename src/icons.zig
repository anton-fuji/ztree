const std = @import("std");

pub const Icon = struct {
    glyph: []const u8,
    color: ?[]const u8,
};

pub const icon_dir: Icon = .{ .glyph = " ", .color = "\x1b[1;34m" }; // 青
pub const icon_dir_open: Icon = .{ .glyph = " ", .color = "\x1b[1;34m" };
pub const icon_default: Icon = .{ .glyph = " ", .color = null };

const ExtEntry = struct { ext: []const u8, icon: Icon };

const ext_table = [_]ExtEntry{
    // --- Zig ---
    .{ .ext = "zig", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "zon", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },

    // --- システム・低レイヤ ---
    .{ .ext = "c",   .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
    .{ .ext = "h",   .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
    .{ .ext = "cpp", .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
    .{ .ext = "cc",  .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
    .{ .ext = "hpp", .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
    .{ .ext = "rs",  .icon = .{ .glyph = " ", .color = "\x1b[91m" } },

    // --- スクリプト ---
    .{ .ext = "py",  .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "rb",  .icon = .{ .glyph = " ", .color = "\x1b[31m" } },
    .{ .ext = "sh",  .icon = .{ .glyph = " ", .color = "\x1b[32m" } },
    .{ .ext = "bash",.icon = .{ .glyph = " ", .color = "\x1b[32m" } },
    .{ .ext = "zsh", .icon = .{ .glyph = " ", .color = "\x1b[32m" } },
    .{ .ext = "fish",.icon = .{ .glyph = " ", .color = "\x1b[32m" } },

    // --- Web ---
    .{ .ext = "js",  .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "ts",  .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
    .{ .ext = "jsx", .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
    .{ .ext = "tsx", .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
    .{ .ext = "html",.icon = .{ .glyph = " ", .color = "\x1b[91m" } },
    .{ .ext = "css", .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "scss",.icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "vue", .icon = .{ .glyph = " ", .color = "\x1b[32m" } },
    .{ .ext = "svelte",.icon=.{ .glyph = " ", .color = "\x1b[91m" } },

    // --- JVM ---
    .{ .ext = "java",.icon = .{ .glyph = " ", .color = "\x1b[31m" } },
    .{ .ext = "kt",  .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "scala",.icon= .{ .glyph = " ", .color = "\x1b[31m" } },

    // --- Go ---
    .{ .ext = "go",  .icon = .{ .glyph = " ", .color = "\x1b[36m" } },

    // --- データ・設定 ---
    .{ .ext = "json",.icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "yaml",.icon = .{ .glyph = " ", .color = "\x1b[31m" } },
    .{ .ext = "yml", .icon = .{ .glyph = " ", .color = "\x1b[31m" } },
    .{ .ext = "toml",.icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "xml", .icon = .{ .glyph = "󰗀 ", .color = "\x1b[33m" } },
    .{ .ext = "csv", .icon = .{ .glyph = " ", .color = "\x1b[32m" } },
    .{ .ext = "sql", .icon = .{ .glyph = " ", .color = "\x1b[34m" } },

    // --- ドキュメント ---
    .{ .ext = "md",  .icon = .{ .glyph = " ", .color = "\x1b[37m" } },
    .{ .ext = "mdx", .icon = .{ .glyph = " ", .color = "\x1b[37m" } },
    .{ .ext = "txt", .icon = .{ .glyph = " ", .color = "\x1b[37m" } },
    .{ .ext = "pdf", .icon = .{ .glyph = " ", .color = "\x1b[31m" } },
    .{ .ext = "doc", .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
    .{ .ext = "docx",.icon = .{ .glyph = " ", .color = "\x1b[34m" } },

    // --- 画像 ---
    .{ .ext = "png", .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "jpg", .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "jpeg",.icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "gif", .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "svg", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "webp",.icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "ico", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },

    // --- 動画・音声 ---
    .{ .ext = "mp4", .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
    .{ .ext = "mov", .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
    .{ .ext = "mp3", .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "wav", .icon = .{ .glyph = " ", .color = "\x1b[35m" } },
    .{ .ext = "flac",.icon = .{ .glyph = " ", .color = "\x1b[35m" } },

    // --- アーカイブ ---
    .{ .ext = "zip", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "tar", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "gz",  .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "xz",  .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "7z",  .icon = .{ .glyph = " ", .color = "\x1b[33m" } },

    // --- バイナリ・実行ファイル ---
    .{ .ext = "exe", .icon = .{ .glyph = " ", .color = "\x1b[32m" } },
    .{ .ext = "so",  .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "a",   .icon = .{ .glyph = " ", .color = "\x1b[33m" } },

    // --- ロック・依存 ---
    .{ .ext = "lock",.icon = .{ .glyph = " ", .color = "\x1b[37m" } },

    // --- 環境・設定 ---
    .{ .ext = "env", .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
    .{ .ext = "gitignore",.icon=.{ .glyph = " ", .color = "\x1b[91m" } },
    .{ .ext = "dockerfile",.icon=.{.glyph= " ", .color = "\x1b[34m" } },
};

pub fn getIcon(filename: []const u8) Icon {
    const special = getSpecialIcon(filename);
    if (special) |ic| return ic;

    const ext = getExtension(filename) orelse return icon_default;

    for (ext_table) |entry| {
        if (std.ascii.eqlIgnoreCase(entry.ext, ext)) {
            return entry.icon;
        }
    }
    return icon_default;
}

/// 拡張子なし特殊ファイル名のアイコン
fn getSpecialIcon(name: []const u8) ?Icon {
    const specials = [_]struct { name: []const u8, icon: Icon }{
        .{ .name = "Makefile",    .icon = .{ .glyph = " ", .color = "\x1b[31m" } },
        .{ .name = "makefile",    .icon = .{ .glyph = " ", .color = "\x1b[31m" } },
        .{ .name = "Dockerfile",  .icon = .{ .glyph = " ", .color = "\x1b[34m" } },
        .{ .name = "LICENSE",     .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
        .{ .name = "README",      .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
        .{ .name = ".gitignore",  .icon = .{ .glyph = " ", .color = "\x1b[91m" } },
        .{ .name = ".env",        .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
        .{ .name = "go.mod",      .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
        .{ .name = "go.sum",      .icon = .{ .glyph = " ", .color = "\x1b[36m" } },
        .{ .name = "Cargo.toml",  .icon = .{ .glyph = " ", .color = "\x1b[91m" } },
        .{ .name = "Cargo.lock",  .icon = .{ .glyph = " ", .color = "\x1b[91m" } },
        .{ .name = "build.zig",   .icon = .{ .glyph = " ", .color = "\x1b[33m" } },
        .{ .name = "build.zig.zon",.icon= .{ .glyph = " ", .color = "\x1b[33m" } },
        .{ .name = "package.json",.icon = .{ .glyph = " ", .color = "\x1b[33m" } },
        .{ .name = "tsconfig.json",.icon= .{ .glyph = " ", .color = "\x1b[34m" } },
    };
    for (specials) |s| {
        if (std.mem.eql(u8, s.name, name)) return s.icon;
    }
    return null;
}

/// "foo.tar.gz" → "gz"、"foo.zig" → "zig"、"foo" → null
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
