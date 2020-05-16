import options,streams,struct,typetraits,sequtils,typeinfo
export streams
type BufferEncoding = distinct string
type Buffer* = ref object of StringStream
  poolSize*:int  ## This is the number of bytes used to determine the size of pre-allocated, internal Buffer instances used for pooling. This value may be modified.

# proc `from`*[T](self:typedesc[Buffer],arrayBuffer:seq[T],byteOffset=none(int),length=none(int)): Buffer 
#   ## When passed a reference to the .buffer property of a TypedArray instance,
#   ## the newly created Buffer will share the same allocated memory as the TypedArray.
#   ## The optional {byteOffset} and {length} arguments specify a memory range
#   ## within the {arrayBuffer} that will be shared by the Buffer.
#   ## @param arrayBuffer The .buffer property of any TypedArray or a new ArrayBuffer()


proc `from`*(self:typedesc[Buffer],data:openarray[SomeInteger]): Buffer = 
  ## Creates a new Buffer using the passed {data}
  ## @param data data to create a new Buffer
  result = cast[Buffer](newStringStream())
  for x in data:
    result.write x.uint8
  result.setPosition 0

# # proc `from`*(self:typedesc[Buffer],data:seq[uint8]): Buffer 

# proc `from`*[T](self:typedesc[Buffer],obj:T,byteOffset=none(int),length=none(int)): Buffer =
#   ## Creates a new buffer containing the coerced value of an object
#   ## A `TypeError` will be thrown if {obj} has not mentioned methods or is not of other type appropriate for `Buffer.from()` variants.
#   ## @param obj An object supporting `Symbol.toPrimitive` or `valueOf()`.
#   result = cast[Buffer](newStringStream())
#   result.write obj
#   result.setPosition 0

proc `from`*(self:typedesc[Buffer],str:string,encoding=none(BufferEncoding)): Buffer =
  ## Creates a new Buffer containing the given JavaScript string {str}.
  ## If provided, the {encoding} parameter identifies the character encoding.
  ## If not provided, {encoding} defaults to 'utf8'.
  result = cast[Buffer](newStringStream(str))
  result.setPosition 0


# proc `of`*(self:typedesc[Buffer],items:seq[int]): Buffer 
#   ## Creates a new Buffer using the passed {data}
#   ## @param values to create a new Buffer


# proc isBuffer*(self:typedesc[Buffer],obj:any): bool 
#   ## Returns true if {obj} is a Buffer
#   ## @param obj object to test.


# # proc isEncoding*(self:typedesc[Buffer],encoding:string): auto 
#   ## Returns true if {encoding} is a valid encoding argument.
#   ## Valid string encodings in Node 0.12: 'ascii'|'utf8'|'utf16le'|'ucs2'(alias of 'utf16le')|'base64'|'binary'(deprecated)|'hex'
#   ## @param encoding string to test.


# # proc byteLength*(self:typedesc[Buffer],str:string,encoding=none(BufferEncoding)): int 
#   ## Gives the actual byte length of a string. encoding defaults to 'utf8'.
#   ## This is not the same as String.prototype.length since that returns the number of characters in a string.
#   ## @param str string to test.
#   ## @param encoding encoding used to evaluate (defaults to 'utf8')


# proc concat*(self:typedesc[Buffer],list:seq[seq[uint8]],totalLength=none(int)): Buffer 
#   ## Returns a buffer which is the result of concatenating all the buffers in the list together.
#   ## If the list has no items, or if the totalLength is 0, then it returns a zero-length buffer.
#   ## If the list has exactly one item, then the first item of the list is returned.
#   ## If the list has more than one item, then a new Buffer is created.
#   ## @param list An array of Buffer objects to concatenate
#   ## @param totalLength Total length of the buffers when concatenated.
#   ## If totalLength is not provided, it is read from the buffers in the list. However, this adds an additional loop to the function, so it is faster to provide the length explicitly.


# proc compare*(self:typedesc[Buffer],buf1:seq[uint8],buf2:seq[uint8]): int 
#   ## The same as buf1.compare(buf2).

