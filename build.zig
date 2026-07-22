const std = @import("std");
const builtin = @import("builtin");
const zbh = @import("zbh");

pub fn build(b: *std.Build) !void {
    const upstream = b.dependency("upstream", .{});
    const target = b.option([]const u8, "target", "");

    _ = try zbh.lib(b, .{
        .name = "tinyregexc",
        .target = target,
        .files = .{
            .root = upstream.path(""),
            .files = &.{
                "re.c",
            },
        },
    });
}
