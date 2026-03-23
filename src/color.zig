/// ANSI カラーエスケープコードのヘルパー
/// no_color モード時はすべて空文字を返す

pub const reset = "\x1b[0m";
pub const bold  = "\x1b[1m";

pub const blue_bold    = "\x1b[1;34m";
pub const cyan         = "\x1b[36m";
pub const gray         = "\x1b[90m";
pub const yellow       = "\x1b[33m";
pub const green        = "\x1b[32m";

pub inline fn maybeColor(code: []const u8, no_color: bool) []const u8 {
    return if (no_color) "" else code;
}

pub inline fn maybeReset(no_color: bool) []const u8 {
    return if (no_color) "" else reset;
}
