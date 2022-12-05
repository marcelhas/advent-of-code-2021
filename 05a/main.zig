const std = @import("std");

const Args = std.os.arg;
const ArrayList = std.ArrayList;
const File = std.fs.File;
const Math = std.math;
const Mem = std.mem;

const Value = u10;
const FromTo = struct { x1: Value, y1: Value, x2: Value, y2: Value };
const List = ArrayList(FromTo);
const MATRIX_SIZE = 999;
const Matrix = [MATRIX_SIZE][MATRIX_SIZE]Value;

pub fn main() !void {
    // Handle commandline arguments.
    // See <https://zigbyexample.github.io/command_line_arguments>.
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var file: File = undefined;
    defer file.close();
    if (args.len > 1) {
        file = try std.fs.cwd().openFile(args[1], .{});
    } else {
        file = std.io.getStdIn();
    }

    const list = try toList(file);
    defer list.deinit();
    const matrix = toMatrix(list);
    const result = countCrosses(matrix);
    std.debug.print("{}\n", .{result});
}

fn toList(file: File) !List {
    var buf_reader = std.io.bufferedReader(file.reader());
    var stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;

    var res = ArrayList(FromTo).init(std.heap.page_allocator);
    while (try stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const ft = try parseLine(line);

        // Skip if neither horizontal nor vertical.
        if (ft.x1 != ft.x2 and ft.y1 != ft.y2)
            continue;

        try res.append(ft);
    }
    return res;
}

fn parseLine(line: []const u8) !FromTo {
    var s = Mem.split(u8, line, " -> ");

    const lft = try parseSide(s.first());
    const rgt = try parseSide(s.next().?);

    if (lft.x <= rgt.x and lft.y <= rgt.y) {
        return FromTo{ .x1 = lft.x, .y1 = lft.y, .x2 = rgt.x, .y2 = rgt.y };
    } else {
        return FromTo{ .x1 = rgt.x, .y1 = rgt.y, .x2 = lft.x, .y2 = lft.y };
    }
}

fn parseSide(line: []const u8) !struct { x: Value, y: Value } {
    var s = Mem.split(u8, line, ",");
    const x = try std.fmt.parseInt(Value, s.first(), 10);
    const y = try std.fmt.parseInt(Value, s.next().?, 10);
    return .{ .x = x, .y = y };
}

fn toMatrix(list: List) Matrix {
    // Init MATRIX_SIZExMATRIX_SIZE matrix with zeros.
    var matrix = Mem.zeroes(Matrix);
    for (list.items) |val| {
        var x = val.x1;
        while (x <= val.x2) {
            var y = val.y1;
            while (y <= val.y2) {
                matrix[x][y] += 1;
                y += 1;
            }
            x += 1;
        }
    }
    return matrix;
}

fn countCrosses(matrix: Matrix) u32 {
    var crosses: u32 = 0;
    for (matrix) |col| {
        for (col) |val| {
            if (val > 1) {
                crosses += 1;
            }
        }
    }
    return crosses;
}
