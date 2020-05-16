import unittest
import options
import buffer


suite "alloc":
    test "writeInt8":
        var buf = Buffer.alloc(2);
        buf.writeInt8(2, some(0) );
        check buf.data == "\2\0"
    test "writeUInt8":
        var buf = Buffer.alloc(4);
        buf.writeUInt8(0x3);
        buf.writeUInt8(0x4);
        buf.writeUInt8(0x23);
        buf.writeUInt8(0x42);
        check buf.data == "\3\4#B"
    test "writeInt16BE writeInt16LE":
        var buf = Buffer.alloc(4 );
        buf.writeInt16BE(0x0102, some(0));
        buf.writeInt16LE(0x0304, some(2));
        check buf.data == "\1\2\4\3"


    test "writeInt32BE writeInt32LE":
        var buf = Buffer.alloc(4 );
        buf.writeInt32BE(5.int32, some(0));
        check buf.data == "\0\0\0\5"
        check buf.readInt32BE == 5
        check buf.readInt32LE == 83886080
        var buf2 = Buffer.alloc(4 );
        buf2.writeInt32LE(0x05060708, some(0));
        check buf2.data == "\8\7\6\5"

    test "writeFloatBE writeFloatLE":
        var buf = Buffer.alloc(4 );
        buf.writeFloatBE(0xcafebabe.float32, some(0));
        check buf.data == "\x4f\x4a\xfe\xbb"
        # check buf.readFloatBE == 0xcafebabe.float32
        buf.writeFloatLE(0xcafebabe.float32, some(0));
        check buf.data == "\xbb\xfe\x4a\x4f"
        # check buf.readFloatLE == 0xcafebabe.float32

    test "readFloatBE readFloatLE":
        var buf = Buffer.alloc(4);
        buf.write [1'u8,2'u8,3'u8,4'u8]
        buf.setPosition 0
        check buf.readFloatBE == 2.387939260590663e-38
        buf.setPosition 0
        check buf.readFloatLE == 1.539989614439558e-36

    test "readDoubleBE readDoubleLE":
        var buf = Buffer.alloc(8);
        buf.write [1'u8, 2'u8, 3'u8, 4'u8, 5'u8, 6'u8, 7'u8, 8'u8]
        buf.setPosition 0
        check buf.readDoubleBE == 8.20788039913184e-304
        buf.setPosition 0
        check buf.readDoubleLE == 5.447603722011605e-270
        buf.setPosition 0
        expect(IOError):
            buf.readDoubleLE(some(1))

    test "writeDoubleBE writeDoubleLE":
        var buf = Buffer.alloc(8);
        buf.writeDoubleBE(123.456)
        buf.setPosition 0
        check buf.data == "\x40\x5e\xdd\x2f\x1a\x9f\xbe\x77"
        buf.writeDoubleLE(123.456)
        check buf.data == "\x77\xbe\x9f\x1a\x2f\xdd\x5e\x40"