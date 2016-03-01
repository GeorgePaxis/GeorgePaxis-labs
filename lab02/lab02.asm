# Calculate sums of positive odd and negative even values in an array
#   in MIPS assembly using MARS
# for MYΥ-402 - Computer Architecture
# Department of Computer Engineering, University of Ioannina
# Aris Efthymiou

        .globl main # declare the label main as global. 
        
        .text 
     
main:
        la         $a0, length       # get address of length to $a0
        lw         $a0, 0($a0)       # get the length in to $a0

        la         $a1, input        # get address of array to $a1

        addiu      $s0, $zero, 0     # sum of positive odd values starts as 0
        addiu      $s1, $zero, 0     # sum of negative even values starts as 0

        ########################################################################
        li	   $t1, 0
        add	   $t2, $a1, $zero
loop:
	beq	   $a0, $zero, exitloop		#an einai adiops o pinakas paw sto exitloop
	beq	   $a0, $t1, exitloop
	
	lw	   $t0, 0($t2)			#diavazei ta stoixeia tou pinaka
	
	slt	   $t3, $t0, $zero		#elenxei an einai thetikos i arnitikos
	
	bne	   $t3, $zero, negative		#ama einai arnitikos paw sto negative
	andi	   $t4, $t0, 0x1		#ama einai thetikos elenxei an einai perittos
	beq	   $t4, $zero, skip		#ama einai artios me petaei sto skip
	add	   $s0, $s0, $t0		#ton prosthetei ston $s0 efoson den einai artios
	j	   skip
	
negative:
	
	andi	   $t4, $t0, 0x1		#elenxei an einai artios
	bne	   $t4, $zero, skip		#an einai perittos paw sto skip
	add	   $s1, $s1, $t0		#ton prosthetei sto $s1 efoson den einai perittos

skip:
	
	addi	   $t2, $t2, 4			
	addi	   $t1, $t1, 1
	j	   loop

exitloop:
	
        ########################################################################
        
exit: 
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall                      # we are outta here.
        
        ###############################################################################
        # Data input.
        ###############################################################################
        .data
length: .word 5 # Number of values in the input array
input:  .word 3, -2, 0, 4, -1
