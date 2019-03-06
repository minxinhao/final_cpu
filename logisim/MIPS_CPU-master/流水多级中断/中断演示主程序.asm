#interupt demo  main program 
#1st section, auto decrement counter and display
#2nd section: ccmb instruction test
.text
#���ж�
mfc0 $t1, $at 

addi $s1,$zero,0x200      #initial nubmer
addi $v0,$zero,34    
counter_branch:
add $a0,$0,$s1          
syscall                 #display number
addi $s1,$s1,-1         #decrement
bne $s1,$zero,counter_branch
addi $v0,$zero,50
syscall                 #pause
############################################
# insert your ccmb benchmark program here!!!
#C1 instruction
addi $t0,$zero,2     #sllv ��λ����
addi $s1,$zero, 0x1111     #

add $a0,$0,$s1           
addi $v0,$zero,34         # system call for print
syscall                  # print

addi $t3,$zero,32  #ѭ������
multu_branch:
multu $s1,$t0     #����ָ��
mflo $s1          #����ָ��
add $a0,$0,$s1          
addi $v0,$zero,34         # system call for print
syscall                  # print
addi $t3,$t3, -1    
bne $t3,$zero,multu_branch   #ѭ��8��


#C2 instruction
addi $t1,$zero,0     #init_addr 
addi $t3,$zero,32     #counter


#Mem instruction
addi $s1,$zero, 0x0001  #
addi $s2,$zero, 0x01  #
sh_store:
sh $s1,($t1)
add $a0,$0,$s1          
addi $v0,$zero,34         # system call for print
syscall                  # print

add $s1,$s1,$s2   #data +1
addi $t1,$t1,2    # addr +4  
addi $t3,$t3,-1   #counter
bne $t3,$zero,sh_store


addi $t3,$zero,16
addi $t1,$zero,0    # addr 
sh_branch:
lw $s1,($t1)     
add $a0,$0,$s1          
addi $v0,$zero,34         # system call for print
syscall                  # print
addi $t1,$t1,4    
addi $t3,$t3, -1    
bne $t3,$zero,sh_branch



#Branch instruction
addi $s1,$zero,15  
bgtz_branch:
add $a0,$0,$s1          
addi $v0,$zero,34         
syscall                  # �����ǰֵ
addi $s1,$s1,-1  
bgtz $s1,bgtz_branch    #��ǰ����ָ��



addi $v0,$zero,10
syscall                 #pause


#�жϳ���1
#���ж�
mfc0 $s1, $zero
#�����ֳ�
sw $sp,560($zero)
addi $sp, $zero, 128    #���ڴ��ַΪ200��д��
addiu $sp, $sp, -4
sw $a0, 0($sp)  #����a0�Ĵ���
addiu $sp, $sp, -4
sw $v0, 0($sp)  #����v0�Ĵ���
addiu $sp, $sp, -4
sw $s3, 0($sp)  #����s3�Ĵ���
addiu $sp, $sp, -4
sw $s4, 0($sp)  #����s4�Ĵ���
addiu $sp, $sp, -4
sw $s5, 0($sp)  #����s5�Ĵ���
addiu $sp, $sp, -4
sw $s6, 0($sp)  #����s6�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����s0�Ĵ���
mfc0 $s0, $2    #��ȡEPC��$0�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����$0�Ĵ�������EPC
mfc0 $s0, $3    #��ȡ�жϺŵ�$0�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����$0�Ĵ��������жϺ�
# �����ֳ���Ҫ���ж�
mfc0 $s1, $1

# �����
addi $s6,$zero,1       #�жϺ�1,2,3   ��ͬ�жϺ���ʾֵ��һ��

addi $s4,$zero,6      #ѭ��������ʼֵ  
addi $s5,$zero,1       #�������ۼ�ֵ
###################################################################
#                �߼����ƣ�ÿ����λ4λ 
# ��ʾ����������ʾ0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 ����ѭ��6��
###################################################################
IntLoop1:
add $s0,$zero,$s6   

