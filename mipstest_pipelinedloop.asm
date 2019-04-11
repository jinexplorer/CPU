# mipstest_pipelined.asm
# 2017202110132@whu.edu.cn 25 March 2018
# add, sub, and, or, slt, addi, lw, sw, beq, j have been done in mipstest.asm
# sll, lui, bne, jal, ori, addu, subu, jr, srl have been done in mipstest_extended.asm
# sltu, nor are added in this test.
### Make sure the following Settings :
# Settings -> Memory Configuration -> Compact, Text at address 0
# You could use it to test if there is data hazard and control hazard.
# If successful, it should write value 12 to address 80 and 84, and register $7 should be 12

#       Assembly            Description          Address   Machine
# Test if there is data hazard 
main:   addi $2, $0, 5      # initialize $2 = 5    00      20020005
        ori  $3, $0, 12     # initialize $3 = 12   04      3403000c
        subu $1, $3, $2     # $1 = 12 - 5 = 7      08      00620823
        srl  $7, $1, 1      # $7 = 7 >> 1 = 3      0c      00013842
call_a: j    a              # jump to a            10      08000019
		nop										   14	   00000000
        or   $4, $7, $2     # $4 = (3 or 5) = 7    18      00e22025
        and  $5, $3, $4     # $5 = (12 and 7) = 4  1c      00642824
        add  $5, $5, $4     # $5 = 4 + 7 = 11      20      00a42820
        beq  $5, $7, end    # should not be taken  24      10a7001f
		nop					#					   28	   00000000
        sltu $4, $3, $4     # $4 = (12 < 7) = 0    2c      0064202b
#Test if there is control hazard
        beq  $4, $0, around # should be taken      30      10800004
		nop					#					   34	   00000000
        addi $5, $0, 0      # should not happen    38      20050000
        addi $5, $0, 0      # should not happen    3c      20050000
        addi $5, $0, 0      # should not happen    40      20050000
around: slt  $4, $7, $2     # $4 = 3 < 5 = 1       44      00e2202a
        addu $7, $4, $5     # $7 = 1 + 11 = 12     48      00853821
        sub  $7, $7, $2     # $7 = 12 - 5 = 7      4c      00e23822
        sw   $7, 68($3)     # [80] = 7             50      ac670044 101011 00011 00111 0000000001000100
        lw   $2, 80($0)     # $2 = [80] = 7        54      8c020050
        j    end            # should be taken      58      08000029
		nop					#					   5c	   00000000
        addi $2, $0, 1      # should not happen    60      20020001
a:      sll  $7, $7, 2      # $7 = 3 << 2 = 12     64      00073880
call_b: jal  b              # jump to b            68      0c00001f
		nop					#					   6c	   00000000
        addi $31,$0,24      # $31 <= 20            70      201f0018
        jr   $31            # return to call_a     74      03e00008
		nop					#					   78	   00000000
b:      lui  $1, 0xFFAA     # $1 <= 0xFFAA0000     7c      3c01ffaa
        slt  $1, $7, $1     # $1 <= 0              80      00e1082a
        bne  $1, $0, end    # should not be taken  84      14200007
		nop					#					   88	   00000000
        sub  $7, $7, $2     # $7 = 12 - 5 = 7      8c      00e23822
        srl  $7, $7, 1      # $7 = 7 >> 1 = 3      90      00073842
        nor  $1, $7, $1     # $1 = 0xFFFFFFFC      94      00e10827
        sltu $1, $1, $7     # $1 <= 0              98      0027082b
        jr   $31            # return to call_b     9c      03e00008
		nop					#					   a0	   00000000
# Test if there is load use hazard
end:    sw   $3, 84($0)     # [84] = 12            a4      ac030054
        lw   $7, 72($3)     # $7 = [84] = 12       a8  	   8c670048
		
        sw   $7, 68($3)     # [80] = 12            ac      ac670044    
        lw   $6, 68($3)     # $6 = [80] = 12       b0      8c660044
		
        add  $6, $6, $5     # $6 = 12 + 11 = 23    b4      00c53020
loop:   j    loop           # dead loop            b8      0800002e
		nop					#					   bc      00000000


# $0  = 0  # $1  = 0  # $2  = 7   # $3  = c
# $4  = 1  # $5  = b  # $6  = 17h # $7  = c
# $31  = 18h