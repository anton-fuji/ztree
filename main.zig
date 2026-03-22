const std = @import("std");
const config_mod = @import("config.zig");
const tree = @import("tree.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const stdout = std.io.getStdOUt().writer();
    const stderr = std.getStdErr().writer();
}

