此项目实现了一个简单的流水线CPU

此项目使用的语言:verilong HDL

此项目使用的软件:Modelsim

此项目流水线分级为：IF ID EXE MEM WB

此项目能够处理数据冒险：
一般的数据冒险通过旁路（forward）解决；
lw型的数据冒险通过阻塞一个周期加旁路解决

此项目对控制冒险的处理比较简单，在所有的跳转指令之后加入nop指令，实现在ID级判断之后进行跳转。
并没有实现动态的分支预测

此项目位实现异常处理模块

sccomp_tb.v 是信号激励文件，是整个CPU的入口
sccomp.v 是与内部CPU和外部指令寄存器和内存打交道的入口
sccpu.v 是整个工程的核心，执行CPU的所有事务
ctrl.v 是控制器
alu.v 是运算器
PC. ID.v EXE.v MEM.v WB.v是控制五级流水线信号的更新部件，一个周期运行一次
EXT.v 是立即数的拓展文件
ctrl_encode_def.v 是类似C语言的一些宏的东西
dm.v 是外部内存ROM文件
im.v 是指令存储器
mux.v 是多路选择器
mipstest_pipelinedloop.asm 是测试文件的MIPS指令
mipstest_pipelinedloop.dat 是测试文件汇编之后的机器码
studentnosorting.asm 是学号排序测试文件的MIPS指令
studentnosorting.dat 是学号排序测试文件汇编之后的机器码


作者邮箱:1059024691@qq.com
