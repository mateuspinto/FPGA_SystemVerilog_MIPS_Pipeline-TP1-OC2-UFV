addi $s0, $zero, 10
addi $s1, $zero, 0

sw $s0,0($zero)
sw $s1,8($zero)

lw $s2,0($zero)
lw $s3,8($zero)

j exit:

init: beq $s2, $s3, exit

addi $s3, $s3, 1

j init

exit: addi $s4, $zero, 9