.data
row: .asciiz "|-|-|-|-|-|-|\n"
numbers1: .asciiz "| 1 | 2 | 3 | 4 | 5 | 6 |\n"
numbers2: .asciiz "| 7 | 8 | 9 |10|12|14|\n"
numbers3: .asciiz "|15|16|18|20|21|24|\n"
numbers4: .asciiz "|25|27|28|30|32|35|\n"
numbers5: .asciiz "|36|40|42|45|48|59|\n"
numbers6: .asciiz "|54|56|63|64|72|81|\n"
    .text
    .globl main
main:
    li $t0, 6
    li $t1, 0  # Index for the numbers
print_row:
    beqz $t0, end_print  # Exit loop if $t0 is 0

    beq $t0, 6, print_numbers1  # Print numbers for the first row
    beq $t0, 5, print_numbers2  # Print numbers for the second row
    beq $t0, 4, print_numbers3  # Print numbers for the third row
    beq $t0, 3, print_numbers4  # Print numbers for the fourth row
    beq $t0, 2, print_numbers5  # Print numbers for the fifth row
    beq $t0, 1, print_numbers6  # Print numbers for the sixth row

    la $a0, row
    li $v0, 4
    syscall

    j continue_print

print_numbers1:
    la $a0, numbers1
    li $v0, 4
    syscall
    j continue_print

print_numbers2:
    la $a0, numbers2
    li $v0, 4
    syscall
    j continue_print

print_numbers3:
    la $a0, numbers3
    li $v0, 4
    syscall
    j continue_print

print_numbers4:
    la $a0, numbers4
    li $v0, 4
    syscall
    j continue_print

print_numbers5:
    la $a0, numbers5
    li $v0, 4
    syscall
    j continue_print

print_numbers6:
    la $a0, numbers6
    li $v0, 4
    syscall
    j continue_print

continue_print:
    addi $t0, $t0, -1
    j print_row

end_print:
    li $v0, 10
    syscall
