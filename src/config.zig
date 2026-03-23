const std = @import("std");

pub const Config = struct {
    show_hidden: bool = false,
    max_depth: ?u32 = null,
    dirs_only: bool = false,
    show_icons: bool = true,
    no_color: bool = false,
    target_path: []const u8 = ".",
};

pub const ParseResult = union(enum) {
    config: Config,
    help,
    err: []const u8,
};


pub fn parseArgs(args: []const []const u8) ParseResult {
    var config = Config{};
    var i: usize = 1;
    
    while (i < args.len) : ( i+= 1) {
        const arg = args[i];

     if (std.mem.eql(u8, arg, "-a")) {
            config.show_hidden = true;
        } else if (std.mem.eql(u8, arg, "-d")) {
            config.dirs_only = true;
        } else if (std.mem.eql(u8, arg, "--no-icons")) {
            config.show_icons = false;
        } else if (std.mem.eql(u8, arg, "--no-color")) {
            config.no_color = true;
        } else if (std.mem.eql(u8, arg, "-L")) {
            i += 1;
            if (i >= args.len) return .{ .err = " -L requires a numeric value " };
            config.max_depth = std.fmt.parseInt(u32, args[i], 10) catch {
                return .{ .err = "The value of -L is invalid (please specify an integer)" };
            };
        } else if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            return .help;
        } else if (arg.len > 0 and arg[0] != '-') {
            config.target_path = arg;
        } else {
            return .{ .err = arg };
        }
    }

    return .{.config = config};
}
