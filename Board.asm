.data
array: .space 144    # Space for a 6x6 array of integers (4 bytes each)
pipe: .asciiz "|"
newline: .asciiZ "\n"


.text
main:
    la $t0, array    # Load the address of the array into $t0

    # First row
    li $t1, 1
    sw $t1, 0($t0)
    li $t1, 2
    sw $t1, 4($t0)
    li $t1, 3
    sw $t1, 8($t0)
    li $t1, 4
    sw $t1, 12($t0)
    li $t1, 5
    sw $t1, 16($t0)
    li $t1, 6
    sw $t1, 20($t0)

    # Second row
    li $t1, 7
    sw $t1, 24($t0)
    li $t1, 8
    sw $t1, 28($t0)
    li $t1, 9
    sw $t1, 32($t0)
    li $t1, 10
    sw $t1, 36($t0)
    li $t1, 12
    sw $t1, 40($t0)
    li $t1, 14
    sw $t1, 44($t0)

    # Third row
    li $t1, 15
    sw $t1, 48($t0)
    li $t1, 16
    sw $t1, 52($t0)
    li $t1, 18
    sw $t1, 56($t0)
    li $t1, 20
    sw $t1, 60($t0)
    li $t1, 21
    sw $t1, 64($t0)
    li $t1, 24
    sw $t1, 68($t0)

    # Fourth row
    li $t1, 25
    sw $t1, 72($t0)
    li $t1, 27
    sw $t1, 76($t0)
    li $t1, 28
    sw $t1, 80($t0)
    li $t1, 30
    sw $t1, 84($t0)
    li $t1, 32
    sw $t1, 88($t0)
    li $t1, 35
    sw $t1, 92($t0)

    # Fifth row
    li $t1, 36
    sw $t1, 96($t0)
    li $t1, 40
    sw $t1, 100($t0)
    li $t1, 42
    sw $t1, 104($t0)
    li $t1, 45
    sw $t1, 108($t0)
    li $t1, 48
    sw $t1, 112($t0)
    li $t1, 59
    sw $t1, 116($t0)

    # Sixth row
    li $t1, 54
    sw $t1, 120($t0)
    li $t1, 56
    sw $t1, 124($t0)
    li $t1, 63
    sw $t1, 128($t0)
    li $t1, 64
    sw $t1, 132($t0)
    li $t1, 72
    sw $t1, 136($t0)
    li $t1, 81
    sw $t1, 140($t0)
    
    # Print the array
    li $t2, 0         # Initialize a counter to 0
    print_loop:
        # Print a pipe character
        li $v0, 4        # System call code for print_string
        la $a0, pipe     # Address of the pipe character
        syscall          # Print the pipe

        # Print the value
        lw $a0, 0($t0)   # Load the value at the current offset into $a0
        li $v0, 1        # System call code for print_int
        syscall          # Print the integer

        # Check if we need to print a newline
        addi $t2, $t2, 1 # Increment the counter
        rem $t3, $t2, 6  # Calculate the remainder when the counter is divided by 6
        beqz $t3, print_newline # If the remainder is 0, print a newline
        
        # Otherwise, continue to the next element
        addi $t0, $t0, 4 # Increment the offset by 4 (size of an integer)
        blt $t2, 36, print_loop # If the counter is less than 36 (total number of elements), loop back
        
    #row = (index / num_columns) + 1
    #col = (index % num_columns) + 1
    la $t4, array    # Load the address of the array into $t4
    li $t5, 7
    li $t6, 8
    mult $t7, $t5, $t6
    div $t7
    
    

    # Exit the program
    li $v0, 10
    syscall

print_newline:
    # Print a pipe and a newline
    li $v0, 4        # System call code for print_string
    la $a0, pipe     # Address of the pipe character
    syscall          # Print the pipe
    la $a0, newline  # Address of the newline character
    syscall          # Print the newline

    # Continue to the next element
    addi $t0, $t0, 4 # Increment the offset by 4 (size of an integer)
    blt $t2, 36, print_loop # If the counter is less than 36 (total number of elements), loop back
