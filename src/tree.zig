const std = @import("std");
const Config = @import("config.zig").Config;
const icons = @import("icons.zig");
const color = @import("color.zig");

const BRANCH = "├── ";
const LAST   = "└── ";
const PIPE   = "│   ";
const BLANK  = "    ";

pub const Counter = struct {
    dirs:  usize = 0,
    files: usize = 0,
};

const Entry = struct {
    name:   []u8,
    is_dir: bool,
};

pub fn printRoot(writer: *std.Io.Writer, cfg: *const Config) !void {
    const ic = icons.icon_dir;
    if (cfg.show_icons) {
        try writer.print("{s}{s}{s}{s}\n", .{
            color.maybeColor(ic.color orelse color.blue_bold, cfg.no_color),
            ic.glyph,
            cfg.target_path,
            color.maybeReset(cfg.no_color),
        });
    } else {
        try writer.print("{s}{s}{s}\n", .{
            color.maybeColor(color.blue_bold, cfg.no_color),
            cfg.target_path,
            color.maybeReset(cfg.no_color),
        });
    }
}

pub fn printTree(
    allocator: std.mem.Allocator,
    writer:    *std.Io.Writer,
    path:      []const u8,
    prefix:    []const u8,
    depth:     u32,
    cfg:       *const Config,
    counter:   *Counter,
) !void {
    if (cfg.max_depth) |max| {
        if (depth >= max) return;
    }

    var dir = std.fs.cwd().openDir(path, .{ .iterate = true }) catch |err| {
        try writer.print("{s}[Error: {}]\n", .{ prefix, err });
        return;
    };
    defer dir.close();

    var entries = std.ArrayListUnmanaged(Entry){};
    defer {
        for (entries.items) |e| allocator.free(e.name);
        entries.deinit(allocator);
    }

    var iter = dir.iterate();
    while (try iter.next()) |raw| {
        if (!cfg.show_hidden and raw.name.len > 0 and raw.name[0] == '.') continue;
        const is_dir = resolveIsDir(dir, raw);
        if (cfg.dirs_only and !is_dir) continue;
        try entries.append(allocator, .{
            .name   = try allocator.dupe(u8, raw.name),
            .is_dir = is_dir,
        });
    }

    sortEntries(entries.items);

    for (entries.items, 0..) |entry, idx| {
        const is_last   = (idx == entries.items.len - 1);
        const connector = if (is_last) LAST else BRANCH;

        const full_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ path, entry.name });
        defer allocator.free(full_path);

        try printEntry(writer, cfg, prefix, connector, entry.name, entry.is_dir);

        if (entry.is_dir) {
            counter.dirs += 1;
            const new_prefix = try std.fmt.allocPrint(
                allocator, "{s}{s}",
                .{ prefix, if (is_last) BLANK else PIPE },
            );
            defer allocator.free(new_prefix);
            try printTree(allocator, writer, full_path, new_prefix, depth + 1, cfg, counter);
        } else {
            counter.files += 1;
        }
    }
}

pub fn printSummary(writer: *std.Io.Writer, counter: *const Counter, cfg: *const Config) !void {
    try writer.print("\n{s}{d} directories, {d} files{s}\n", .{
        color.maybeColor(color.gray, cfg.no_color),
        counter.dirs,
        counter.files,
        color.maybeReset(cfg.no_color),
    });
}

fn resolveIsDir(dir: std.fs.Dir, entry: std.fs.Dir.Entry) bool {
    if (entry.kind == .directory) return true;
    if (entry.kind == .sym_link) {
        var sub = dir.openDir(entry.name, .{}) catch return false;
        sub.close();
        return true;
    }
    return false;
}

fn sortEntries(items: []Entry) void {
    std.mem.sort(Entry, items, {}, struct {
        fn lt(_: void, a: Entry, b: Entry) bool {
            if (a.is_dir != b.is_dir) return a.is_dir;
            return std.mem.lessThan(u8, a.name, b.name);
        }
    }.lt);
}

fn printEntry(
    writer:    *std.Io.Writer,
    cfg:       *const Config,
    prefix:    []const u8,
    connector: []const u8,
    name:      []const u8,
    is_dir:    bool,
) !void {
    if (is_dir) {
        const ic  = icons.icon_dir;
        const col = color.maybeColor(ic.color orelse color.blue_bold, cfg.no_color);
        const rst = color.maybeReset(cfg.no_color);
        if (cfg.show_icons) {
            try writer.print("{s}{s}{s}{s}{s}{s}\n", .{ prefix, connector, col, ic.glyph, name, rst });
        } else {
            try writer.print("{s}{s}{s}{s}{s}\n",    .{ prefix, connector, col, name, rst });
        }
    } else {
        const ic  = icons.getIcon(name);
        const col = color.maybeColor(ic.color orelse "", cfg.no_color);
        const rst = if (ic.color != null) color.maybeReset(cfg.no_color) else "";
        if (cfg.show_icons) {
            try writer.print("{s}{s}{s}{s}{s}{s}\n", .{ prefix, connector, col, ic.glyph, name, rst });
        } else {
            try writer.print("{s}{s}{s}{s}{s}\n",    .{ prefix, connector, col, name, rst });
        }
    }
}
