.data
prompt:     .asciiz "Enter a number between 1 and 9: "
error_msg:  .asciiz "Invalid input. Please enter a number between 1 and 9.\n"
success_msg:.asciiz "You entered: "

.text
.globl main

main:
    # Print a prompt
    li $v0, 4
    la $a0, prompt
    syscall

input_loop:
    # Read an integer from the user
    li $v0, 5
    syscall
    move $t0, $v0  # Store user input in $t0

    # Check if the input is within the range 1 to 9
    li $t1, 1
    li $t2, 9
    bge $t0, $t1, check_upper_bound
    j input_error

check_upper_bound:
    ble $t0, $t2, input_success
    j input_error

input_error:
    # Print an error message
    li $v0, 4
    la $a0, error_msg
    syscall
    j input_loop

input_success:
    # Print a success message
    li $v0, 4
    la $a0, success_msg
    syscall

    # Print the entered number
    li $v0, 1
    move $a0, $t0
    syscall

    # Exit the program
    li $v0, 10
    syscall
