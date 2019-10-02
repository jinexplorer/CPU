# 五级流水线CPU
***


1. > **语言**

		verilong HDL。

2. > **软件**

		Modelsim

3. > **流水线分级**

		IF ID EXE MEM WB。

4. > 数据冒险：

		一般的数据冒险通过旁路（forward）解决；
		lw型的数据冒险通过阻塞一个周期加旁路解决。

5. > 控制冒险的处理

		在所有的跳转指令之后加入nop指令，实现在ID级判断之后进行跳转，

6. > 动态的分支预测

		无

7. > 异常处理模块

	无
  
| 文件名 | 功能 |
| :-----| :---- |
| sccomp_tb.v | 信号激励文件，是整个CPU的入口 | 
| sccomp.v  | 与内部CPU和外部指令寄存器和内存打交道的入口 |
| sccpu.v | 是整个工程的核心，执行CPU的所有事务 |
| ctrl.v | 控制器 |
| alu.v | 运算器 |
| PC.v ID.v EXE.v MEM.v WB.v | 控制五级流水线信号的更新部件，一个周期运行一次 |
| EXT.v | 立即数的拓展文件 |
| ctrl_encode_def.v | 类似C语言的一些宏的东西 |
| dm.v | 外部内存ROM文件 |
| im.v | 指令存储器 |
| mux.v | 多路选择器 |
| mipstest_pipelinedloop.asm | 测试文件的MIPS指令 |
| mipstest_pipelinedloop.dat | 测试文件汇编之后的机器码 |
| studentnosorting.asm  | 学号排序测试文件的MIPS指令 |
| studentnosorting.dat | 学号排序测试文件汇编之后的机器码 |

作者邮箱:`1059024691@qq.com`

