#interupt demo  main program 
#1st section, auto decrement counter and display
#2nd section: ccmb instruction test
.text
#开中断
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
#C1 instruction benchmark

addi $t0,$zero,1     #sllv 移位次数
addi $t1,$zero,3     #sllv 移位次数
addi $s1,$zero, 0x876     #
sll $s1,$s1,20     #

add $a0,$0,$s1           
addi $v0,$zero,34         # system call for print
syscall                  # print

addi $t3,$zero,8

srav_branch:
srav $s1,$s1,$t0     #先移1位
srav $s1,$s1,$t1     #再移3位
add $a0,$0,$s1          
addi $v0,$zero,34         # system call for print
syscall                  # print
addi $t3,$t3, -1    
bne $t3,$zero,srav_branch   #循环8次

addi   $v0,$zero,50         # system call for exit
syscall                  # we are out of here.   



#C2 instruction benchmark

addi $t0,$zero,-1     #
addi $s1,$zero, 0x7777     #


add $a0,$0,$s1           
addi $v0,$zero,34         # system call for print
syscall                  # print

addi $t3,$zero, 0x10

xori_branch:
xori $s1,$s1, 0xffff     #先移1位
add $a0,$0,$s1          
addi $v0,$zero,34         # system call for print
syscall                  # print
addi $t3,$t3, -1    
bne $t3,$zero,xori_branch   #循环8次

addi   $v0,$zero,50         # system call for exit
syscall                  # we are out of here.   



#Mem instruction benchmark


addi $t1,$zero,0     #init_addr 
addi $t3,$zero,32     #counter

#sb写入 01,02,03,04
addi $s1,$zero, 0x00  #
addi $s2,$zero, 0x01  #

sb_store:
sb $s1,($t1)
add $a0,$0,$s1          
addi $v0,$zero,34        # system call for print
syscall                  # print

add $s1,$s1,$s2          #data +1
addi $t1,$t1,1           # addr ++  
addi $t3,$t3,-1          #counter
bne $t3,$zero,sb_store

addi $t3,$zero,8
addi $t1,$zero,0    # addr   
sb_branch:
lw $s1,($t1)       #读出数据 
add $a0,$0,$s1          
addi $v0,$zero,34        # system call for print
syscall                  # print
addi $t1,$t1,4    
addi $t3,$t3, -1    
bne $t3,$zero,sb_branch

addi   $v0,$zero,50      # system call for exit
syscall                  # we are out of here.   



#Branch instruction benchmark

addi $s1,$zero,-15       #初始值
blez_branch:
add $a0,$0,$s1          
addi $v0,$zero,34         
syscall                  #输出当前值
addi $s1,$s1,1  
blez $s1,blez_branch   


addi   $v0,$zero,10         
syscall                  # 暂停或退出



#中断程序1
#关中断
mfc0 $s1, $zero
#保护现场
sw $sp,560($zero)
addi $sp, $zero, 128    #在内存地址为200处写入
addiu $sp, $sp, -4
sw $a0, 0($sp)  #保存a0寄存器
addiu $sp, $sp, -4
sw $v0, 0($sp)  #保存v0寄存器
addiu $sp, $sp, -4
sw $s3, 0($sp)  #保存s3寄存器
addiu $sp, $sp, -4
sw $s4, 0($sp)  #保存s4寄存器
addiu $sp, $sp, -4
sw $s5, 0($sp)  #保存s5寄存器
addiu $sp, $sp, -4
sw $s6, 0($sp)  #保存s6寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存s0寄存器
mfc0 $s0, $2    #读取EPC到$0寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存$0寄存器，即EPC
mfc0 $s0, $3    #读取中断号到$0寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存$0寄存器，即中断号
# 保护现场后要开中断
mfc0 $s1, $1

# 跑马灯
addi $s6,$zero,1       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值
###################################################################
#                逻辑左移，每次移位4位 
# 显示区域依次显示0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 依次循环6次
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
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, IntLoop1

#恢复现场前要关中断
mfc0 $s1, $zero
#恢复现场
lw $s0, 0($sp)  #恢复s0寄存器，即中断号
mtc0 $s0, $3    #将s0的值给中断号
addiu $sp, $sp, 4
lw $s0, 0($sp)  #恢复s0寄存器，即EPC
mtc0 $s0, $2    #将s0的值给EPC
addiu $sp, $sp, 4
lw $s0, 0($sp)  #恢复s0寄存器
addiu $sp, $sp, 4
lw $s6, 0($sp)  #恢复s6寄存器
addiu $sp, $sp, 4
lw $s5, 0($sp)  #恢复s5寄存器
addiu $sp, $sp, 4
lw $s4, 0($sp)  #恢复s4寄存器
addiu $sp, $sp, 4
lw $s3, 0($sp)  #恢复s3寄存器
addiu $sp, $sp, 4
lw $v0, 0($sp)  #恢复v0寄存器
addiu $sp, $sp, 4
lw $a0, 0($sp)  #恢复a0寄存器
addiu $sp, $sp, 4
lw $sp,560($zero)
#返回
eret
#开中断
mfc0 $s1, $1



