const std = @import("std");
const config_mod = @import("config.zig");
const tree = @import("tree.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stdout_buf: [65536]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buf);
    const stdout = &stdout_writer.interface;
    defer stdout.flush() catch {};

    var stderr_buf: [1024]u8 = undefined;
    var stderr_writer = std.fs.File.stderr().writer(&stderr_buf);
    const stderr = &stderr_writer.interface;
    defer stderr.flush() catch {};

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const result = config_mod.parseArgs(args);
    switch (result) {
        .help => {
            try printHelp(stdout);
        },
        .err => |msg| {
            try stderr.print(
                "ztree: Unknown option: {s}\nType `ztree --help` to display help\n",
                .{msg},
            );
            try stderr.flush();
            std.process.exit(1);
        },
        .config => |cfg| {
            var counter = tree.Counter{};
            try tree.printRoot(stdout, &cfg);
            try tree.printTree(allocator, stdout, cfg.target_path, "", 0, &cfg, &counter);
            try tree.printSummary(stdout, &counter, &cfg);
        },
    }
}

fn printHelp(writer: *std.Io.Writer) !void {
    try writer.print(
        \\ztree - Directory tree viewer (built with Zig)
        \\
        \\Usage:
        \\  ztree [options] [directory]
        \\
        \\Options:
        \\  -a            Show hidden files and directories
        \\  -d            Show directories only
        \\  -L <number>   Limit the display depth
        \\  --no-icons    Disable Nerd Fonts icons
        \\  --no-color    Disable colored output
        \\  -h, --help    Show this help message
        \\
        \\Examples:
        \\  ztree                     Show the current directory
        \\  ztree ~/projects          Show the specified directory
        \\  ztree -a -L 2 .           Show up to depth 2 including hidden files
        \\  ztree -d /etc             Show only directory structure of /etc
        \\  ztree --no-icons          Show without icons
        \\
        \\Notes:
        \\  Nerd Fonts is required for icon display.
        \\  https://www.nerdfonts.com/
        \\
    , .{});
}
