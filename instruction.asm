addi $s0, $zero, 10
add $s3, $zero, $s0
init: beq $s1, $s0, exit

addi $s1, $s1, 1

j init

exit: addi $s2, $zero, 0