#中断程序2
#关中断
mfc0 $s1, $zero
#保护现场
sw $sp,580($zero)
addi $sp, $zero, 256    #在内存地址为200处写入
addiu $sp, $sp, -4
sw $a0, 0($sp)  #保存a0寄存器
addiu $sp, $sp, -4
sw $v0, 0($sp)  #保存v0寄存器
addiu $sp, $sp, -4
sw $s3, 0($sp)  #保存s3寄存器
addiu $sp, $sp, -4
sw $s4, 0($sp)  #保存s4寄存器
addiu $sp, $sp, -4
sw $s5, 0($sp)  #保存s5寄存器
addiu $sp, $sp, -4
sw $s6, 0($sp)  #保存s6寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存s0寄存器
mfc0 $s0, $2    #读取EPC到$0寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存$0寄存器，即EPC
mfc0 $s0, $3    #读取中断号到$0寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存$0寄存器，即中断号
# 保护现场后要开中断
mfc0 $s1, $1

addi $s6,$zero,2       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值
###################################################################
#                逻辑左移，每次移位4位 
# 显示区域依次显示0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 依次循环6次
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
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, IntLoop2

#恢复现场前要关中断
mfc0 $s1, $zero
#恢复现场
lw $s0, 0($sp)  #恢复s0寄存器，即中断号
mtc0 $s0, $3    #将s0的值给中断号
addiu $sp, $sp, 4
lw $s0, 0($sp)  #恢复s0寄存器，即EPC
mtc0 $s0, $2    #将s0的值给EPC
addiu $sp, $sp, 4
lw $s0, 0($sp)  #恢复s0寄存器
addiu $sp, $sp, 4
lw $s6, 0($sp)  #恢复s6寄存器
addiu $sp, $sp, 4
lw $s5, 0($sp)  #恢复s5寄存器
addiu $sp, $sp, 4
lw $s4, 0($sp)  #恢复s4寄存器
addiu $sp, $sp, 4
lw $s3, 0($sp)  #恢复s3寄存器
addiu $sp, $sp, 4
lw $v0, 0($sp)  #恢复v0寄存器
addiu $sp, $sp, 4
lw $a0, 0($sp)  #恢复a0寄存器
addiu $sp, $sp, 4
lw $sp,580($zero)
#返回
eret
#开中断
mfc0 $s1, $1





#中断程序3
#关中断
mfc0 $s1, $zero
#保护现场
sw $sp,600($zero)
addi $sp, $zero, 512    #在内存地址为200处写入
addiu $sp, $sp, -4
sw $a0, 0($sp)  #保存a0寄存器
addiu $sp, $sp, -4
sw $v0, 0($sp)  #保存v0寄存器
addiu $sp, $sp, -4
sw $s3, 0($sp)  #保存s3寄存器
addiu $sp, $sp, -4
sw $s4, 0($sp)  #保存s4寄存器
addiu $sp, $sp, -4
sw $s5, 0($sp)  #保存s5寄存器
addiu $sp, $sp, -4
sw $s6, 0($sp)  #保存s6寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存s0寄存器
mfc0 $s0, $2    #读取EPC到$0寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存$0寄存器，即EPC
mfc0 $s0, $3    #读取中断号到$0寄存器
addiu $sp, $sp, -4
sw $s0, 0($sp)  #保存$0寄存器，即中断号
# 保护现场后要开中断
mfc0 $s1, $1

# 跑马灯
addi $s6,$zero,3       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值
###################################################################
#                逻辑左移，每次移位4位 
# 显示区域依次显示0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 依次循环6次
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
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, IntLoop3
#恢复现场前要关中断
mfc0 $s1, $zero
#恢复现场
lw $s0, 0($sp)  #恢复s0寄存器，即中断号
mtc0 $s0, $3    #将s0的值给中断号
addiu $sp, $sp, 4
lw $s0, 0($sp)  #恢复s0寄存器，即EPC
mtc0 $s0, $2    #将s0的值给EPC
addiu $sp, $sp, 4
lw $s0, 0($sp)  #恢复s0寄存器
addiu $sp, $sp, 4
lw $s6, 0($sp)  #恢复s6寄存器
addiu $sp, $sp, 4
lw $s5, 0($sp)  #恢复s5寄存器
addiu $sp, $sp, 4
lw $s4, 0($sp)  #恢复s4寄存器
addiu $sp, $sp, 4
lw $s3, 0($sp)  #恢复s3寄存器
addiu $sp, $sp, 4
lw $v0, 0($sp)  #恢复v0寄存器
addiu $sp, $sp, 4
lw $a0, 0($sp)  #恢复a0寄存器
addiu $sp, $sp, 4
lw $a0, 0($sp)  #恢复a0寄存器
lw $sp,600($zero)
#返回
eret
#开中断
mfc0 $s1, $1











