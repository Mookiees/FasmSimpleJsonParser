# <div align="center">Simple JSON parser on FASM [x86]</div>
<div align="center">Examples</div>

### - -

```
format PE GUI 4.0

entry start
include 'json_parser.asm'
include '/WIN32A.INC'

section '.data' data readable writeable
      example        db        '{"ok": 0, "okey": 123}', 0
      value          db        'ok', 0

      IOHandle       dd        ?
      IOUHandle      dd        ?

section '.code' code readable executable
start:

      call       [AllocConsole]
      test       eax, eax

      push       0
      push       1
      push       0
      push       0x00000001 or 0x00000002
      push       GENERIC_READ+GENERIC_WRITE
      call       [CreateConsoleScreenBuffer]
      mov        [_hscreenbuffer], eax

      push       eax
      call       [SetConsoleActiveScreenBuffer]

      push       value
      push       example
      call       get_int_el

      push       0
      push       0
      push       1
      push       eax
      push       [_hscreenbuffer]
      call       dword[WriteConsole]

      push       0
      call       [ExitProcess]

section '.rdata' data readable writeable
      _hscreenbuffer dd 00

section '.idata' data import readable writeable
library kernel,'kernel32.dll'
import kernel,\
         AllocConsole,                 'AllocConsole',                                  \
         ExitProcess ,                 'ExitProcess' ,                                  \
         CreateConsoleScreenBuffer,    'CreateConsoleScreenBuffer',                     \
         SetConsoleActiveScreenBuffer, 'SetConsoleActiveScreenBuffer',                  \
         WriteConsole,                 'WriteConsoleA'                                  
```

### - -
