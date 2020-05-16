import unittest
import options
import buffer

suite "from":
    test "array of uint8":
      var buf = Buffer.from([1'u8, 2'u8, 3'u8, 4'u8, 5'u8, 6'u8, 7'u8, 8'u8]);
      check buf.readDoubleBE == 8.20788039913184e-304
    test "array of int":
      var buf = Buffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
      check buf.readDoubleBE == 8.20788039913184e-304