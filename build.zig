const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const headers = b.dependency("opencl_headers", .{});

    const opencl = b.addModule("opencl", .{
        .root_source_file = b.path("src/opencl.zig"),
        .link_libc = true,
        .target = target,
        .optimize = optimize,
    });
    if (builtin.os.tag == .macos) {
        // use linkFramework instead of linkSystemLibrary to make it work on macos
        opencl.linkFramework("OpenCL", .{});
    } else {
        opencl.linkSystemLibrary("OpenCL");
    }

    opencl.addIncludePath(headers.path(""));
}
