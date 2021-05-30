.data
A: .byte 2,0,3,1
.text

###############################################
#### Write assembly source code for C code:####
#### For (i = 0; i < a; i++)               ####
#### 	For (j = 0; j < b; j++)            ####
#### 		A[i] = A[i] + 5 * j + i        ####
###############################################

li x5, 4                      # a = 4
li x6, 2                      # b = 2
la x10, A                     # &A = x10
li x7, 0                      # i = 0
li x31, 5                     # x31 = 5

I_Loop:
	beq x7, x5, End_I_Loop    # if (i == a) goto End
	addi x29, x0, 0           # j = 0
J_Loop:
	beq x29, x6, End_J_Loop   # if (j == b) go to End_J_Loop
	lb x8, 0(x10)             # x8 = A[i]
	mul x30, x31, x29         # x30 = 5 * j
	add x30, x30, x8          # x30 = A[i] + 5 * j
	add x30, x30, x7          # x30 = A[i] + 5 * j + i
	sb x30, 0(x10)            # A[i] = A[i] + 5 * j + i
	addi x29, x29, 1          # j++
	j J_Loop
End_J_Loop:
	addi x7, x7, 1            # i++
	addi x10, x10, 1          # x10 = &A[i]
	j I_Loop
End_I_Loop:
	nop