# encoding=none(BufferEncoding)
proc alloc*(self:typedesc[Buffer],size:int,fill = none(string)): Buffer =
  ## Allocates a new buffer of {size} octets.
  ## @param size count of octets to allocate.
  ## @param fill if specified, buffer will be initialized by calling buf.fill(fill).
  ## If parameter is omitted, buffer will be filled with zeros.
  ## @param encoding encoding used for call to buf.fill while initalizing
  result = cast[Buffer](newStringStream())

  var i = 0
  var init = newStringOfCap(size)
  let hasFill = fill.isSome
  while i < size:
    init.add if hasFill : fill.get else : "\0"
    inc i
  result.write init
  result.setPosition 0


# proc allocUnsafe*(self:typedesc[Buffer],size:int): Buffer 
#   ## Allocates a new buffer of {size} octets, leaving memory not initialized, so the contents
#   ## of the newly created Buffer are unknown and may contain sensitive data.
#   ## @param size count of octets to allocate


# proc allocUnsafeSlow*(self:typedesc[Buffer],size:int): Buffer 
#   ## Allocates a new non-pooled buffer of {size} octets, leaving memory not initialized, so the contents
#   ## of the newly created Buffer are unknown and may contain sensitive data.
#   ## @param size count of octets to allocate


# # proc write*(self:Buffer,string:string,encoding=none(BufferEncoding)): int 

# # proc write*(self:Buffer,string:string,offset:int,encoding=none(BufferEncoding)): int 

# # proc write*(self:Buffer,string:string,offset:int,length:int,encoding=none(BufferEncoding)): int 

# # proc toString*(self:Buffer,encoding=none(BufferEncoding),start=none(int),`end`=none(int)): string 

# # proc toJSON*(self:Buffer): auto 

# proc equals*(self:Buffer,otherBuffer:seq[char]): bool 

# proc compare*(self:Buffer,otherBuffer:seq[char],targetStart=none(int),targetEnd=none(int),sourceStart=none(int),sourceEnd=none(int)): int 

# proc copy*(self:Buffer,targetBuffer:seq[char],targetStart=none(int),sourceStart=none(int),sourceEnd=none(int)): int 

# proc slice*(self:Buffer,begin=none(int),`end`=none(int)): Buffer 
#   ## Returns a new `Buffer` that references **the same memory as the original**, but offset and cropped by the start and end indices.
#   ## This method is incompatible with `seq[char]#slice()`, which returns a copy of the original memory.
#   ## @param begin Where the new `Buffer` will start. Default: `0`.
#   ## @param end Where the new `Buffer` will end (not inclusive). Default: `buf.length`.


# proc subarray*(self:Buffer,begin=none(int),`end`=none(int)): Buffer 
  ## Returns a new `Buffer` that references **the same memory as the original**, but offset and cropped by the start and end indices.
  ## This method is compatible with `Uint8Array#subarray()`.
  ## @param begin Where the new `Buffer` will start. Default: `0`.
  ## @param end Where the new `Buffer` will end (not inclusive). Default: `buf.length`.


# proc writeUIntLE*(self:Buffer,value:int,offset:int,byteLength:int): int 

# proc writeUIntBE*(self:Buffer,value:int,offset:int,byteLength:int): int 

# proc writeIntLE*(self:Buffer,value:int,offset:int,byteLength:int): int 

# proc writeIntBE*(self:Buffer,value:int,offset:int,byteLength:int): int 

# proc readUIntLE*(self:Buffer,offset:int,byteLength:int): int 

# proc readUIntBE*(self:Buffer,offset:int,byteLength:int): int 

# proc readIntLE*(self:Buffer,offset:int,byteLength:int): int 

# proc readIntBE*(self:Buffer,offset:int,byteLength:int): int 

proc readUInt8*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: char
  self.readData buffer.addr,sizeof(buffer) 

proc readUInt16LE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: uint16
  self.read(buffer)
  var data = extract16(buffer,littleEndian)
  cast[int](data)

proc readUInt16BE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: uint16
  self.read(buffer)
  var data = extract16(buffer,bigEndian)
  cast[int](data)

proc readUInt32LE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: uint32
  self.read(buffer)
  var data = extract32(buffer,littleEndian)
  cast[int](data)

proc readUInt32BE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: uint32
  self.read(buffer)
  var data = extract32(buffer,bigEndian)
  cast[int](data)
  

proc readInt8*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: int8
  self.read(buffer)
  cast[int](buffer)

proc readInt16LE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: int16
  self.read(buffer)
  var data = extract16(buffer,littleEndian)
  cast[int](data)

proc readInt16BE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: int16
  self.read(buffer)
  var data = extract16(buffer,bigEndian)
  cast[int](data)

proc readInt32LE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: int32
  self.read(buffer)
  var data = extract32(buffer,littleEndian)
  cast[int32](data)

proc readInt32BE*(self:Buffer,offset=none(int)): int =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: int32
  self.read(buffer)
  var data = extract32(buffer,bigEndian)
  cast[int32](data)

proc readFloatLE*(self:Buffer,offset=none(int)): float32 =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: float32
  self.read(buffer)
  var data = extract32(buffer,littleEndian)
  cast[float32](data)

proc readFloatBE*(self:Buffer,offset=none(int)): float32 =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: float32
  self.read(buffer)
  var data = extract32(buffer,bigEndian)
  cast[float32](data) 

proc readDoubleLE*(self:Buffer,offset=none(int)): cdouble {.discardable.} =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: cdouble
  self.read(buffer)
  var data = extract64(buffer,littleEndian)
  cast[cdouble](data) 

proc readDoubleBE*(self:Buffer,offset=none(int)): cdouble {.discardable.} =
  if offset.isSome():
    self.setPosition(offset.get())
  else :
    self.setPosition(0)
  var buffer: cdouble
  self.read(buffer)
  var data = extract64(buffer,bigEndian)
  cast[cdouble](data) 
# no 
# proc reverse*(self:Buffer): auto 

# proc swap16*(self:Buffer): Buffer 

# proc swap32*(self:Buffer): Buffer 

# proc swap64*(self:Buffer): Buffer 

proc writeUInt8*(self:Buffer,value:int,offset=none(int)): int {.discardable.} =
  if offset.isSome():
    self.setPosition(offset.get())
  self.write value.uint8
  sizeof(value.uint8)

proc writeUInt16LE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_16(value.uint16,littleEndian)
  sizeof(value.uint16)

proc writeUInt16BE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_16(value.uint16, bigEndian)
  sizeof(value.uint16)

proc writeUInt32LE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}= 
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_32(value.uint32,littleEndian)
  sizeof(value.uint32)

proc writeUInt32BE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_32(value.uint32,bigEndian)
  sizeof(value.uint32)

proc writeInt8*(self:Buffer,value:int,offset=none(int)): int {.discardable.} =
  if offset.isSome():
    self.setPosition(offset.get())
  self.write value.uint8
  sizeof(value.uint8)

proc writeInt16LE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_16(value.int16,littleEndian)
  sizeof(value.int16)

proc writeInt16BE*(self:Buffer,value:int,offset=none(int)): int{.discardable.} =
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_16(value.int16,bigEndian)
  sizeof(value.int16)

proc writeInt32LE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_32(value.int32,littleEndian)
  sizeof(value.int32)

proc writeInt32BE*(self:Buffer,value:int,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_32(value.int32,bigEndian)
  sizeof(value.int32)

proc writeFloatLE*(self:Buffer,value:float32,offset=none(int)): int {.discardable.} =
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_32(value.float32,littleEndian)
  self.setPosition(0)
  sizeof(value.float32)

proc writeFloatBE*(self:Buffer,value:float32,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_32(value.float32,bigEndian)
  sizeof(value.float32)

proc writeDoubleLE*(self:Buffer,value:cdouble,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_64(value.cdouble,littleEndian)
  sizeof(value.cdouble)

proc writeDoubleBE*(self:Buffer,value:cdouble,offset=none(int)): int {.discardable.}=
  if offset.isSome():
    self.setPosition(offset.get())
  self.write extract_64(value.cdouble,bigEndian)
  sizeof(value.cdouble)
  
# proc fill*[T](self:Buffer,value:T,offset=none(int),`end`=none(int),encoding=none(BufferEncoding)): auto 

# proc indexOf*[T](self:Buffer,value:T,byteOffset=none(int),encoding=none(BufferEncoding)): int 

# proc lastIndexOf*[T](self:Buffer,value:T,byteOffset=none(int),encoding=none(BufferEncoding)): int 

# proc entries*(self:Buffer): IterableIterator[(int,int)] 

# proc includes*[T](self:Buffer,value:T,byteOffset=none(int),encoding=none(BufferEncoding)): bool 

# proc keys*(self:Buffer): IterableIterator[int] 

# proc values*(self:Buffer): IterableIterator[int] 