IntLeftShift1:       


sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, IntLeftShift1
sub $s4,$s4,$s5      #ѭ�������ݼ�
bne $s4, $zero, IntLoop1

#�ָ��ֳ�ǰҪ���ж�
mfc0 $s1, $zero
#�ָ��ֳ�
lw $s0, 0($sp)  #�ָ�s0�Ĵ��������жϺ�
mtc0 $s0, $3    #��s0��ֵ���жϺ�
addiu $sp, $sp, 4
lw $s0, 0($sp)  #�ָ�s0�Ĵ�������EPC
mtc0 $s0, $2    #��s0��ֵ��EPC
addiu $sp, $sp, 4
lw $s0, 0($sp)  #�ָ�s0�Ĵ���
addiu $sp, $sp, 4
lw $s6, 0($sp)  #�ָ�s6�Ĵ���
addiu $sp, $sp, 4
lw $s5, 0($sp)  #�ָ�s5�Ĵ���
addiu $sp, $sp, 4
lw $s4, 0($sp)  #�ָ�s4�Ĵ���
addiu $sp, $sp, 4
lw $s3, 0($sp)  #�ָ�s3�Ĵ���
addiu $sp, $sp, 4
lw $v0, 0($sp)  #�ָ�v0�Ĵ���
addiu $sp, $sp, 4
lw $a0, 0($sp)  #�ָ�a0�Ĵ���
addiu $sp, $sp, 4
lw $sp,560($zero)
#����
eret
#���ж�
mfc0 $s1, $1



#�жϳ���2
#���ж�
mfc0 $s1, $zero
#�����ֳ�
sw $sp,580($zero)
addi $sp, $zero, 256    #���ڴ��ַΪ200��д��
addiu $sp, $sp, -4
sw $a0, 0($sp)  #����a0�Ĵ���
addiu $sp, $sp, -4
sw $v0, 0($sp)  #����v0�Ĵ���
addiu $sp, $sp, -4
sw $s3, 0($sp)  #����s3�Ĵ���
addiu $sp, $sp, -4
sw $s4, 0($sp)  #����s4�Ĵ���
addiu $sp, $sp, -4
sw $s5, 0($sp)  #����s5�Ĵ���
addiu $sp, $sp, -4
sw $s6, 0($sp)  #����s6�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����s0�Ĵ���
mfc0 $s0, $2    #��ȡEPC��$0�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����$0�Ĵ�������EPC
mfc0 $s0, $3    #��ȡ�жϺŵ�$0�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����$0�Ĵ��������жϺ�
# �����ֳ���Ҫ���ж�
mfc0 $s1, $1

addi $s6,$zero,2       #�жϺ�1,2,3   ��ͬ�жϺ���ʾֵ��һ��

addi $s4,$zero,6      #ѭ��������ʼֵ  
addi $s5,$zero,1       #�������ۼ�ֵ
###################################################################
#                �߼����ƣ�ÿ����λ4λ 
# ��ʾ����������ʾ0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 ����ѭ��6��
###################################################################
IntLoop2:
add $s0,$zero,$s6   

IntLeftShift2:       


sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, IntLeftShift2
sub $s4,$s4,$s5      #ѭ�������ݼ�
bne $s4, $zero, IntLoop2

