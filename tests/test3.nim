import unittest
import buffer

suite "operators":
    test "get set":
      var buf = Buffer.from([1'u8, 2'u8, 3'u8, 4'u8, 5'u8, 6'u8, 7'u8, 8'u8]);
      echo repr buf.data
      buf[1] = '\3'
      check buf[1] == '\3'
      buf[1] = 2'u8
      check buf[1] == '\2'
    # test "array of int":
    #   var buf = Buffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
      