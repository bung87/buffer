# buffer  

buffer module write in Nim provide api similar to Nodejs buffer module.  

note: read,write api optional param `offset` read from head, write from end  
# usage  

``` nim 
import buffer
var buf = Buffer.from([1'u8, 2'u8, 3'u8, 4'u8, 5'u8, 6'u8, 7'u8, 8'u8]);
check buf.readDoubleBE == 8.20788039913184e-304

var buf = newBuffer(2);
buf.writeInt8(2, some(0) );
check buf.data == "\2\0"
```