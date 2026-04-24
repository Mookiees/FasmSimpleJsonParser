;----------------------------------------------
;|              Json Text Parser
;|     Flat Assembler x86 [FASM x86] EDITION
;----------------------------------------------

section '.data' data readable writeable
     int_result         db       1024 dup(0)
     string_result      db       1024 dup(0)
     bool_result        db       1024 dup(0)
section '.code' code readable executable

get_bool_el:
      lea edi, [bool_result]
      mov ecx, 1024
      xor eax, eax
      cld
      rep stosb
; --------------------------------------------------------
;          Get Bool Element From Json String
;          esi - Full Json Element  [esp+4]
;          ebp - Bool Element       [esp+8]
; --------------------------------------------------------
      mov      esi, [esp+4*1]
      mov      ebp, [esp+4*2]
      xor      ecx, ecx

@@:
      mov      edi, 0
      inc      ecx

      mov      al, byte [esi+ecx]
      cmp      al, byte [ebp+edi]

      jne      @b
      cmp      byte [esi+ecx-1], '"'
      jne      @b

lapo:
      inc      edi
      inc      ecx
      cmp      byte [ebp+edi], 0
      je       @f
      mov      al, byte [esi+ecx]
      cmp      al, byte [ebp+edi]
      jne      @b
      je       lapo
@@:
      mov      edi, 0
      mov      al, byte[esi+ecx]
      cmp      al, '"'
      jne      lapo
      cmp      bl, 0
      jne      lapo

@@:
      inc      ecx
      mov      al, byte[esi+ecx]
      cmp      al, ":"
      je       @b
      cmp      al, " "
      je       @b
      cmp      al, ","
      je       @f
      cmp      al, "}"
      je       @f

      mov      [bool_result+edi], al
      inc      edi
      jmp      @b
@@:
      mov eax, bool_result
      retn
;-----------------------------------------------------------

get_int_el:
      lea edi, [int_result]
      mov ecx, 1024
      xor eax, eax
      cld
      rep stosb
; --------------------------------------------------------
;          Get Int Element From Json String
;          esi - Full Json Element [esp+4]
;          ebp - Int Element       [esp+8]
; --------------------------------------------------------
     mov esi, [esp+4]
     mov ebp, [esp+4*2]
     xor ecx, ecx

lapa1:
     mov      edi, 0
     inc      ecx

     mov      al, byte [esi+ecx]
     cmp      al, byte [ebp+edi]
     jne      lapa1
     cmp      byte[esi+ecx-1], '"'
     jne      lapa1
@@:
     inc      edi
     inc      ecx

     mov      al, byte [esi+ecx]
     cmp      al, byte [ebp+edi]
     je       @b
     jne      nn

nn:

     cmp      byte[ebp+edi], 0
     je       @f
     jne      lapa1
@@:
     mov      edi, -1

     cmp       byte[esi+ecx], '"'
     je        @f
     jne       lapa1

@@:
     mov       bl, 47
     inc       ecx
     mov       al, byte[esi+ecx]

     cmp       al, " "
     je        @b
     cmp       al, ":"
     je        @b
     cmp       al, ","
     je        endlet
     cmp       al, "}"
     je        endlet

lala:
     inc       bl
     cmp       al, bl
     je        resultzap
     cmp       bl, 58
     je        endlet
     jne       lala

resultzap:
     inc       edi
     mov       [int_result+edi], bl
     jmp       @b

endlet:

     mov     eax, int_result
     retn


get_el:
      lea edi, [string_result]
      mov ecx, 1024
      xor eax, eax
      cld
      rep stosb
;----------------------------------------------
;|         Get String Element from JSON
;|              esi - Full JSON
;|              ebp - String element
;-----------------------------------------------
      mov      esi, [esp+4*1]
      mov      ebp, [esp+4*2]
      xor      ecx, ecx

@@:
      mov      edi, 0
      inc      ecx

      mov      al, byte [esi+ecx]
      cmp      al, byte [ebp+edi]

      jne      @b
      cmp      byte [esi+ecx-1], '"'
      jne      @b

lapa:
      inc      edi
      inc      ecx
      cmp      byte [ebp+edi], 0
      je       @f
      mov      al, byte [esi+ecx]
      cmp      al, byte [ebp+edi]
      jne      @b
      je       lapa
@@:
      mov      al, byte[esi+ecx]
      cmp      al, '"'
      je       @f
      jne      lapa
@@:
      mov      edi, -1

      inc      ecx
@@:
      inc      ecx
      mov      al,  byte [esi+ecx]
      cmp      al,  ' '
      je       @b
      cmp      al,  '"'
      je       @f
      jne      @b

@@:
      inc      ecx
      inc      edi
      mov      al, byte[esi+ecx]
      cmp      al, '"'
      je       @f
      mov      [string_result+edi], al
      call     @b

@@:
       mov eax, string_result
       retn
                                                   
