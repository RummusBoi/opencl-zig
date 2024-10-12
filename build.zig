const std = @import("std");

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
    // use linkFramework instead of linkSystemLibrary to make it work on macos
    opencl.linkFramework("OpenCL", .{});
    opencl.addIncludePath(headers.path(""));
}
