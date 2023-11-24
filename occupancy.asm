.data


#row = (index / num_columns) + 1
#col = (index % num_columns) + 1

occupancy:
    li $t5, 7				# User Input
    li $t6, 8				# Computer Input
    mult $t7, $t5, $t6		# Mltiply 
    li $t3, 6        	  # number of col
    div $t7, $t3
    mflo    $t1                # Move the quotient from $lo to $t1
    mfhi    $t2                # Move the remainder from $hi to $t2
    
    addi    $t1, $t1, 1   # Add 1 to $t2  ---- row number
    addi    $t2, $t2, 1   # Add 1 to $t3  ---- col number
    
    # Calculate t1 * t3 and store the result in $t4
    mul     $t4, $t1, $t3

    # Calculate (t1 * t3) + t2 and store the result in $t5
    add     $t5, $t4, $t2

    # Calculate ((t1 * t3) + t2) * 4 and store the final result in $t6
    sll     $t6, $t5, 2   # Equivalent to multiplying by 4
    

    la      $t9, array       # Load the base address of the array
    add     $t9, $t9, $t6    # Add the offset to get the address of the element

    # Load the character from memory
    lb      $t0, 0($t9)      # Assuming characters are stored as bytes

    # Compare the loaded character with the ASCII value of 'O' (79)
    beq     $t0, 79, input_error    # Branch if the character is 'O'

    # Compare the loaded character with the ASCII value of 'X' (88)
    beq     $t0, 88, input_error    # Branch if the character is 'X'
    
    
    