#�ָ��ֳ�ǰҪ���ж�
mfc0 $s1, $zero
#�ָ��ֳ�
lw $s0, 0($sp)  #�ָ�s0�Ĵ��������жϺ�
mtc0 $s0, $3    #��s0��ֵ���жϺ�
addiu $sp, $sp, 4
lw $s0, 0($sp)  #�ָ�s0�Ĵ�������EPC
mtc0 $s0, $2    #��s0��ֵ��EPC
addiu $sp, $sp, 4
lw $s0, 0($sp)  #�ָ�s0�Ĵ���
addiu $sp, $sp, 4
lw $s6, 0($sp)  #�ָ�s6�Ĵ���
addiu $sp, $sp, 4
lw $s5, 0($sp)  #�ָ�s5�Ĵ���
addiu $sp, $sp, 4
lw $s4, 0($sp)  #�ָ�s4�Ĵ���
addiu $sp, $sp, 4
lw $s3, 0($sp)  #�ָ�s3�Ĵ���
addiu $sp, $sp, 4
lw $v0, 0($sp)  #�ָ�v0�Ĵ���
addiu $sp, $sp, 4
lw $a0, 0($sp)  #�ָ�a0�Ĵ���
addiu $sp, $sp, 4
lw $sp,580($zero)
#����
eret
#���ж�
mfc0 $s1, $1





#�жϳ���3
#���ж�
mfc0 $s1, $zero
#�����ֳ�
sw $sp,600($zero)
addi $sp, $zero, 512    #���ڴ��ַΪ200��д��
addiu $sp, $sp, -4
sw $a0, 0($sp)  #����a0�Ĵ���
addiu $sp, $sp, -4
sw $v0, 0($sp)  #����v0�Ĵ���
addiu $sp, $sp, -4
sw $s3, 0($sp)  #����s3�Ĵ���
addiu $sp, $sp, -4
sw $s4, 0($sp)  #����s4�Ĵ���
addiu $sp, $sp, -4
sw $s5, 0($sp)  #����s5�Ĵ���
addiu $sp, $sp, -4
sw $s6, 0($sp)  #����s6�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����s0�Ĵ���
mfc0 $s0, $2    #��ȡEPC��$0�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����$0�Ĵ�������EPC
mfc0 $s0, $3    #��ȡ�жϺŵ�$0�Ĵ���
addiu $sp, $sp, -4
sw $s0, 0($sp)  #����$0�Ĵ��������жϺ�
# �����ֳ���Ҫ���ж�
mfc0 $s1, $1

# �����
addi $s6,$zero,3       #�жϺ�1,2,3   ��ͬ�жϺ���ʾֵ��һ��

addi $s4,$zero,6      #ѭ��������ʼֵ  
addi $s5,$zero,1       #�������ۼ�ֵ
###################################################################
#                �߼����ƣ�ÿ����λ4λ 
# ��ʾ����������ʾ0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 ����ѭ��6��
###################################################################
IntLoop3:
add $s0,$zero,$s6   

IntLeftShift3:       


sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, IntLeftShift3
sub $s4,$s4,$s5      #ѭ�������ݼ�
bne $s4, $zero, IntLoop3
#�ָ��ֳ�ǰҪ���ж�
mfc0 $s1, $zero
#�ָ��ֳ�
lw $s0, 0($sp)  #�ָ�s0�Ĵ��������жϺ�
mtc0 $s0, $3    #��s0��ֵ���жϺ�
addiu $sp, $sp, 4
lw $s0, 0($sp)  #�ָ�s0�Ĵ�������EPC
mtc0 $s0, $2    #��s0��ֵ��EPC
addiu $sp, $sp, 4
lw $s0, 0($sp)  #�ָ�s0�Ĵ���
addiu $sp, $sp, 4
lw $s6, 0($sp)  #�ָ�s6�Ĵ���
addiu $sp, $sp, 4
lw $s5, 0($sp)  #�ָ�s5�Ĵ���
addiu $sp, $sp, 4
lw $s4, 0($sp)  #�ָ�s4�Ĵ���
addiu $sp, $sp, 4
lw $s3, 0($sp)  #�ָ�s3�Ĵ���
addiu $sp, $sp, 4
lw $v0, 0($sp)  #�ָ�v0�Ĵ���
addiu $sp, $sp, 4
lw $a0, 0($sp)  #�ָ�a0�Ĵ���
addiu $sp, $sp, 4
lw $a0, 0($sp)  #�ָ�a0�Ĵ���
lw $sp,600($zero)
#����
eret
#���ж�
mfc0 $s1, $1











