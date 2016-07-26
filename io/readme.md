## IO functions

### Print

Takes a value of any type that's an instance of Show (meaning that we know how to represent it as a string), calls show with that value to stringify it and then outputs that string to the terminal. Basically, it's just putStrLn . show. It first runs show on a value and then feeds that to putStrLn, which returns an I/O action that will print out our value.

### getChar

is an I/O action that reads a character from the input. Thus, its type signature is getChar :: IO Char, because the result contained within the I/O action is a Char.

### when in control.monad

It takes a boolean value and an I/O action if that boolean value is True, it returns the same I/O action that we supplied to it. However, if it's False, it returns the return (),

```
import Control.Monad   

main = do  
    c <- getChar  
    when (c /= ' ') $ do  
        putChar c  
        main  
```
### sequence
Takes a list of I/O actions and returns an I/O actions that will perform those actions one after the other.

``` sequence (map print [1,2,3,4,5])  ```
