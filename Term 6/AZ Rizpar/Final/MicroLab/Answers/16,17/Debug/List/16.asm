
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
	.DEF _a=R5
	.DEF _count=R6
	.DEF _count_msb=R7

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

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x06
	.DW  __REG_VARS*2

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
;#include <delay.h>
;#include <stdio.h>
;
;
;//void usart_send_string(char *str);
;    // Declare your global variables here
;    char a;
;    int count = 0;
;    //int show_flag = 0;
;    char numbers_array[6];
;
;    //void delay() {
;      //  TCCR0 = (1 << CS02) | (1 << CS00);
;      //  TCNT0 = 251;
;      //  while ((TIFR & (1 << TOV0)) == 0);
;      //  TIFR = (1 << TOV0);
;    //}
;
;unsigned char number (unsigned char digit) {
; 0000 0014 unsigned char number (unsigned char digit) {

	.CSEG
_number:
; .FSTART _number
; 0000 0015     if (digit == 0) {
	ST   -Y,R26
;	digit -> Y+0
	LD   R30,Y
	CPI  R30,0
	BRNE _0x3
; 0000 0016         return 0x3F;
	LDI  R30,LOW(63)
	RJMP _0x2060001
; 0000 0017     }
; 0000 0018     if (digit == 1) {
_0x3:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x4
; 0000 0019         return 0x06;
	LDI  R30,LOW(6)
	RJMP _0x2060001
; 0000 001A     }
; 0000 001B     if (digit == 2) {
_0x4:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x5
; 0000 001C         return 0x5B;
	LDI  R30,LOW(91)
	RJMP _0x2060001
; 0000 001D     }
; 0000 001E     if (digit == 3) {
_0x5:
	LD   R26,Y
	CPI  R26,LOW(0x3)
	BRNE _0x6
; 0000 001F         return 0x4F;
	LDI  R30,LOW(79)
	RJMP _0x2060001
; 0000 0020     }
; 0000 0021     if (digit == 4) {
_0x6:
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRNE _0x7
; 0000 0022         return 0x66;
	LDI  R30,LOW(102)
	RJMP _0x2060001
; 0000 0023     }
; 0000 0024     if (digit == 5) {
_0x7:
	LD   R26,Y
	CPI  R26,LOW(0x5)
	BRNE _0x8
; 0000 0025         return 0x6D;
	LDI  R30,LOW(109)
	RJMP _0x2060001
; 0000 0026     }
; 0000 0027     if (digit == 6) {
_0x8:
	LD   R26,Y
	CPI  R26,LOW(0x6)
	BRNE _0x9
; 0000 0028         return 0x7D;
	LDI  R30,LOW(125)
	RJMP _0x2060001
; 0000 0029     }
; 0000 002A     if (digit == 7) {
_0x9:
	LD   R26,Y
	CPI  R26,LOW(0x7)
	BRNE _0xA
; 0000 002B         return 0x07;
	LDI  R30,LOW(7)
	RJMP _0x2060001
; 0000 002C     }
; 0000 002D     if (digit == 8) {
_0xA:
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRNE _0xB
; 0000 002E         return 0x7F;
	LDI  R30,LOW(127)
	RJMP _0x2060001
; 0000 002F     }
; 0000 0030     if (digit == 9) {
_0xB:
	LD   R26,Y
	CPI  R26,LOW(0x9)
	BRNE _0xC
; 0000 0031         return 0x6F;
	LDI  R30,LOW(111)
	RJMP _0x2060001
; 0000 0032     }
; 0000 0033 }
_0xC:
	RJMP _0x2060001
; .FEND
;
;void set_number(char c){
; 0000 0035 void set_number(char c){
_set_number:
; .FSTART _set_number
; 0000 0036     if (c == '0'){
	ST   -Y,R26
;	c -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x30)
	BRNE _0xD
; 0000 0037         PORTC = number(0);
	LDI  R26,LOW(0)
	RCALL _number
	OUT  0x15,R30
; 0000 0038     }
; 0000 0039     if (c == '1'){
_0xD:
	LD   R26,Y
	CPI  R26,LOW(0x31)
	BRNE _0xE
; 0000 003A         PORTC = number(1);
	LDI  R26,LOW(1)
	RCALL _number
	OUT  0x15,R30
; 0000 003B     }
; 0000 003C     if (c == '2'){
_0xE:
	LD   R26,Y
	CPI  R26,LOW(0x32)
	BRNE _0xF
; 0000 003D         PORTC = number(2);
	LDI  R26,LOW(2)
	RCALL _number
	OUT  0x15,R30
; 0000 003E     }
; 0000 003F     if (c == '3'){
_0xF:
	LD   R26,Y
	CPI  R26,LOW(0x33)
	BRNE _0x10
; 0000 0040         PORTC = number(3);
	LDI  R26,LOW(3)
	RCALL _number
	OUT  0x15,R30
; 0000 0041     }
; 0000 0042     if (c == '4'){
_0x10:
	LD   R26,Y
	CPI  R26,LOW(0x34)
	BRNE _0x11
; 0000 0043         PORTC = number(4);
	LDI  R26,LOW(4)
	RCALL _number
	OUT  0x15,R30
; 0000 0044     }
; 0000 0045     if (c == '5'){
_0x11:
	LD   R26,Y
	CPI  R26,LOW(0x35)
	BRNE _0x12
; 0000 0046         PORTC = number(5);
	LDI  R26,LOW(5)
	RCALL _number
	OUT  0x15,R30
; 0000 0047     }
; 0000 0048     if (c == '6'){
_0x12:
	LD   R26,Y
	CPI  R26,LOW(0x36)
	BRNE _0x13
; 0000 0049         PORTC = number(6);
	LDI  R26,LOW(6)
	RCALL _number
	OUT  0x15,R30
; 0000 004A     }
; 0000 004B     if (c == '7'){
_0x13:
	LD   R26,Y
	CPI  R26,LOW(0x37)
	BRNE _0x14
; 0000 004C         PORTC = number(7);
	LDI  R26,LOW(7)
	RCALL _number
	OUT  0x15,R30
; 0000 004D     }
; 0000 004E     if (c == '8'){
_0x14:
	LD   R26,Y
	CPI  R26,LOW(0x38)
	BRNE _0x15
; 0000 004F         PORTC = number(8);
	LDI  R26,LOW(8)
	RCALL _number
	OUT  0x15,R30
; 0000 0050     }
; 0000 0051     if (c == '9'){
_0x15:
	LD   R26,Y
	CPI  R26,LOW(0x39)
	BRNE _0x16
; 0000 0052         PORTC = number(9);
	LDI  R26,LOW(9)
	RCALL _number
	OUT  0x15,R30
; 0000 0053     }
; 0000 0054 }
_0x16:
_0x2060001:
	ADIW R28,1
	RET
; .FEND
;
;void main(void) {
; 0000 0056 void main(void) {
_main:
; .FSTART _main
; 0000 0057     // Declare your local variables here
; 0000 0058 
; 0000 0059     // Input/Output Ports initialization
; 0000 005A     // Port A initialization
; 0000 005B     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005C     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005D     PORTA = 0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 005E     DDRA = 0x00;
	OUT  0x1A,R30
; 0000 005F 
; 0000 0060     // Port B initialization
; 0000 0061     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0062     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0063     PORTB = 0x0ff;
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0000 0064     DDRB = 0xff;
	OUT  0x17,R30
; 0000 0065 
; 0000 0066     // Port C initialization
; 0000 0067     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0068     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0069     PORTC = 0xFF;
	OUT  0x15,R30
; 0000 006A     DDRC = 0xFF;
	OUT  0x14,R30
; 0000 006B 
; 0000 006C     // Port D initialization
; 0000 006D     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 006E     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006F     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0070     DDRD = 0x00;
	OUT  0x11,R30
; 0000 0071 
; 0000 0072     // Timer/Counter 0 initialization
; 0000 0073     // Clock source: System Clock
; 0000 0074     // Clock value: Timer 0 Stopped
; 0000 0075     // Mode: Normal top=0xFF
; 0000 0076     // OC0 output: Disconnected
; 0000 0077     TCCR0 = 0x00;
	OUT  0x33,R30
; 0000 0078     TCNT0 = 0x00;
	OUT  0x32,R30
; 0000 0079     OCR0 = 0x00;
	OUT  0x3C,R30
; 0000 007A 
; 0000 007B     // Timer/Counter 1 initialization
; 0000 007C     // Clock source: System Clock
; 0000 007D     // Clock value: Timer1 Stopped
; 0000 007E     // Mode: Normal top=0xFFFF
; 0000 007F     // OC1A output: Discon.
; 0000 0080     // OC1B output: Discon.
; 0000 0081     // Noise Canceler: Off
; 0000 0082     // Input Capture on Falling Edge
; 0000 0083     // Timer1 Overflow Interrupt: Off
; 0000 0084     // Input Capture Interrupt: Off
; 0000 0085     // Compare A Match Interrupt: Off
; 0000 0086     // Compare B Match Interrupt: Off
; 0000 0087     TCCR1A = 0x00;
	OUT  0x2F,R30
; 0000 0088     TCCR1B = 0x00;
	OUT  0x2E,R30
; 0000 0089     TCNT1H = 0x00;
	OUT  0x2D,R30
; 0000 008A     TCNT1L = 0x00;
	OUT  0x2C,R30
; 0000 008B     ICR1H = 0x00;
	OUT  0x27,R30
; 0000 008C     ICR1L = 0x00;
	OUT  0x26,R30
; 0000 008D     OCR1AH = 0x00;
	OUT  0x2B,R30
; 0000 008E     OCR1AL = 0x00;
	OUT  0x2A,R30
; 0000 008F     OCR1BH = 0x00;
	OUT  0x29,R30
; 0000 0090     OCR1BL = 0x00;
	OUT  0x28,R30
; 0000 0091 
; 0000 0092     // Timer/Counter 2 initialization
; 0000 0093     // Clock source: System Clock
; 0000 0094     // Clock value: Timer2 Stopped
; 0000 0095     // Mode: Normal top=0xFF
; 0000 0096     // OC2 output: Disconnected
; 0000 0097     ASSR = 0x00;
	OUT  0x22,R30
; 0000 0098     TCCR2 = 0x00;
	OUT  0x25,R30
; 0000 0099     TCNT2 = 0x00;
	OUT  0x24,R30
; 0000 009A     OCR2 = 0x00;
	OUT  0x23,R30
; 0000 009B 
; 0000 009C     // External Interrupt(s) initialization
; 0000 009D     // INT0: Off
; 0000 009E     // INT1: Off
; 0000 009F     // INT2: Off
; 0000 00A0     MCUCR = 0x00;
	OUT  0x35,R30
; 0000 00A1     MCUCSR = 0x00;
	OUT  0x34,R30
; 0000 00A2 
; 0000 00A3     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00A4     TIMSK = 0x00;
	OUT  0x39,R30
; 0000 00A5 
; 0000 00A6     // USART initialization
; 0000 00A7     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00A8     // USART Receiver: On
; 0000 00A9     // USART Transmitter: On
; 0000 00AA     // USART Mode: Asynchronous
; 0000 00AB     // USART Baud Rate: 9600
; 0000 00AC     UCSRA = 0x00;
	OUT  0xB,R30
; 0000 00AD     UCSRB = 0x18;
	LDI  R30,LOW(24)
	OUT  0xA,R30
; 0000 00AE     UCSRC = 0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 00AF     UBRRH = 0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 00B0     UBRRL = 0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 00B1 
; 0000 00B2     // Analog Comparator initialization
; 0000 00B3     // Analog Comparator: Off
; 0000 00B4     // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00B5     ACSR = 0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00B6     SFIOR = 0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00B7 
; 0000 00B8     // ADC initialization
; 0000 00B9     // ADC disabled
; 0000 00BA     ADCSRA = 0x00;
	OUT  0x6,R30
; 0000 00BB 
; 0000 00BC     // SPI initialization
; 0000 00BD     // SPI disabled
; 0000 00BE     SPCR = 0x00;
	OUT  0xD,R30
; 0000 00BF 
; 0000 00C0     // TWI initialization
; 0000 00C1     // TWI disabled
; 0000 00C2     TWCR = 0x00;
	OUT  0x36,R30
; 0000 00C3 
; 0000 00C4     // Alphanumeric LCD initialization
; 0000 00C5     // Connections are specified in the
; 0000 00C6     // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00C7     // RS - PORTC Bit 0
; 0000 00C8     // RD - PORTC Bit 1
; 0000 00C9     // EN - PORTC Bit 2
; 0000 00CA     // D4 - PORTC Bit 4
; 0000 00CB     // D5 - PORTC Bit 5
; 0000 00CC     // D6 - PORTC Bit 6
; 0000 00CD     // D7 - PORTC Bit 7
; 0000 00CE     while (1) {
_0x17:
; 0000 00CF         a = getchar();
	RCALL _getchar
	MOV  R5,R30
; 0000 00D0 
; 0000 00D1         numbers_array[count] = a;
	MOVW R30,R6
	SUBI R30,LOW(-_numbers_array)
	SBCI R31,HIGH(-_numbers_array)
	ST   Z,R5
; 0000 00D2         if (count == 6){
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x1A
; 0000 00D3             count = 0;
	CLR  R6
	CLR  R7
; 0000 00D4         }
; 0000 00D5         count++;
_0x1A:
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
; 0000 00D6 
; 0000 00D7         if (count > 0) {
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BRGE _0x1B
; 0000 00D8             PORTB = 0b10111111;
	LDI  R30,LOW(191)
	OUT  0x18,R30
; 0000 00D9             set_number(numbers_array[0]);
	LDS  R26,_numbers_array
	RCALL _set_number
; 0000 00DA         }
; 0000 00DB 
; 0000 00DC         if (count > 1) {
_0x1B:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BRGE _0x1C
; 0000 00DD             PORTB = 0b11011111;
	LDI  R30,LOW(223)
	OUT  0x18,R30
; 0000 00DE             set_number(numbers_array[1]);
	__GETB2MN _numbers_array,1
	RCALL _set_number
; 0000 00DF         }
; 0000 00E0 
; 0000 00E1         if (count > 2) {
_0x1C:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R6
	CPC  R31,R7
	BRGE _0x1D
; 0000 00E2             PORTB = 0b11101111;
	LDI  R30,LOW(239)
	OUT  0x18,R30
; 0000 00E3             set_number(numbers_array[2]);
	__GETB2MN _numbers_array,2
	RCALL _set_number
; 0000 00E4         }
; 0000 00E5 
; 0000 00E6         if (count > 3) {
_0x1D:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R6
	CPC  R31,R7
	BRGE _0x1E
; 0000 00E7             PORTB = 0b11110111;
	LDI  R30,LOW(247)
	OUT  0x18,R30
; 0000 00E8             set_number(numbers_array[3]);
	__GETB2MN _numbers_array,3
	RCALL _set_number
; 0000 00E9         }
; 0000 00EA 
; 0000 00EB         if (count > 4) {
_0x1E:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R6
	CPC  R31,R7
	BRGE _0x1F
; 0000 00EC             PORTB = 0b11111011;
	LDI  R30,LOW(251)
	OUT  0x18,R30
; 0000 00ED             set_number(numbers_array[4]);
	__GETB2MN _numbers_array,4
	RCALL _set_number
; 0000 00EE         }
; 0000 00EF 
; 0000 00F0          if (count > 5) {
_0x1F:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R6
	CPC  R31,R7
	BRGE _0x20
; 0000 00F1             PORTB = 0b11111101;
	LDI  R30,LOW(253)
	OUT  0x18,R30
; 0000 00F2             set_number(numbers_array[5]);
	__GETB2MN _numbers_array,5
	RCALL _set_number
; 0000 00F3         }
; 0000 00F4     }
_0x20:
	RJMP _0x17
; 0000 00F5 }
_0x21:
	RJMP _0x21
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

	.CSEG
_getchar:
; .FSTART _getchar
getchar0:
     sbis usr,rxc
     rjmp getchar0
     in   r30,udr
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_numbers_array:
	.BYTE 0x6

	.CSEG

	.CSEG
;END OF CODE MARKER
__END_OF_CODE:
