
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
	.DEF _counter1=R4
	.DEF _counter2=R7
	.DEF _counter3=R6
	.DEF _counter4=R9
	.DEF _counter5=R8
	.DEF _counter6=R11
	.DEF _idx=R12
	.DEF _idx_msb=R13

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
	JMP  _timer0_comp_isr
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
	.DB  0x61,0x0,0x61,0x61
	.DB  0x61,0x61,0x0,0x62


__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  0x04
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
;
;// Declare your global variables here
;char a;
;char counter1='a', counter2='a', counter3='a', counter4='a', counter5='a', counter6='b' ;
;int idx, idx2 ;
;//int delay = 0;
;// Standard Input/Output functions
;#include <stdio.h>
;
;unsigned char number (unsigned char digit) {
; 0000 000B unsigned char number (unsigned char digit) {

	.CSEG
_number:
; .FSTART _number
; 0000 000C     if (digit == 0) {
	ST   -Y,R26
;	digit -> Y+0
	LD   R30,Y
	CPI  R30,0
	BRNE _0x3
; 0000 000D         return 0x3F;
	LDI  R30,LOW(63)
	RJMP _0x2060001
; 0000 000E     }
; 0000 000F     if (digit == 1) {
_0x3:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x4
; 0000 0010         return 0x06;
	LDI  R30,LOW(6)
	RJMP _0x2060001
; 0000 0011     }
; 0000 0012     if (digit == 2) {
_0x4:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x5
; 0000 0013         return 0x5B;
	LDI  R30,LOW(91)
	RJMP _0x2060001
; 0000 0014     }
; 0000 0015     if (digit == 3) {
_0x5:
	LD   R26,Y
	CPI  R26,LOW(0x3)
	BRNE _0x6
; 0000 0016         return 0x4F;
	LDI  R30,LOW(79)
	RJMP _0x2060001
; 0000 0017     }
; 0000 0018     if (digit == 4) {
_0x6:
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRNE _0x7
; 0000 0019         return 0x66;
	LDI  R30,LOW(102)
	RJMP _0x2060001
; 0000 001A     }
; 0000 001B     if (digit == 5) {
_0x7:
	LD   R26,Y
	CPI  R26,LOW(0x5)
	BRNE _0x8
; 0000 001C         return 0x6D;
	LDI  R30,LOW(109)
	RJMP _0x2060001
; 0000 001D     }
; 0000 001E     if (digit == 6) {
_0x8:
	LD   R26,Y
	CPI  R26,LOW(0x6)
	BRNE _0x9
; 0000 001F         return 0x7D;
	LDI  R30,LOW(125)
	RJMP _0x2060001
; 0000 0020     }
; 0000 0021     if (digit == 7) {
_0x9:
	LD   R26,Y
	CPI  R26,LOW(0x7)
	BRNE _0xA
; 0000 0022         return 0x07;
	LDI  R30,LOW(7)
	RJMP _0x2060001
; 0000 0023     }
; 0000 0024     if (digit == 8) {
_0xA:
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRNE _0xB
; 0000 0025         return 0x7F;
	LDI  R30,LOW(127)
	RJMP _0x2060001
; 0000 0026     }
; 0000 0027     if (digit == 9) {
_0xB:
	LD   R26,Y
	CPI  R26,LOW(0x9)
	BRNE _0xC
; 0000 0028         return 0x6F;
	LDI  R30,LOW(111)
	RJMP _0x2060001
; 0000 0029     }
; 0000 002A }
_0xC:
	RJMP _0x2060001
; .FEND
;
;void set_number(char c){
; 0000 002C void set_number(char c){
_set_number:
; .FSTART _set_number
; 0000 002D     if (c == '0'){
	ST   -Y,R26
;	c -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x30)
	BRNE _0xD
; 0000 002E         PORTC = number(0);
	LDI  R26,LOW(0)
	RCALL _number
	RJMP _0x31
; 0000 002F     }
; 0000 0030     else if (c == '1'){
_0xD:
	LD   R26,Y
	CPI  R26,LOW(0x31)
	BRNE _0xF
; 0000 0031         PORTC = number(1);
	LDI  R26,LOW(1)
	RCALL _number
	RJMP _0x31
; 0000 0032     }
; 0000 0033     else if (c == '2'){
_0xF:
	LD   R26,Y
	CPI  R26,LOW(0x32)
	BRNE _0x11
; 0000 0034         PORTC = number(2);
	LDI  R26,LOW(2)
	RCALL _number
	RJMP _0x31
; 0000 0035     }
; 0000 0036     else if (c == '3'){
_0x11:
	LD   R26,Y
	CPI  R26,LOW(0x33)
	BRNE _0x13
; 0000 0037         PORTC = number(3);
	LDI  R26,LOW(3)
	RCALL _number
	RJMP _0x31
; 0000 0038     }
; 0000 0039     else if (c == '4'){
_0x13:
	LD   R26,Y
	CPI  R26,LOW(0x34)
	BRNE _0x15
; 0000 003A         PORTC = number(4);
	LDI  R26,LOW(4)
	RCALL _number
	RJMP _0x31
; 0000 003B     }
; 0000 003C     else if (c == '5'){
_0x15:
	LD   R26,Y
	CPI  R26,LOW(0x35)
	BRNE _0x17
; 0000 003D         PORTC = number(5);
	LDI  R26,LOW(5)
	RCALL _number
	RJMP _0x31
; 0000 003E     }
; 0000 003F     else if (c == '6'){
_0x17:
	LD   R26,Y
	CPI  R26,LOW(0x36)
	BRNE _0x19
; 0000 0040         PORTC = number(6);
	LDI  R26,LOW(6)
	RCALL _number
	RJMP _0x31
; 0000 0041     }
; 0000 0042     else if (c == '7'){
_0x19:
	LD   R26,Y
	CPI  R26,LOW(0x37)
	BRNE _0x1B
; 0000 0043         PORTC = number(7);
	LDI  R26,LOW(7)
	RCALL _number
	RJMP _0x31
; 0000 0044     }
; 0000 0045     else if (c == '8'){
_0x1B:
	LD   R26,Y
	CPI  R26,LOW(0x38)
	BRNE _0x1D
; 0000 0046         PORTC = number(8);
	LDI  R26,LOW(8)
	RCALL _number
	RJMP _0x31
; 0000 0047     }
; 0000 0048     else if (c == '9'){
_0x1D:
	LD   R26,Y
	CPI  R26,LOW(0x39)
	BRNE _0x1F
; 0000 0049         PORTC = number(9);
	LDI  R26,LOW(9)
	RCALL _number
	RJMP _0x31
; 0000 004A     }
; 0000 004B     else {
_0x1F:
; 0000 004C         PORTC = 0x00;
	LDI  R30,LOW(0)
_0x31:
	OUT  0x15,R30
; 0000 004D     }
; 0000 004E }
_0x2060001:
	ADIW R28,1
	RET
; .FEND
;
;// Timer 0 output compare interrupt service routine
;interrupt [TIM0_COMP] void timer0_comp_isr(void)
; 0000 0052 {
_timer0_comp_isr:
; .FSTART _timer0_comp_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0053 // Place your code here
; 0000 0054     idx++;
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
; 0000 0055     idx = idx % 6;
	MOVW R26,R12
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MODW21
	MOVW R12,R30
; 0000 0056     if (idx == 0) {
	MOV  R0,R12
	OR   R0,R13
	BRNE _0x21
; 0000 0057         PORTB = 0b10111111;
	LDI  R30,LOW(191)
	OUT  0x18,R30
; 0000 0058         set_number(counter1);
	MOV  R26,R4
	RCALL _set_number
; 0000 0059     }
; 0000 005A 
; 0000 005B     if (idx == 1) {
_0x21:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x22
; 0000 005C         PORTB = 0b11011111;
	LDI  R30,LOW(223)
	OUT  0x18,R30
; 0000 005D         set_number(counter2);
	MOV  R26,R7
	RCALL _set_number
; 0000 005E     }
; 0000 005F 
; 0000 0060     if (idx == 2) {
_0x22:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x23
; 0000 0061         PORTB = 0b11101111;
	LDI  R30,LOW(239)
	OUT  0x18,R30
; 0000 0062         set_number(counter3);
	MOV  R26,R6
	RCALL _set_number
; 0000 0063     }
; 0000 0064 
; 0000 0065     if (idx == 3) {
_0x23:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x24
; 0000 0066         PORTB = 0b11110111;
	LDI  R30,LOW(247)
	OUT  0x18,R30
; 0000 0067         set_number(counter4);
	MOV  R26,R9
	RCALL _set_number
; 0000 0068     }
; 0000 0069 
; 0000 006A     if (idx == 4) {
_0x24:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x25
; 0000 006B         PORTB = 0b11111011;
	LDI  R30,LOW(251)
	OUT  0x18,R30
; 0000 006C         set_number(counter5);
	MOV  R26,R8
	RCALL _set_number
; 0000 006D     }
; 0000 006E 
; 0000 006F      if (idx == 5) {
_0x25:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x26
; 0000 0070         PORTB = 0b11111101;
	LDI  R30,LOW(253)
	OUT  0x18,R30
; 0000 0071         set_number(counter6);
	MOV  R26,R11
	RCALL _set_number
; 0000 0072       }
; 0000 0073 }
_0x26:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0076 {
_main:
; .FSTART _main
; 0000 0077 // Declare your local variables here
; 0000 0078 
; 0000 0079 // Input/Output Ports initialization
; 0000 007A     // Input/Output Ports initialization
; 0000 007B     // Port A initialization
; 0000 007C     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 007D     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 007E     PORTA = 0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 007F     DDRA = 0x00;
	OUT  0x1A,R30
; 0000 0080 
; 0000 0081     // Port B initialization
; 0000 0082     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0083     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0084     PORTB = 0x0ff;
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0000 0085     DDRB = 0xff;
	OUT  0x17,R30
; 0000 0086 
; 0000 0087     // Port C initialization
; 0000 0088     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0089     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 008A     PORTC = 0xFF;
	OUT  0x15,R30
; 0000 008B     DDRC = 0xFF;
	OUT  0x14,R30
; 0000 008C 
; 0000 008D     // Port D initialization
; 0000 008E     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 008F     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0090     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0091     DDRD = 0x00;
	OUT  0x11,R30
; 0000 0092 // Timer/Counter 0 initialization
; 0000 0093 // Clock source: System Clock
; 0000 0094 // Clock value: 125.000 kHz
; 0000 0095 // Mode: Normal top=0xFF
; 0000 0096 // OC0 output: Disconnected
; 0000 0097 // Timer Period: 2.048 ms
; 0000 0098 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
	LDI  R30,LOW(3)
	OUT  0x33,R30
; 0000 0099 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 009A OCR0=0x00;
	OUT  0x3C,R30
; 0000 009B 
; 0000 009C // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 009D TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (1<<OCIE0) | (0<<TOIE0);
	LDI  R30,LOW(2)
	OUT  0x39,R30
; 0000 009E 
; 0000 009F // USART initialization
; 0000 00A0 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00A1 // USART Receiver: On
; 0000 00A2 // USART Transmitter: On
; 0000 00A3 // USART Mode: Asynchronous
; 0000 00A4 // USART Baud Rate: 9600
; 0000 00A5 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 00A6 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(24)
	OUT  0xA,R30
; 0000 00A7 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 00A8 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 00A9 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 00AA 
; 0000 00AB // Global enable interrupts
; 0000 00AC #asm("sei")
	sei
; 0000 00AD 
; 0000 00AE while (1)
_0x27:
; 0000 00AF       {
; 0000 00B0       // Place your code here
; 0000 00B1     a = getchar();
	RCALL _getchar
	MOV  R5,R30
; 0000 00B2     if (idx2 == 0) {
	LDS  R30,_idx2
	LDS  R31,_idx2+1
	SBIW R30,0
	BRNE _0x2A
; 0000 00B3         counter2 = 'a';
	LDI  R30,LOW(97)
	MOV  R7,R30
; 0000 00B4         counter3 = 'a';
	MOV  R6,R30
; 0000 00B5         counter4 = 'a';
	MOV  R9,R30
; 0000 00B6         counter5 = 'a';
	MOV  R8,R30
; 0000 00B7         counter1 = 'a';
	MOV  R4,R30
; 0000 00B8         counter6 = a;
	MOV  R11,R5
; 0000 00B9     }
; 0000 00BA 
; 0000 00BB     if (idx2 == 5) {
_0x2A:
	CALL SUBOPT_0x0
	SBIW R26,5
	BRNE _0x2B
; 0000 00BC         counter1 = a;
	MOV  R4,R5
; 0000 00BD     }
; 0000 00BE 
; 0000 00BF     if (idx2 == 4) {
_0x2B:
	CALL SUBOPT_0x0
	SBIW R26,4
	BRNE _0x2C
; 0000 00C0         counter2 = a;
	MOV  R7,R5
; 0000 00C1     }
; 0000 00C2 
; 0000 00C3     if (idx2 == 3) {
_0x2C:
	CALL SUBOPT_0x0
	SBIW R26,3
	BRNE _0x2D
; 0000 00C4         counter3 = a;
	MOV  R6,R5
; 0000 00C5     }
; 0000 00C6 
; 0000 00C7     if (idx2 == 2) {
_0x2D:
	CALL SUBOPT_0x0
	SBIW R26,2
	BRNE _0x2E
; 0000 00C8         counter4 = a;
	MOV  R9,R5
; 0000 00C9     }
; 0000 00CA 
; 0000 00CB      if (idx2 == 1) {
_0x2E:
	CALL SUBOPT_0x0
	SBIW R26,1
	BRNE _0x2F
; 0000 00CC         counter5 = a;
	MOV  R8,R5
; 0000 00CD       }
; 0000 00CE       idx2++;
_0x2F:
	LDI  R26,LOW(_idx2)
	LDI  R27,HIGH(_idx2)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 00CF       idx2 %= 6;
	CALL SUBOPT_0x0
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MODW21
	STS  _idx2,R30
	STS  _idx2+1,R31
; 0000 00D0 }
	RJMP _0x27
; 0000 00D1 }
_0x30:
	RJMP _0x30
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
_idx2:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	LDS  R26,_idx2
	LDS  R27,_idx2+1
	RET


	.CSEG
__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

;END OF CODE MARKER
__END_OF_CODE:
