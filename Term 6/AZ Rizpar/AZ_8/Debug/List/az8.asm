
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _key_res=R5
	.DEF _flag1=R6
	.DEF _flag1_msb=R7
	.DEF _flag2=R8
	.DEF _flag2_msb=R9
	.DEF _flag3=R10
	.DEF _flag3_msb=R11
	.DEF _flag4=R12
	.DEF _flag4_msb=R13
	.DEF _op=R4

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x3:
	.DB  0x0,0x0,0x1,0x0,0x2,0x0,0x3,0x0
	.DB  0x4,0x0,0x5,0x0,0x6,0x0,0x7,0x0
	.DB  0x8,0x0,0x9
_0x4:
	.DB  0xFF,0xFF
_0x5:
	.DB  0xFF,0xFF
_0x6:
	.DB  0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
	.DB  0x38,0x39
_0x0:
	.DB  0x57,0x45,0x4C,0x43,0x4F,0x4D,0x45,0x0
_0x2000003:
	.DB  0x80,0xC0
_0x2060060:
	.DB  0x1
_0x2060000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x13
	.DW  _num
	.DW  _0x3*2

	.DW  0x02
	.DW  _operand
	.DW  _0x4*2

	.DW  0x02
	.DW  _equal
	.DW  _0x5*2

	.DW  0x0A
	.DW  _output
	.DW  _0x6*2

	.DW  0x08
	.DW  _0x7
	.DW  _0x0*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  __seed_G103
	.DW  _0x2060060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;//Mohamad Saleh Pazhand 400521171
;
;#include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <stdint.h>
;#include <string.h>
;#include <delay.h>
;#include <math.h>
;
;#define KEYPAD_R1 PORTD.0
;#define KEYPAD_R2 PORTD.1
;#define KEYPAD_R3 PORTD.2
;#define KEYPAD_R4 PORTD.3
;#define KEYPAD_C1 PIND.4
;#define KEYPAD_C2 PIND.5
;#define KEYPAD_C3 PIND.6
;#define KEYPAD_C4 PIND.7
;
;#define KEYPAD_NUM0 0
;#define KEYPAD_NUM1 1
;#define KEYPAD_NUM2 2
;#define KEYPAD_NUM3 3
;#define KEYPAD_NUM4 4
;#define KEYPAD_NUM5 5
;#define KEYPAD_NUM6 6
;#define KEYPAD_NUM7 7
;#define KEYPAD_NUM8 8
;#define KEYPAD_NUM9 9
;#define KEYPAD_DIV  10
;#define KEYPAD_MUL  11
;#define KEYPAD_PLS  12
;#define KEYPAD_MNS  13
;#define KEYPAD_EQU  14
;#define KEYPAD_ON   15
;
;void static Calculator(unsigned char key_res);
;unsigned char keypad_scan();
;unsigned char key_res;
;
;int flag1 = 0,flag2 = 0,flag3 = 0,flag4 = 0;
;int result[10];
;int num[10] = {0,1,2,3,4,5,6,7,8,9};

	.DSEG
;int i,digits=0,res=0;
;int operand=-1,equal=-1;
;char op = '';
;char output[11] = "0123456789";
;void main(void)
; 0000 0030 {

	.CSEG
_main:
; .FSTART _main
; 0000 0031     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 0032     lcd_clear();
	CALL _lcd_clear
; 0000 0033     lcd_gotoxy(5,0);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0000 0034     lcd_puts("WELCOME");
	__POINTW2MN _0x7,0
	CALL _lcd_puts
; 0000 0035     delay_ms(1500);
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	CALL _delay_ms
; 0000 0036     lcd_clear();
	CALL _lcd_clear
; 0000 0037 
; 0000 0038     while (1)
_0x8:
; 0000 0039     {
; 0000 003A         key_res = keypad_scan();
	RCALL _keypad_scan
	MOV  R5,R30
; 0000 003B         Calculator(key_res);
	MOV  R26,R5
	RCALL _Calculator_G000
; 0000 003C     }
	RJMP _0x8
; 0000 003D }
_0xB:
	RJMP _0xB
; .FEND

	.DSEG
_0x7:
	.BYTE 0x8
;
; void static Calculator(unsigned char key_res){
; 0000 003F void static Calculator(unsigned char key_res){

	.CSEG
_Calculator_G000:
; .FSTART _Calculator_G000
; 0000 0040 
; 0000 0041 
; 0000 0042         if(key_res != 255)
	ST   -Y,R26
;	key_res -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0xFF)
	BRNE PC+2
	RJMP _0xC
; 0000 0043         {
; 0000 0044             while(keypad_scan() != 255);
_0xD:
	RCALL _keypad_scan
	CPI  R30,LOW(0xFF)
	BRNE _0xD
; 0000 0045 
; 0000 0046             if(operand == -1)
	CALL SUBOPT_0x0
	BRNE _0x10
; 0000 0047                 operand = 0;
	LDI  R30,LOW(0)
	STS  _operand,R30
	STS  _operand+1,R30
; 0000 0048 
; 0000 0049             if(operand != -1 && equal == -1 && flag1 == 1)
_0x10:
	CALL SUBOPT_0x0
	BREQ _0x12
	LDS  R26,_equal
	LDS  R27,_equal+1
	CPI  R26,LOW(0xFFFF)
	LDI  R30,HIGH(0xFFFF)
	CPC  R27,R30
	BRNE _0x12
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BREQ _0x13
_0x12:
	RJMP _0x11
_0x13:
; 0000 004A                 equal = 0;
	LDI  R30,LOW(0)
	STS  _equal,R30
	STS  _equal+1,R30
; 0000 004B 
; 0000 004C             delay_ms(20);
_0x11:
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
; 0000 004D             if (key_res == KEYPAD_DIV){
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x14
; 0000 004E                 lcd_putchar('%');
	LDI  R26,LOW(37)
	CALL SUBOPT_0x1
; 0000 004F                 flag1 = 1;
; 0000 0050                 op = '%';
	LDI  R30,LOW(37)
	MOV  R4,R30
; 0000 0051             }
; 0000 0052             else if (key_res == KEYPAD_MUL){
	RJMP _0x15
_0x14:
	LD   R26,Y
	CPI  R26,LOW(0xB)
	BRNE _0x16
; 0000 0053                 lcd_putchar('*');
	LDI  R26,LOW(42)
	CALL SUBOPT_0x1
; 0000 0054                 flag1 = 1;
; 0000 0055                 op = '*';
	LDI  R30,LOW(42)
	MOV  R4,R30
; 0000 0056             }
; 0000 0057             else if (key_res == KEYPAD_MNS){
	RJMP _0x17
_0x16:
	LD   R26,Y
	CPI  R26,LOW(0xD)
	BRNE _0x18
; 0000 0058                 lcd_putchar('-');
	LDI  R26,LOW(45)
	CALL SUBOPT_0x1
; 0000 0059                 flag1 = 1;
; 0000 005A                 op = '-';
	LDI  R30,LOW(45)
	MOV  R4,R30
; 0000 005B             }
; 0000 005C             else if (key_res == KEYPAD_PLS){
	RJMP _0x19
_0x18:
	LD   R26,Y
	CPI  R26,LOW(0xC)
	BRNE _0x1A
; 0000 005D                 lcd_putchar('+');
	LDI  R26,LOW(43)
	CALL SUBOPT_0x1
; 0000 005E                 flag1 = 1;
; 0000 005F                 op = '+';
	LDI  R30,LOW(43)
	MOV  R4,R30
; 0000 0060             }
; 0000 0061             else if (key_res == KEYPAD_EQU){
	RJMP _0x1B
_0x1A:
	LD   R26,Y
	CPI  R26,LOW(0xE)
	BREQ PC+2
	RJMP _0x1C
; 0000 0062                 if (flag3 == 1)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R10
	CPC  R31,R11
	BRNE _0x1D
; 0000 0063                     operand *= -1;
	CALL SUBOPT_0x2
	LDI  R26,LOW(65535)
	LDI  R27,HIGH(65535)
	CALL __MULW12
	CALL SUBOPT_0x3
; 0000 0064                 if (flag4 == 1)
_0x1D:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x1E
; 0000 0065                     equal *= -1;
	CALL SUBOPT_0x4
	LDI  R26,LOW(65535)
	LDI  R27,HIGH(65535)
	CALL __MULW12
	CALL SUBOPT_0x5
; 0000 0066                 lcd_putchar('=');
_0x1E:
	LDI  R26,LOW(61)
	RCALL _lcd_putchar
; 0000 0067                 if (op == '%')
	LDI  R30,LOW(37)
	CP   R30,R4
	BRNE _0x1F
; 0000 0068                     res = operand/equal;
	CALL SUBOPT_0x6
	CALL __DIVW21
	RJMP _0x70
; 0000 0069                 else if(op == '*')
_0x1F:
	LDI  R30,LOW(42)
	CP   R30,R4
	BRNE _0x21
; 0000 006A                     res = operand*equal;
	CALL SUBOPT_0x6
	CALL __MULW12
	RJMP _0x70
; 0000 006B                 else if(op == '-')
_0x21:
	LDI  R30,LOW(45)
	CP   R30,R4
	BRNE _0x23
; 0000 006C                     res = operand-equal;
	LDS  R26,_equal
	LDS  R27,_equal+1
	CALL SUBOPT_0x2
	SUB  R30,R26
	SBC  R31,R27
	RJMP _0x70
; 0000 006D                 else if(op == '+')
_0x23:
	LDI  R30,LOW(43)
	CP   R30,R4
	BRNE _0x25
; 0000 006E                     res = operand+equal;
	CALL SUBOPT_0x6
	ADD  R30,R26
	ADC  R31,R27
_0x70:
	STS  _res,R30
	STS  _res+1,R31
; 0000 006F                 digits=0;
_0x25:
	LDI  R30,LOW(0)
	STS  _digits,R30
	STS  _digits+1,R30
; 0000 0070                 if(res <0){
	LDS  R26,_res+1
	TST  R26
	BRPL _0x26
; 0000 0071                     flag2 = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R8,R30
; 0000 0072                     res = -res;
	LDS  R30,_res
	LDS  R31,_res+1
	CALL __ANEGW1
	STS  _res,R30
	STS  _res+1,R31
; 0000 0073                 }
; 0000 0074                 for(i = 0;i < 11;i++){
_0x26:
	LDI  R30,LOW(0)
	STS  _i,R30
	STS  _i+1,R30
_0x28:
	LDS  R26,_i
	LDS  R27,_i+1
	SBIW R26,11
	BRGE _0x29
; 0000 0075                     result[i] = res%10;
	CALL SUBOPT_0x7
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	CALL SUBOPT_0x8
	CALL __MODW21
	MOVW R26,R22
	ST   X+,R30
	ST   X,R31
; 0000 0076                     res = res / 10;
	CALL SUBOPT_0x8
	CALL __DIVW21
	STS  _res,R30
	STS  _res+1,R31
; 0000 0077                     if(res ==0)
	SBIW R30,0
	BREQ _0x29
; 0000 0078                         break;
; 0000 0079                     digits++;
	LDI  R26,LOW(_digits)
	LDI  R27,HIGH(_digits)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 007A                 }
	LDI  R26,LOW(_i)
	LDI  R27,HIGH(_i)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RJMP _0x28
_0x29:
; 0000 007B                 if (flag2 == 1)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x2B
; 0000 007C                     lcd_putchar('-');
	LDI  R26,LOW(45)
	RCALL _lcd_putchar
; 0000 007D                 for(i = digits;i>=0;i--){
_0x2B:
	LDS  R30,_digits
	LDS  R31,_digits+1
	STS  _i,R30
	STS  _i+1,R31
_0x2D:
	LDS  R26,_i+1
	TST  R26
	BRMI _0x2E
; 0000 007E                     lcd_putchar(output[result[i]]);
	CALL SUBOPT_0x7
	CALL SUBOPT_0x9
	SUBI R30,LOW(-_output)
	SBCI R31,HIGH(-_output)
	LD   R26,Z
	RCALL _lcd_putchar
; 0000 007F                 }
	LDI  R26,LOW(_i)
	LDI  R27,HIGH(_i)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	RJMP _0x2D
_0x2E:
; 0000 0080             }
; 0000 0081             else if (key_res == KEYPAD_ON)
	RJMP _0x2F
_0x1C:
	LD   R26,Y
	CPI  R26,LOW(0xF)
	BRNE _0x30
; 0000 0082             {
; 0000 0083                 lcd_clear();
	RCALL _lcd_clear
; 0000 0084                 lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _lcd_gotoxy
; 0000 0085                 operand = -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CALL SUBOPT_0x3
; 0000 0086                 equal = -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CALL SUBOPT_0x5
; 0000 0087                 flag1 = 0;
	CLR  R6
	CLR  R7
; 0000 0088                 op = '';
	CLR  R4
; 0000 0089                 res = 0;
	LDI  R30,LOW(0)
	STS  _res,R30
	STS  _res+1,R30
; 0000 008A                 digits=0;
	STS  _digits,R30
	STS  _digits+1,R30
; 0000 008B                 flag2 = 0;
	CLR  R8
	CLR  R9
; 0000 008C                 flag3 = 0;
	CLR  R10
	CLR  R11
; 0000 008D                 flag4 = 0;
	CLR  R12
	CLR  R13
; 0000 008E             }
; 0000 008F             else{
	RJMP _0x31
_0x30:
; 0000 0090                 lcd_putchar(key_res + 48);
	LD   R26,Y
	SUBI R26,-LOW(48)
	RCALL _lcd_putchar
; 0000 0091                 if (flag1 == 0){
	MOV  R0,R6
	OR   R0,R7
	BRNE _0x32
; 0000 0092                     operand = (operand*10)+num[key_res];
	CALL SUBOPT_0x2
	CALL SUBOPT_0xA
	ADD  R30,R0
	ADC  R31,R1
	CALL SUBOPT_0x3
; 0000 0093                 }
; 0000 0094                 else {
	RJMP _0x33
_0x32:
; 0000 0095                     equal = (equal*10)+num[key_res];
	CALL SUBOPT_0x4
	CALL SUBOPT_0xA
	ADD  R30,R0
	ADC  R31,R1
	CALL SUBOPT_0x5
; 0000 0096                 }
_0x33:
; 0000 0097             }
_0x31:
_0x2F:
_0x1B:
_0x19:
_0x17:
_0x15:
; 0000 0098         }
; 0000 0099 
; 0000 009A }
_0xC:
	RJMP _0x20A0001
; .FEND
;
;unsigned char keypad_scan()
; 0000 009D {
_keypad_scan:
; .FSTART _keypad_scan
; 0000 009E     unsigned char result=255;
; 0000 009F     ////////////////////////  ROW1 ////////////////////////
; 0000 00A0     KEYPAD_R1 = 1; KEYPAD_R2 = 0;  KEYPAD_R3 = 0;  KEYPAD_R4 = 0; //set Row1 for Keypad
	ST   -Y,R17
;	result -> R17
	LDI  R17,255
	SBI  0x12,0
	CBI  0x12,1
	CALL SUBOPT_0xB
; 0000 00A1     delay_ms(5);
; 0000 00A2     if (KEYPAD_C1)
	SBIS 0x10,4
	RJMP _0x3C
; 0000 00A3         result = KEYPAD_NUM7;
	LDI  R17,LOW(7)
; 0000 00A4     else if (KEYPAD_C2)
	RJMP _0x3D
_0x3C:
	SBIS 0x10,5
	RJMP _0x3E
; 0000 00A5         result = KEYPAD_NUM8;
	LDI  R17,LOW(8)
; 0000 00A6     else if (KEYPAD_C3)
	RJMP _0x3F
_0x3E:
	SBIS 0x10,6
	RJMP _0x40
; 0000 00A7         result = KEYPAD_NUM9;
	LDI  R17,LOW(9)
; 0000 00A8     else if (KEYPAD_C4)
	RJMP _0x41
_0x40:
	SBIC 0x10,7
; 0000 00A9         result = KEYPAD_DIV;
	LDI  R17,LOW(10)
; 0000 00AA 
; 0000 00AB     ////////////////////////  ROW2 ////////////////////////
; 0000 00AC     KEYPAD_R1 = 0; KEYPAD_R2 = 1;  KEYPAD_R3 = 0;  KEYPAD_R4 = 0; //set Row2 for Keypad
_0x41:
_0x3F:
_0x3D:
	CBI  0x12,0
	SBI  0x12,1
	CALL SUBOPT_0xB
; 0000 00AD     delay_ms(5);
; 0000 00AE     if (KEYPAD_C1)
	SBIS 0x10,4
	RJMP _0x4B
; 0000 00AF         result = KEYPAD_NUM4;
	LDI  R17,LOW(4)
; 0000 00B0     else if (KEYPAD_C2)
	RJMP _0x4C
_0x4B:
	SBIS 0x10,5
	RJMP _0x4D
; 0000 00B1         result = KEYPAD_NUM5;
	LDI  R17,LOW(5)
; 0000 00B2     else if (KEYPAD_C3)
	RJMP _0x4E
_0x4D:
	SBIS 0x10,6
	RJMP _0x4F
; 0000 00B3         result = KEYPAD_NUM6;
	LDI  R17,LOW(6)
; 0000 00B4     else if (KEYPAD_C4)
	RJMP _0x50
_0x4F:
	SBIC 0x10,7
; 0000 00B5         result = KEYPAD_MUL;
	LDI  R17,LOW(11)
; 0000 00B6 
; 0000 00B7     ////////////////////////  ROW3 ////////////////////////
; 0000 00B8     KEYPAD_R1 = 0; KEYPAD_R2 = 0;  KEYPAD_R3 = 1;  KEYPAD_R4 = 0; //set Row3 for Keypad
_0x50:
_0x4E:
_0x4C:
	CBI  0x12,0
	CBI  0x12,1
	SBI  0x12,2
	CBI  0x12,3
; 0000 00B9     delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
; 0000 00BA     if (KEYPAD_C1)
	SBIS 0x10,4
	RJMP _0x5A
; 0000 00BB         result = KEYPAD_NUM1;
	LDI  R17,LOW(1)
; 0000 00BC     else if (KEYPAD_C2)
	RJMP _0x5B
_0x5A:
	SBIS 0x10,5
	RJMP _0x5C
; 0000 00BD         result = KEYPAD_NUM2;
	LDI  R17,LOW(2)
; 0000 00BE     else if (KEYPAD_C3)
	RJMP _0x5D
_0x5C:
	SBIS 0x10,6
	RJMP _0x5E
; 0000 00BF         result = KEYPAD_NUM3;
	LDI  R17,LOW(3)
; 0000 00C0     else if (KEYPAD_C4)
	RJMP _0x5F
_0x5E:
	SBIC 0x10,7
; 0000 00C1         result = KEYPAD_MNS;
	LDI  R17,LOW(13)
; 0000 00C2 
; 0000 00C3     ////////////////////////  ROW4 ////////////////////////
; 0000 00C4     KEYPAD_R1 = 0; KEYPAD_R2 = 0;  KEYPAD_R3 = 0;  KEYPAD_R4 = 1; //set Row4 for Keypad
_0x5F:
_0x5D:
_0x5B:
	CBI  0x12,0
	CBI  0x12,1
	CBI  0x12,2
	SBI  0x12,3
; 0000 00C5     delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
; 0000 00C6     if (KEYPAD_C1)
	SBIS 0x10,4
	RJMP _0x69
; 0000 00C7         result = KEYPAD_ON;
	LDI  R17,LOW(15)
; 0000 00C8     else if (KEYPAD_C2)
	RJMP _0x6A
_0x69:
	SBIS 0x10,5
	RJMP _0x6B
; 0000 00C9         result = KEYPAD_NUM0;
	LDI  R17,LOW(0)
; 0000 00CA     else if (KEYPAD_C3)
	RJMP _0x6C
_0x6B:
	SBIS 0x10,6
	RJMP _0x6D
; 0000 00CB         result = KEYPAD_EQU;
	LDI  R17,LOW(14)
; 0000 00CC     else if (KEYPAD_C4)
	RJMP _0x6E
_0x6D:
	SBIC 0x10,7
; 0000 00CD         result = KEYPAD_PLS;
	LDI  R17,LOW(12)
; 0000 00CE 
; 0000 00CF     return result;
_0x6E:
_0x6C:
_0x6A:
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0000 00D0 }
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 13
	SBI  0x15,2
	__DELAY_USB 13
	CBI  0x15,2
	__DELAY_USB 13
	RJMP _0x20A0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x20A0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xC
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xC
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x20A0001
_0x2000007:
_0x2000004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x15,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x15,0
	RJMP _0x20A0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20A0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.DSEG
_result:
	.BYTE 0x14
_num:
	.BYTE 0x14
_i:
	.BYTE 0x2
_digits:
	.BYTE 0x2
_res:
	.BYTE 0x2
_operand:
	.BYTE 0x2
_equal:
	.BYTE 0x2
_output:
	.BYTE 0xB
__base_y_G100:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1
__seed_G103:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	LDS  R26,_operand
	LDS  R27,_operand+1
	CPI  R26,LOW(0xFFFF)
	LDI  R30,HIGH(0xFFFF)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1:
	CALL _lcd_putchar
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R6,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDS  R30,_operand
	LDS  R31,_operand+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	STS  _operand,R30
	STS  _operand+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDS  R30,_equal
	LDS  R31,_equal+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	STS  _equal,R30
	STS  _equal+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	RCALL SUBOPT_0x4
	LDS  R26,_operand
	LDS  R27,_operand+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	LDS  R30,_i
	LDS  R31,_i+1
	LDI  R26,LOW(_result)
	LDI  R27,HIGH(_result)
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	LDS  R26,_res
	LDS  R27,_res+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	MOVW R0,R30
	LD   R30,Y
	LDI  R26,LOW(_num)
	LDI  R27,HIGH(_num)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	CBI  0x12,2
	CBI  0x12,3
	LDI  R26,LOW(5)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

;END OF CODE MARKER
__END_OF_CODE:
