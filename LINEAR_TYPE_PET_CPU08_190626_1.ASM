;CPU18 PROGRAM CONVERT INTO CPU-08DATED:291025
;------------------------------------------------------------------------
;POWER ON HEATER ON PROBLEM SOLVED BY VINAYAK DATED:310724
;---------------------------------------------------------------------------------------------
;TMR HANDLER 00 MODIFIED BY SIR,REMAINING UPTO TM79 HANDLER MODIFIED BY VINAYAK DATED:110422
;----------------------------------------------------------------
;24INPUTS,24OUTPUTS,POWER CONTROL ZONES TESTING OK DATED:070422
;OUTPUT LED BLINKING PROBLEM SOLVED BY SIR DATED:070422
;---------------------------------------------------------
;TESTING PROGRAM DONE BY VINAYAK DATED:010322
;--------------------------------------------------------
;POWER TABLE REMODIFIED BY SIR DATED 260222
;-------------------------------------------------------------------------------
;POWER TABLE MODIFIED AS PER OP310 TABLE DATED:120222
;-------------------------------------------------------------------------------
;POWER ON BULB ON PROBLEM RECTIFIED DATED:040222_HARDWARE CHANGES ALSO DONE
;LADDER PROGRAM_PROD_COUNTER ADDED BY VINAYAK DATED:040222
;-----------------------------------------------------
;HEATING ZONE1 TEST BY SIR DATED:030222
;INPUT OUTPUT PROBLEM SOLVED BY SIR DATED:020222
;----------------------------------------------------------
;PCA_ISR AND LADDER PROG CHECK FOR HIGH SPEED O/P TEST
;HIGH SPEED O/P PROGRAM ADD BY VINAYAK DATED:090721
;----------------------------------------------
;ZONE TEST HOLD PROGRAM DONE DATED:040220
;-----------------------------------------------
;REGULAR FLAG PROGRAM DONE DATED:021119
;------------------------------------------
;SERVO WITH 2 ZONE TC TEST PROGRAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;EDITED ON 24/03/2019
;BROWN OUT INTERRUPT DID NOT WORK BUT INSTEAD BROWN OUT FLAG BOS WAS USED TO BACK UP DATA
;BOS FLAG IS BIT 0 OF POWER MONITORING CONTROL PMC(ADD 0ACH)
;---------------------------------------------------------------------------
;ADC,DAC,INPUT,OUTPUT TESTED OK DATED:150319
;--------------------------------------------------------------------------
;EEPROM PROGRAM CHANGING STARTS FROM HERE DATED OPEN_FRAME_PLC_120319_2
;IF PROBLEM USE PROGRAM FROM OPEN_FRAME_PLC_120319_1
;-----------------------------------------------------------------------
;LAST EDITED ON 10/03 2019
;PROGRAMMED FN CODE 02 ,03,10H  TESTING IS PENDING 
;----------------------------------------------------
;FN CODE 01  IS READ COIL STATUS                 :DONE
;FN CODE 02  IS READ INPUT STATUS
;FN CODE 03  IS READ HOLDING REGISTERS           :DONE
;FN CODE 04  IS READ INPUT REGISTERS
;FN CODE 05  IS READ SINGLE COIL                 :DONE
;FN CODE 06  IS PRESET SINGLE REGISTERS          :DONE
;FN CODE 15(0FH) IS FORCE MULTIPLE COILS         :DONE
;FN CODE 16(10H) IS FORCE MULTIPLE REGISTERS


;------------------------------------------------------
TEMP_CAL_FACTOR_HI   EQU   30H    ;TC CAL FACTOR
;TEMP_CAL_FACTOR_HI   EQU   22H    ;PT100 CAL FACTOR
TEMP_CAL_FACTOR_LO   EQU   0A0H
;-------------------------------------------------------
;---------------------------------------------------------
;DEFINE I/O ADDRESS
;----------------------------------------------------------

OUTPUT_ADDRESS    EQU    0E800H 
INPUT_ADDRESS     EQU    0F800H 

POW_CNTL_ADD_Z1   EQU    0E080H
POW_CNTL_ADD_Z2   EQU    0E081H
POW_CNTL_ADD_Z3   EQU    0E082H
POW_CNTL_ADD_Z4   EQU    0E083H
POW_CNTL_ADD_Z5   EQU    0E084H
POW_CNTL_ADD_Z6   EQU    0E085H
POW_CNTL_ADD_Z7   EQU    0E086H
POW_CNTL_ADD_Z8   EQU    0E087H
POW_CNTL_ADD_Z9   EQU    0E088H
POW_CNTL_ADD_Z10  EQU    0E089H
POW_CNTL_ADD_Z11  EQU    0E08AH
POW_CNTL_ADD_Z12  EQU    0E08BH
POW_CNTL_ADD_Z13  EQU    0E08CH
POW_CNTL_ADD_Z14  EQU    0E08DH
POW_CNTL_ADD_Z15  EQU    0E08EH
POW_CNTL_ADD_Z16  EQU    0E08FH


;OUTPUT_ADDRESS    EQU    0F000H
;INPUT_ADDRESS     EQU    0F000H
;TEMP_IP_12_L      EQU    0F018H
;TEMP_IP_12_H      EQU    0F019H


;CE_LOAD           EQU    P1.7
;HBEN              EQU    P1.6
;LBEN              EQU    P1.5
;STATUS            EQU    P3.4
;CT0               EQU    P3.2
;CT1               EQU    P3.3

;MUX_A             EQU   P2.6
;MUX_B             EQU   P2.5
;MUX_C             EQU   P2.4
;MUX_ENABLE        EQU   P2.7

;IP1_SEL           EQU   P1.6
;IP2_SEL           EQU   P1.5
;OP1_SEL           EQU   P1.7
;OP2_SEL           EQU   P1.4
;OP3_SEL           EQU   P1.3
;IP_BUS            EQU   P2
;-----------------------------------
PC_A             EQU   0DAH      ;P4.2
MUX_A            EQU   0DAH


PC_B             EQU   P1.1
MUX_B            EQU   P1.1

PC_C             EQU   P1.2
MUX_C            EQU   P1.2

MUX_ENABLE       EQU   0D9H   ;P4.1

IP1_SEL           EQU   P1.6
IP2_SEL           EQU   P1.5
OP1_SEL           EQU   P1.7
OP2_SEL           EQU   P1.4
OP3_SEL           EQU   P1.3
IP_BUS            EQU   P2


;SYS_RST           NOT USED       
;----------------------------------------------------
;define bit variables here...
;----------------------------------------------------
;----------------------------------------------------
;INTERNAL RAM LOCATIONS
;----------------------------------------------------
R0_ADDR           EQU   00H
R1_ADDR           EQU   01H

BYTE_CNT          EQU	08H
TEMP		  EQU	09H
TIMECT            EQU   0AH
IP_DEBOUNCE       EQU   0BH
LRC_CODE      	  EQU	0CH
LRC_HI	          EQU	0DH
LRC_LO		  EQU	0EH
COUNT_1S	  EQU	0FH
TEMP1             EQU   10H        ;MSB
TEMP2             EQU   11H        ;LSB                       ;40H                 ;25H
RSLT_0            EQU   1AH
RSLT_1            EQU   1BH        ;40H
SECOND_CLK        EQU   1CH
A2D_CHANNEL       EQU   1DH
SCRATCHPAD_0      EQU   1EH
SCRATCHPAD_1      EQU   1FH 

;SCRATCHPAD_2              EQU    35H
;SCRATCHPAD_3              EQU    36H


GENERAL_PURPOSE_BITS_1    EQU   20H

RCVE_OVER                 EQU	  00H	                      
TRANS_OVER                EQU	  01H	                      
BIT_READ_MORE_THAN_8      EQU	  02H	
TEN_MSEC_BIT              EQU     03H
FIRST_BYTE                EQU	  04H	                   
LAST_BYTE                 EQU	  05H	                                                            
DELAY_OVER                EQU     06H
B_FIRST_CYCLE             EQU     07H
;----------------------------------------------------
GENERAL_PURPOSE_BITS_2    EQU   21H

GENERAL_BIT_0             EQU   08H     ;USED IN STATUS DEBOUNCING
MOULD_CLOSE_OVER          EQU   09H
AUTO_MAN_SEL              EQU   0AH
HUND_MSEC_BIT             EQU   0BH
EJECTOR_ENABLE            EQU   0CH
BLOWING_ENABLE            EQU   0DH
TEMP_BIT                  EQU   0EH  ;FOR I/O SHIFTING PROGRAM
CYCLE_START               EQU   0FH
;----------------------------------------------------
DC_INPUT0                 EQU    22H
INPUT_DISPLAY_ADDRESS     EQU    22H
BIT_START_ADDRESS_INPUT   EQU    22H

INP0                      EQU    10H
EMERGENCY_IP              EQU    10H

INP1                      EQU    11H
HOPPER_PHOTO_SENSOR_IP    EQU    11H

INP2                      EQU    12H
PREFORM_PHOTO_SENSOR_IP   EQU    12H

INP3                      EQU    13H
MOULDOPEN_IP              EQU    13H

INP4                      EQU    14H
MOULDCLOSE_IP             EQU    14H

INP5                           EQU    15H
PREFORM_TRANFER_IN_HOME_IP     EQU    15H

INP6                          EQU    16H
PREFORM_TRANFER_OUT_FWD_IP    EQU    16H

INP7                      EQU    17H
PREFORM_LIFT_UP_IP        EQU    17H
;------------------------------------------------
DC_INPUT1                 EQU    23H

INP8                      EQU    18H
PREFORM_LIFT_DWN_IP       EQU    18H

INP9                      EQU    19H
BOTTLE_DROPPER_IN_IP      EQU    19H

INP10                     EQU    1AH
BOTTLE_DROPPER_OUT_IP     EQU    1AH

INP11                     EQU    1BH
HOPPER_ROLLER_JAM_IP      EQU    1BH

INP12                     EQU    1CH
BOTTLE_TRANSFER_IN_IP     EQU    1CH

INP13                     EQU    1DH
BOTTLE_TRANSFER_OUT_IP    EQU    1DH

INP14                     EQU    1EH
BOTTOM_MOULD_IN_IP09      EQU    1EH

INP15                     EQU    1FH

;------------------------------------------------
DC_INPUT2                 EQU    24H

INP16                     EQU    20H
INP17                     EQU    21H
INP18                     EQU    22H
INP19                     EQU    23H
INP20                     EQU    24H
INP21                     EQU    25H
INP22                     EQU    26H
INP23                     EQU    27H

;---------------------------------------------
OUT0_7                    EQU    25H

OUT0                       EQU    28H  ;1
AIR_RECOVERY_OP            EQU    28H
OP00                       EQU    28H

OUT1                      EQU    29H
PREFORM_GRIPPER_OP        EQU    29H
OP01                      EQU    29H

OUT2                      EQU    2AH
PREFORM_TRANSFER_OP       EQU    2AH
OP02                      EQU    2AH

OUT3                      EQU    2BH
PREFORM_LIFTER_OP         EQU    2BH
OP03                      EQU    2BH

OUT4                      EQU    2CH
MOULDCLOSE_OP             EQU    2CH
OP04                      EQU    2CH

OUT5                      EQU    2DH
BOTTLE_GRIPPER_OP         EQU    2DH
OP05                      EQU    2DH

OUT6                      EQU    2EH
PINDN_OP                  EQU    2EH
OP06                      EQU    2EH


OUT7                      EQU    2FH  ;8
STRETCHIN_OP              EQU    2FH
OP07                      EQU    2FH
;----------------------------------------------
OUT8_15                   EQU    26H

OUT8                      EQU    30H    ;9
LOWBLOW_OP                EQU    30H
OP08                      EQU    30H

OUT9                      EQU    31H
HIGHBLOW_OP               EQU    31H
OP09                      EQU    31H

OUT10                     EQU    32H
EXHAUST_OP                EQU    32H
OP10                      EQU    32H

OUT11                     EQU    33H
PREFORM_FEEDER_LOADER_OP00 EQU    33H
OP11                      EQU    33H

OUT12                     EQU    34H
BOTTLE_DROPPER_OP         EQU    34H
OP12                      EQU    34H

OUT13                     EQU    35H
BOTTLE_TRANSFER_OP        EQU    35H
;HEATER_CONTROL_OP         EQU    35H
OP13                      EQU    35H

OUT14                     EQU    36H
HOPPER_IN_MOTOR_OP        EQU    36H
OP14                      EQU    36H

OUT15                     EQU    37H  ;16
MOULDLOCK_OP              EQU    37H
OP15                      EQU    37H
;-----------------------------------------------
OUT16_23                  EQU    27H

OUT16                     EQU    38H  ;17 
BUZZER_OP                 EQU    38H
OP16                      EQU    38H

BOTTOM_MOULD_OP           EQU    39H 
OUT17                     EQU    39H
OP17                      EQU    39H


OUT18                      EQU    3AH
;          EQU    3AH
OP18                       EQU    3AH


OUT19                     EQU    3BH
MOULDOPEN_OP              EQU    3BH
OP19                      EQU    3BH

OUT20                     EQU    3CH
OP20                      EQU    3CH

OUT21                     EQU    3DH
OP21                      EQU    3DH
ALARM_OP                  EQU    3DH  

HOPPER_OFF_BIT            EQU    3EH
OP22                      EQU    3EH

ALARM_OP_BIT              EQU    3FH  ;24  THISE COND HMI 
OP23                      EQU    3FH

;--------------------------------------------
RLY0_7                    EQU    28H

HEATER_ON_OFF             EQU    40H  ;25
AUTO_MAN_SEL_BIT          EQU    41H  ;26
MAN_SEL_LED               EQU    42H  ;27
TWO_PC_MLD_SEL            EQU    43H  ;28
EJECTOR_SEL_BIT           EQU    44H  ;29
PREFORM_SENS_BYPASS_SEL   EQU    45H  ;30
HOPPER_OUT_SEL            EQU    46H  ;31
DIAPHRAM_VAVLE_SEL        EQU    47H  ;32
;-----------------------------------------------------
RLY8_15                   EQU    29H    ;25 TO 32 ARE DISPLAY ADDRESS

MOULDCLOSE_PB_33          EQU    48H  ;33
MOULDOPEN_PB_34           EQU    49H
PINDN_PB_35               EQU    4AH
STRETCHIN_PB_36           EQU    4BH
LOWBLOW_PB_37             EQU    4CH
HIGHBLOW_PB_38            EQU    4DH
EXHAUST_PB_39             EQU    4EH
AIR_RECOVERY_PB_40        EQU    4FH  ;40
;-----------------------------------------------------
RLY16_23                  EQU    2AH

MOULDLOCK_PB_41           EQU    50H  ;41
MOULD_BOTTOM_PB_42        EQU    51H
PRM_GRIPP_PB_43           EQU    52H
AIR_THROW_PB_44           EQU    53H
PRM_SHIFTER_PB_45         EQU    54H
PRM_LOCK_PB_46            EQU    55H
ALARM_RESET_PB_47         EQU    56H
HOPPER_IN_SEL_48          EQU    57H
;OPEN_MOULD_ERROR_COND     EQU    55H
;TM16E                     EQU    56H  
;TM16D                     EQU    57H  ;48
;---------------------------------------------------6/4/22
RLY49_56                  EQU    2BH

BOTTLE_GRIP_PB_49         EQU    58H
BOTTLE_DROP_PB_50         EQU    59H
OUTPUT_TEST_51            EQU    5AH
BOTTOM_MOULD_IN_IP        EQU    5BH
BOTTLE_TRANSFER_SEL_53    EQU    5CH
BOTTLE_TRANSFER_PB_54     EQU    5DH

;------------------------------------------------
RLY57_64                  EQU    2CH
DC_INPUT3                 EQU    2CH


;---------------------------------------------------
RLY65_72                         EQU    2DH

LEFT_PREFORM_STATUS_SHIFT_DONE   EQU   68H
L_PREFORM_SENSOR_STATUS_LOADED   EQU   69H
RIGHT_PREFORM_STATUS_SHIFT_DONE  EQU   6AH
R_PREFORM_SENSOR_STATUS_LOADED   EQU   6BH
L_TEMP_BIT                       EQU   6CH
L_TEMP_BIT2                      EQU   6DH
R_TEMP_BIT                       EQU   6EH
R_TEMP_BIT2                      EQU   6FH
;---------------------------------------------------
POW_CHG_1                 EQU    2EH

ZONE1_POW_CHG             EQU    70H   ;73
ZONE2_POW_CHG             EQU    71H
ZONE3_POW_CHG             EQU    72H
ZONE4_POW_CHG             EQU    73H
ZONE5_POW_CHG             EQU    74H
ZONE6_POW_CHG             EQU    75H
ZONE7_POW_CHG             EQU    76H
ZONE8_POW_CHG             EQU    77H   ;80
;---------------------------------------------------
RLY33_40                  EQU    2FH

RLY33                     EQU    78H  ;USED IN COMPARE ROUTINE  ;81
RLY34                     EQU    79H  ;USED IN COMPARE ROUTINE  ; 
RLY35                     EQU    7AH  ;USED IN COMPARE ROUTINE  ; 
;RLY38                     EQU    7DH
RLY39                     EQU    7EH
RLY40                     EQU    7FH  ;88
;--------------------------------------------------
ALARM_BITS_1                EQU    30H

MOULD_CLOSE_IP_ERR_89       EQU    0E0H  ;89
PREFORM_LIFT_UP_ERR_90      EQU    0E1H
MOULD_OPEN_IP_ERR_91        EQU    0E2H
PREFORMSHIFT_FWD_IP_ERR_92  EQU    0E3H
PREFORMSHIFT_BACK_IP_ERR_93 EQU    0E4H
PREFORM_LIFT_DWN_IP_ERR_94  EQU    0E5H
BOTTOM_MOULD_IN_IP_ERR_95   EQU    0E6H  ;95
BOTTLE_DROP_OUT_IP_ERR_96   EQU    0E7H  ;96

;--------------------------------------------------
ALARM_BITS_2                EQU    31H   ; 97  TO 104

HOPPER_ROLLER_JAM_ERR_97    EQU    0E0H
HOPPER_PRM_EMPTY_ERR_98     EQU    0E1H

;--------------------------------------------------
ALARM_BITS_3                EQU    32H   ; 105  TO 112

BOTTLE_TRANSFER_IN_IP_ERR_105 EQU    0E0H
BOTTLE_TRANSFER_OUT_IP_ERR_106 EQU    0E1H

;---------------------------------------------------
CTR_CLK                   EQU    33H  ; 105 TO 112

CT00C                     EQU    0E0H  ;EJECTOR STOKE COUNTER
CT01C                     EQU    0E1H  ;MOULD SAFETY ERROR COUNTER
CT02C                     EQU    0E2H  ;HORLY COUNTER
CT03C                     EQU    0E3H  ;TOTAL 1 COUNTER
CT04C                     EQU    0E4H  ;TOTAL 0 COUNTER
CT05C                     EQU    0E5H  ;LUBRICATION COUNTER
CT06C                     EQU    0E6H
CT07C                     EQU    0E7H

CTR_RESET                 EQU    34H   

CT00R                     EQU    0E0H
CT01R                     EQU    0E1H
CT02R                     EQU    0E2H
CT03R                     EQU    0E3H
CT04R                     EQU    0E4H
CT05R                     EQU    0E5H
CT06R                     EQU    0E6H
CT07R                     EQU    0E7H

CTR_DONE                  EQU    35H 

CT00D                     EQU    0E0H
CT01D                     EQU    0E1H
CT02D                     EQU    0E2H
CT03D                     EQU    0E3H
CT04D                     EQU    0E4H
CT05D                     EQU    0E5H
CT06D                     EQU    0E6H
CT07D                     EQU    0E7H
;---------------------------------------------------
AUTO_CYCLE_BITS           EQU    36H     

START_PREFORMSHIFT_FWD    EQU    0E0H
PREFORMSHIFT_FWD_OVER     EQU    0E1H
PREFORM_GRIPPER_START     EQU    0E2H
MOULD_CLOSE_START         EQU    0E3H
MOULDOPEN_OVER            EQU    0E4H
PRM_LOAD_ON_CYCLE_BIT     EQU    0E5H



;---------------------------------------------------
GENERAL_BITS              EQU    37H

CYCLE_TIME_LOADED         EQU    0E0H

;-----------------------------------------------------
OUT24_31                  EQU    38H



;-------------------------------------------------------
;DC_INPUT0                 EQU    6BH
;DC_INPUT1                 EQU    6CH
NO_OF_CAVITY              EQU    6DH
CTR_PREV_CLK              EQU    6EH
TC_DEBOUNCE_TIME          EQU    6FH            ;,#05
CH_TIMECT                 EQU    70H
TC_TIMECT                 EQU    71H

DATA_OP_1                 EQU    72H
DATA_OP_2                 EQU    73H
DATA_OP_3                 EQU    74H

BIT_COUNTER               EQU    75H

PREV_DCINP0               EQU    79H
PREV_DCINP1               EQU    7AH
PREV_DCINP2               EQU    7BH
PREV_DCINP3               EQU    7CH
CUR_DC_INPUT              EQU    7DH
DC_INPUT_TEMP             EQU    7EH
REMAINDER                 EQU    7FH
;--------------------------------------------------------
RX_BUF                      EQU   080H
TX_BUF                      EQU   0B0H



;-------------------------------------------------------
START_ADDRESS_DATA_REG      EQU   0000H

ZONE1_SET_H                 EQU   0000H  ;1
ZONE1_SET_L                 EQU   0001H

ZONE2_SET_H                 EQU   0002H  ;2
ZONE2_SET_L                 EQU   0003H

ZONE3_SET_H                 EQU   0004H  ;3
ZONE3_SET_L                 EQU   0005H

ZONE4_SET_H                 EQU   0006H
ZONE4_SET_L                 EQU   0007H

ZONE5_SET_H                 EQU   0008H
ZONE5_SET_L                 EQU   0009H

ZONE6_SET_H                 EQU   000AH
ZONE6_SET_L                 EQU   000BH

ZONE7_SET_H                 EQU   000CH
ZONE7_SET_L                 EQU   000DH

ZONE8_SET_H                 EQU   000EH  ;8
ZONE8_SET_L                 EQU   000FH
;--------------------------------------------------------
TMS00H                      EQU   0010H  ;9  
TMS00L                      EQU   0011H

TMS01H                      EQU   0012H  ;10
TMS01L                      EQU   0013H

TMS02H                      EQU   0014H   ;11
TMS02L                      EQU   0015H

TMS03H                      EQU   0016H   ;12
TMS03L                      EQU   0017H

TMS04H                      EQU   0018H   ;13
TMS04L                      EQU   0019H

TMS05H                      EQU   001AH   ;14
TMS05L                      EQU   001BH

TMS06H                      EQU   001CH   ;15
TMS06L                      EQU   001DH

TMS07H                      EQU   001EH   ;16
TMS07L                      EQU   001FH
;------------------------------------------------------------------
TMS08H                      EQU   0020H   ;17
TMS08L                      EQU   0021H

;TMS09H                      EQU   0022H   ;18
;TMS09L                      EQU   0023H

TMS10H                      EQU   0024H   ;19
TMS10L                      EQU   0025H

TMS11H                      EQU   0026H   ;20
TMS11L                      EQU   0027H

TMS12H                      EQU   0028H   ;21
TMS12L                      EQU   0029H

TMS13H                      EQU   002AH   ;22
TMS13L                      EQU   002BH

TMS14H                      EQU   002CH   ;23
TMS14L                      EQU   002DH

TMS15H                      EQU   002EH   ;24
TMS15L                      EQU   002FH
;-------------------------------------------------------------
TMS16H                      EQU   0030H   ;25
TMS16L                      EQU   0031H

TMS17H                      EQU   0032H   ;26
TMS17L                      EQU   0033H

TMS18H                      EQU   0034H   ;27
TMS18L                      EQU   0035H

TMS19H                      EQU   0036H   ;28
TMS19L                      EQU   0037H

TMS20H                      EQU   0038H   ;29
TMS20L                      EQU   0039H

TMS21H                      EQU   003AH   ;30
TMS21L                      EQU   003BH

TMS22H                      EQU   003CH   ;31
TMS22L                      EQU   003DH

TMS23H                      EQU   003EH   ;32
TMS23L                      EQU   003FH
;------------------------------------------------------
TMS24H                      EQU   0040H   ;33
TMS24L                      EQU   0041H

TMS25H                      EQU   0042H   ;34
TMS25L                      EQU   0043H

TMS26H                      EQU   0044H   ;35
TMS26L                      EQU   0045H

TMS27H                      EQU   0046H   ;36
TMS27L                      EQU   0047H

TMS28H                      EQU   0048H   ;37
TMS28L                      EQU   0049H

TMS29H                      EQU   004AH   ;38
TMS29L                      EQU   004BH

TMS30H                      EQU   004CH   ;39
TMS30L                      EQU   004DH

TMS31H                      EQU   004EH   ;40
TMS31L                      EQU   004FH
;------------------------------------------------------
TMS32H                      EQU   0050H   ;41
TMS32L                      EQU   0051H

TMS33H                      EQU   0052H   ;42
TMS33L                      EQU   0053H

TMS34H                      EQU   0054H   ;43
TMS34L                      EQU   0055H

TMS35H                      EQU   0056H   ;44
TMS35L                      EQU   0057H

TMS36H                      EQU   0058H   ;45
TMS36L                      EQU   0059H

TMS37H                      EQU   005AH   ;46
TMS37L                      EQU   005BH

TMS38H                      EQU   005CH   ;47
TMS38L                      EQU   005DH

TMS39H                      EQU   005EH   ;48
TMS39L                      EQU   005FH
;-------------------------------------------------------
TMS40H                      EQU   0060H   ;49
TMS40L                      EQU   0061H

TMS41H                      EQU   0062H   ;50
TMS41L                      EQU   0063H

TMS42H                      EQU   0064H   ;51
TMS42L                      EQU   0065H

TMS43H                      EQU   0066H   ;52
TMS43L                      EQU   0067H

TMS44H                      EQU   0068H   ;53
TMS44L                      EQU   0069H

TMS45H                      EQU   006AH   ;54
TMS45L                      EQU   006BH

TMS46H                      EQU   006CH   ;55
TMS46L                      EQU   006DH

TMS47H                      EQU   006EH   ;56
TMS47L                      EQU   006FH
;------------------------------------------------------
TMS48H                      EQU   0070H   ;57
TMS48L                      EQU   0071H

TMS49H                      EQU   0072H   ;58
TMS49L                      EQU   0073H

TMS50H                      EQU   0074H   ;59
TMS50L                      EQU   0075H

TMS51H                      EQU   0076H   ;60
TMS51L                      EQU   0077H

TMS52H                      EQU   0078H   ;61
TMS52L                      EQU   0079H

TMS53H                      EQU   007AH   ;62
TMS53L                      EQU   007BH

TMS54H                      EQU   007CH   ;63
TMS54L                      EQU   007DH

TMS55H                      EQU   007EH   ;64
TMS55L                      EQU   007FH
;----------------------------------------
TMS56H                      EQU   0080H   ;65
TMS56L                      EQU   0081H

TMS57H                      EQU   0082H   ;66
TMS57L                      EQU   0083H

TMS58H                      EQU   0084H   ;67
TMS58L                      EQU   0085H

TMS59H                      EQU   0086H   ;68
TMS59L                      EQU   0087H

TMS60H                      EQU   0088H   ;69
TMS60L                      EQU   0089H

TMS61H                      EQU   008AH   ;70
TMS61L                      EQU   008BH

TMS62H                      EQU   008CH   ;71
TMS62L                      EQU   008DH

TMS63H                      EQU   008EH   ;72
TMS63L                      EQU   008FH
;-----------------------------------------
TMS64H                      EQU   0090H   ;73
TMS64L                      EQU   0091H

TMS65H                      EQU   0092H   ;74
TMS65L                      EQU   0093H

TMS66H                      EQU   0094H   ;75
TMS66L                      EQU   0095H

TMS67H                      EQU   0096H   ;76
TMS67L                      EQU   0097H

TMS68H                      EQU   0098H   ;77
TMS68L                      EQU   0099H

TMS69H                      EQU   009AH   ;78
TMS69L                      EQU   009BH

TMS70H                      EQU   009CH   ;79
TMS70L                      EQU   009DH

TMS71H                      EQU   009EH   ;80
TMS71L                      EQU   009FH
;---------------------------------------------------
TMS72H                      EQU   00A0H   ;81
TMS72L                      EQU   00A1H

TMS73H                      EQU   00A2H   ;82
TMS73L                      EQU   00A3H

TMS74H                      EQU   00A4H   ;83
TMS74L                      EQU   00A5H

TMS75H                      EQU   00A6H   ;84
TMS75L                      EQU   00A7H

TMS76H                      EQU   00A8H   ;85
TMS76L                      EQU   00A9H

TMS77H                      EQU   00AAH   ;86
TMS77L                      EQU   00ABH

TMS78H                      EQU   00ACH   ;87
TMS78L                      EQU   00ADH

TMS79H                      EQU   00AEH   ;88
TMS79L                      EQU   00AFH
;-------------------------------------------------------
CTS00H                      EQU   00B0H  ;89
CTS00L                      EQU   00B1H

CTS01H                      EQU   00B2H  ;90
CTS01L                      EQU   00B3H

CTS02H                      EQU   00B4H  ;91
CTS02L                      EQU   00B5H

CTS03H                      EQU   00B6H  ;92
CTS03L                      EQU   00B7H

CTS04H                      EQU   00B8H  ;93
CTS04L                      EQU   00B9H

CTS05H                      EQU   00BAH  ;94
CTS05L                      EQU   00BBH

CTS06H                      EQU   00BCH  ;95
CTS06L                      EQU   00BDH

CTS07H                      EQU   00BEH  ;96
CTS07L                      EQU   00BFH

NO_OF_CAVITY_H              EQU   00C0H  ;97
NO_OF_CAVITY_L              EQU   00C1H

PREFORM_COUNTER_H           EQU   00C2H  ;98
PREFORM_COUNTER_L           EQU   00C3H

TMS09H                      EQU   00C4H  ;99
TMS09L                      EQU   00C5H
;-------------------------------------------------------
ZONE1_ACT_H                  EQU   0200H  ;257 
ZONE1_ACT_L                  EQU   0201H

ZONE2_ACT_H                  EQU   0202H  ;258
ZONE2_ACT_L                  EQU   0203H

ZONE3_ACT_H                  EQU   0204H  ;259
ZONE3_ACT_L                  EQU   0205H

ZONE4_ACT_H                  EQU   0206H  ;260
ZONE4_ACT_L                  EQU   0207H

ZONE5_ACT_H                  EQU   0208H  ;261
ZONE5_ACT_L                  EQU   0209H

ZONE6_ACT_H                  EQU   020AH  ;262
ZONE6_ACT_L                  EQU   020BH

ZONE7_ACT_H                  EQU   020CH  ;263
ZONE7_ACT_L                  EQU   020DH

ZONE8_ACT_H                  EQU   020EH  ;264
ZONE8_ACT_L                  EQU   020FH

;---------------------------------------------------
TMC00H                      EQU    0210H    ; 265
TMC00L                      EQU    0211H   

TMC01H                      EQU    0212H    ;266
TMC01L                      EQU    0213H

TMC02H                      EQU    0214H    ;267 
TMC02L                      EQU    0215H

TMC03H                      EQU    0216H    ;268  
TMC03L                      EQU    0217H

TMC04H                      EQU    0218H    ; 269
TMC04L                      EQU    0219H   

TMC05H                      EQU    021AH     ;270
TMC05L                      EQU    021BH

TMC06H                      EQU    021CH     ;271
TMC06L                      EQU    021DH

TMC07H                      EQU    021EH     ;272
TMC07L                      EQU    021FH
;-------------------------------------------------------------
TMC08H                      EQU    0220H     ;273
TMC08L                      EQU    0221H    

TMC09H                      EQU    0222H     ;274
TMC09L                      EQU    0223H

TMC10H                      EQU    0224H     ;275 
TMC10L                      EQU    0225H

TMC11H                      EQU    0226H    ; 276  
TMC11L                      EQU    0227H

TMC12H                      EQU    0228H    ; 277  
TMC12L                      EQU    0229H

TMC13H                      EQU    022AH    ; 278  
TMC13L                      EQU    022BH

TMC14H                      EQU    022CH    ; 279  
TMC14L                      EQU    022DH

TMC15H                      EQU    022EH    ; 280 
TMC15L                      EQU    022FH
;------------------------------------------------------------
TMC16H                      EQU    0230H  ;281  
TMC16L                      EQU    0231H

TMC17H                      EQU    0232H  ;282
TMC17L                      EQU    0233H

TMC18H                      EQU    0234H  ;283
TMC18L                      EQU    0235H

TMC19H                      EQU    0236H  ;284
TMC19L                      EQU    0237H

TMC20H                      EQU    0238H  ;285
TMC20L                      EQU    0239H

TMC21H                      EQU    023AH  ;286
TMC21L                      EQU    023BH

TMC22H                      EQU    023CH  ;287
TMC22L                      EQU    023DH

TMC23H                      EQU    023EH  ;288
TMC23L                      EQU    023FH
;-----------------------------------------------------------
TMC24H                      EQU    0240H  ;289  
TMC24L                      EQU    0241H

TMC25H                      EQU    0242H  ;290
TMC25L                      EQU    0243H

TMC26H                      EQU    0244H  ;291
TMC26L                      EQU    0245H

TMC27H                      EQU    0246H  ;292
TMC27L                      EQU    0247H

TMC28H                      EQU    0248H  ;293
TMC28L                      EQU    0249H

TMC29H                      EQU    024AH  ;294
TMC29L                      EQU    024BH

TMC30H                      EQU    024CH  ;295
TMC30L                      EQU    024DH

TMC31H                      EQU    024EH  ;296
TMC31L                      EQU    024FH
;------------------------------------------------------------
TMC32H                      EQU    0250H  ;297  
TMC32L                      EQU    0251H

TMC33H                      EQU    0252H  ;298
TMC33L                      EQU    0253H

TMC34H                      EQU    0254H  ;299
TMC34L                      EQU    0255H

TMC35H                      EQU    0256H  ;300
TMC35L                      EQU    0257H

TMC36H                      EQU    0258H  ;301
TMC36L                      EQU    0259H

TMC37H                      EQU    025AH  ;302
TMC37L                      EQU    025BH

TMC38H                      EQU    025CH  ;303
TMC38L                      EQU    025DH

TMC39H                      EQU    025EH  ;304
TMC39L                      EQU    025FH
;---------------------------------------------------------
TMC40H                      EQU    0260H  ;305  
TMC40L                      EQU    0261H

TMC41H                      EQU    0262H  ;306
TMC41L                      EQU    0263H

TMC42H                      EQU    0264H  ;307
TMC42L                      EQU    0265H

TMC43H                      EQU    0266H  ;308
TMC43L                      EQU    0267H

TMC44H                      EQU    0268H  ;309
TMC44L                      EQU    0269H

TMC45H                      EQU    026AH  ;310
TMC45L                      EQU    026BH

TMC46H                      EQU    026CH  ;311
TMC46L                      EQU    026DH

TMC47H                      EQU    026EH  ;312
TMC47L                      EQU    026FH
;----------------------------------------------------------
TMC48H                      EQU    0270H  ;313  
TMC48L                      EQU    0271H

TMC49H                      EQU    0272H  ;314
TMC49L                      EQU    0273H

TMC50H                      EQU    0274H  ;315
TMC50L                      EQU    0275H

TMC51H                      EQU    0276H  ;316  
TMC51L                      EQU    0277H

TMC52H                      EQU    0278H  ;317
TMC52L                      EQU    0279H

TMC53H                      EQU    027AH  ;318
TMC53L                      EQU    027BH

TMC54H                      EQU    027CH  ;319
TMC54L                      EQU    027DH

TMC55H                      EQU    027EH  ;320
TMC55L                      EQU    027FH
;---------------------------------------------------
TMC56H                      EQU    0280H  ;321  
TMC56L                      EQU    0281H

TMC57H                      EQU    0282H  ;322
TMC57L                      EQU    0283H

TMC58H                      EQU    0284H  ;323
TMC58L                      EQU    0285H

TMC59H                      EQU    0286H  ;324  
TMC59L                      EQU    0287H

TMC60H                      EQU    0288H  ;325
TMC60L                      EQU    0289H

TMC61H                      EQU    028AH  ;326
TMC61L                      EQU    028BH

TMC62H                      EQU    028CH  ;327
TMC62L                      EQU    028DH

TMC63H                      EQU    028EH  ;328
TMC63L                      EQU    028FH
;---------------------------------------------------
TMC64H                      EQU    0290H  ;329  
TMC64L                      EQU    0291H

TMC65H                      EQU    0292H  ;330
TMC65L                      EQU    0293H

TMC66H                      EQU    0294H  ;331
TMC66L                      EQU    0295H

TMC67H                      EQU    0296H  ;332  
TMC67L                      EQU    0297H

TMC68H                      EQU    0298H  ;333
TMC68L                      EQU    0299H

TMC69H                      EQU    029AH  ;334
TMC69L                      EQU    029BH

TMC70H                      EQU    029CH  ;335
TMC70L                      EQU    029DH

TMC71H                      EQU    029EH  ;336
TMC71L                      EQU    029FH
;---------------------------------------------------
TMC72H                      EQU    02A0H  ;337  
TMC72L                      EQU    02A1H

TMC73H                      EQU    02A2H  ;338
TMC73L                      EQU    02A3H

TMC74H                      EQU    02A4H  ;339
TMC74L                      EQU    02A5H

TMC75H                      EQU    02A6H  ;340  
TMC75L                      EQU    02A7H

TMC76H                      EQU    02A8H  ;341
TMC76L                      EQU    02A9H

TMC77H                      EQU    02AAH  ;342
TMC77L                      EQU    02ABH

TMC78H                      EQU    02ACH  ;343
TMC78L                      EQU    02ADH

TMC79H                      EQU    02AEH  ;344
TMC79L                      EQU    02AFH
;---------------------------------------------------
CTC00H                      EQU    02B0H  ;345
CTC00L                      EQU    02B1H

CTC01H                      EQU    02B2H  ;346
CTC01L                      EQU    02B3H

CTC02H                      EQU    02B4H  ;347
CTC02L                      EQU    02B5H

CTC03H                      EQU    02B6H  ;348
CTC03L                      EQU    02B7H

CTC04H                      EQU    02B8H  ;349
CTC04L                      EQU    02B9H

CTC05H                      EQU    02BAH   ;350
CTC05L                      EQU    02BBH

CTC06H                      EQU    02BCH  ;351
CTC06L                      EQU    02BDH

CTC07H                      EQU    02BEH  ; 352
CTC07L                      EQU    02BFH
;-----------------------------------------------------
CYCLE_TIME_H                EQU    02C0H  ;353
CYCLE_TIME_L                EQU    02C1H
;---------------------------------------------------


;--------------------USELESS TIMER---------------------------
TMC100H                     EQU    02CEH   ;360
TMC100L                     EQU    02CFH

TMC101H                     EQU    02D0H  ;361
TMC101L                     EQU    02D1H

TMC102H                     EQU    02D2H  ;362
TMC102L                     EQU    02D3H

TMS100H                     EQU    02D4H  ;363
TMS100L                     EQU    02D5H

TMS101H                     EQU    02D6H  ;364
TMS101L                     EQU    02D7H

TMS102H                     EQU    02D8H  ;365
TMS102L                     EQU    02D9H

TMS104H                     EQU    02DAH   ;366
TMS104L                     EQU    02DBH

TMS105H                     EQU    02DCH   ;367
TMS105L                     EQU    02DDH

TMS106H                     EQU    02DEH   ;368
TMS106L                     EQU    02DFH
;----------------------------------------------------------
TMS107H                     EQU    02E0H   ;369
TMS107L                     EQU    02E1H

TMS108H                     EQU    02E2H   ;370
TMS108L                     EQU    02E3H

TMC104H                     EQU    02E4H   ;371
TMC104L                     EQU    02E5H

TMC105H                     EQU    02E6H   ;372
TMC105L                     EQU    02E7H

TMC106H                     EQU    02E8H   ;373
TMC106L                     EQU    02E9H

TMC107H                     EQU    02EAH   ;374
TMC107L                     EQU    02EBH

TMC108H                     EQU    02ECH   ;375
TMC108L                     EQU    02EDH

TMC109H                     EQU    02EEH   ;376
TMC109L                     EQU    02EFH
;------------------------------------------------------------
TMC110H                     EQU    02F0H  ;377
TMC110L                     EQU    02F1H

TMC111H                     EQU    02F2H  ;378
TMC111L                     EQU    02F3H

TMC103H                     EQU    02F4H  ;379
TMC103L                     EQU    02F5H

TMS109H                     EQU    02F6H   ;380
TMS109L                     EQU    02F7H

TMS110H                     EQU    02F8H   ;381
TMS110L                     EQU    02F9H

TMS111H                     EQU    02FAH   ;382
TMS111L                     EQU    02FBH

TMS103H                     EQU    02FCH   ;383
TMS103L                     EQU    02FDH

TMS112H                     EQU    02FEH   ;384
TMS112L                     EQU    02FFH

TMC112H                     EQU    0300H   ;385
TMC112L                     EQU    0301H
;--------------------------------------------------
IO_LOCN                     EQU   0340H   ;417
;--------------------------------------------------------
IP_LOCN                     EQU   0360H  ;433    360H TO 370H LOCN RESERVED FOR IP NOS.
;------------------------------------------------------------------------------------------

;--------------------------------------------------
LEFT_PREFORM_STATUS_BIT_REG_1H  EQU   03DEH  ;496
LEFT_PREFORM_STATUS_BIT_REG_1L  EQU   03DFH

LEFT_PREFORM_STATUS_BIT_REG_2H  EQU   03E0H  ;497
LEFT_PREFORM_STATUS_BIT_REG_2L  EQU   03E1H

RIGHT_PREFORM_STATUS_BIT_REG_1H EQU   03E2H  ;498
RIGHT_PREFORM_STATUS_BIT_REG_1L EQU   03E3H

RIGHT_PREFORM_STATUS_BIT_REG_2H EQU   03E4H  ;499
RIGHT_PREFORM_STATUS_BIT_REG_2L EQU   03E5H
;--------------------------------------------------------
TM00_ENABLE                   EQU   03E6H
TM01_ENABLE                   EQU   03E6H
TM02_ENABLE                   EQU   03E6H
TM03_ENABLE                   EQU   03E6H

TM00E                         EQU   0E0H
MOULD_LOCK_DLY_TM00E          EQU   0E0H

TM00D                         EQU   0E1H
MOULD_LOCK_DLY_TM00D          EQU   0E1H

TM01E                         EQU   0E2H
LOW_BLOW_DLY_TM01E            EQU   0E2H

TM01D                         EQU   0E3H
LOW_BLOW_DLY_TM01D            EQU   0E3H

TM02E                         EQU   0E4H
HIGH_BLOW_DLY_TM02E           EQU   0E4H

TM02D                         EQU   0E5H
HIGH_BLOW_DLY_TM02D           EQU   0E5H

TM03E                         EQU   0E6H
BLOWING_TIME_TM03E            EQU   0E6H

TM03D                         EQU   0E7H
BLOWING_TIME_TM03D            EQU   0E7H
;--------------------------------------------------------
TM04_ENABLE                   EQU   03E7H
TM05_ENABLE                   EQU   03E7H
TM06_ENABLE                   EQU   03E7H
TM07_ENABLE                   EQU   03E7H

TM04E                         EQU   0E0H
EXHAUST_TIME_TM04E            EQU   0E0H

TM04D                         EQU   0E1H
EXHAUST_TIME_TM04D            EQU   0E1H

TM05E                         EQU   0E2H
BLOWPIN_DLY_TM05E             EQU   0E2H

TM05D                         EQU   0E3H
BLOWPIN_DLY_TM05D             EQU   0E3H

TM06E                         EQU   0E4H
STRETCH_IN_DLY_TM06E          EQU   0E4H

TM06D                         EQU   0E5H
STRETCH_IN_DLY_TM06D          EQU   0E5H

TM07E                         EQU   0E6H
PRM_GRIPP_ON_TM07E            EQU   0E6H

TM07D                         EQU   0E7H
PRM_GRIPP_ON_TM07D            EQU   0E7H
;-----------------------------------------------------
TM08_ENABLE                   EQU   03E8H
TM09_ENABLE                   EQU   03E8H
TM10_ENABLE                   EQU   03E8H
TM11_ENABLE                   EQU   03E8H

TM08E                         EQU   0E0H
AIR_RECOVERY_TM08E            EQU   0E0H

TM08D                         EQU   0E1H
AIR_RECOVERY_TM08D            EQU   0E1H

TM09E                         EQU   0E2H
BLOWPIN_OUT_DLY_TM09E         EQU   0E2H

TM09D                         EQU   0E3H
BLOWPIN_OUT_DLY_TM09D         EQU   0E3H

TM10E                         EQU   0E4H
;PREFORM_SHIFT_BACK_DLY_TM10E  EQU   0E4H
;
TM10D                         EQU   0E5H
;PREFORM_SHIFT_BACK_DLY_TM10D  EQU   0E5H

TM11E                         EQU   0E6H
BOT_DROP_TM11E                EQU   0E6H
;BOT_LIFT_UP_DLY_TM11E         EQU   0E6H

TM11D                         EQU   0E7H
BOT_DROP_TM11D                EQU   0E7H
;BOT_LIFT_UP_DLY_TM11D         EQU   0E7H


;--------------------------------------------------
TM12_ENABLE                   EQU   03E9H
TM13_ENABLE                   EQU   03E9H
TM14_ENABLE                   EQU   03E9H
TM15_ENABLE                   EQU   03E9H

TM12E                         EQU   0E0H
MOULD_OPEN_DLY_TM12E          EQU   0E0H
;BOT_AIR_THROW_DLY_TM12E       EQU   0E0H

TM12D                         EQU   0E1H
MOULD_OPEN_DLY_TM12D          EQU   0E1H
;BOT_AIR_THROW_DLY_TM12D       EQU   0E1H

TM13E                         EQU   0E2H
BOTTOM_MOULD_OFF_TM13E        EQU   0E2H
;BOT_AIR_THROW_TM13E           EQU   0E2H

TM13D                         EQU   0E3H
BOTTOM_MOULD_OFF_TM13D        EQU   0E3H
;BOT_AIR_THROW_TM13D           EQU   0E3H

TM14E                         EQU   0E4H
PREFORM_GRIP_OFF_DLY_TM14E    EQU   0E4H

TM14D                         EQU   0E5H
PREFORM_GRIP_OFF_DLY_TM14D    EQU   0E5H

TM15E                         EQU   0E6H
MOULD_CLOSE_DLY_TM15E         EQU   0E6H

TM15D                         EQU   0E7H
MOULD_CLOSE_DLY_TM15D         EQU   0E7H

;---------------------------------------------------
TM16_ENABLE                   EQU   03EAH
TM17_ENABLE                   EQU   03EAH
TM18_ENABLE                   EQU   03EAH
TM19_ENABLE                   EQU   03EAH

TM16E                         EQU   0E0H
TM16D                         EQU   0E1H

TM17E                         EQU   0E2H
PREFORM_SHIFT_BACK_DLY_TM17E  EQU   0E2H

TM17D                         EQU   0E3H
PREFORM_SHIFT_BACK_DLY_TM17D  EQU   0E3H

TM18E                         EQU   0E4H
TM18D                         EQU   0E5H

TM19E                         EQU   0E6H
TM19D                         EQU   0E7H
;-------------------------------------------------------
TM20_ENABLE                   EQU   03EBH
TM21_ENABLE                   EQU   03EBH
TM22_ENABLE                   EQU   03EBH
TM23_ENABLE                   EQU   03EBH

TM20E                         EQU   0E0H
TM20D                         EQU   0E1H

TM21E                         EQU   0E2H
TM21D                         EQU   0E3H

TM22E                         EQU   0E4H
TM22D                         EQU   0E5H

TM23E                         EQU   0E6H
TM23D                         EQU   0E7H
;-------------------------------------------------
TM24_ENABLE                   EQU   03ECH
TM25_ENABLE                   EQU   03ECH
TM26_ENABLE                   EQU   03ECH
TM27_ENABLE                   EQU   03ECH

TM24E                         EQU   0E0H
TM24D                         EQU   0E1H

TM25E                         EQU   0E2H
TM25D                         EQU   0E3H

TM26E                         EQU   0E4H
TM26D                         EQU   0E5H

TM27E                         EQU   0E6H
TM27D                         EQU   0E7H
;--------------------------------------------------
TM28_ENABLE                   EQU   03EDH
TM29_ENABLE                   EQU   03EDH
TM30_ENABLE                   EQU   03EDH
TM31_ENABLE                   EQU   03EDH

TM28E                         EQU   0E0H
TM28D                         EQU   0E1H

TM29E                         EQU   0E2H
TM29D                         EQU   0E3H

TM30E                         EQU   0E4H
TM30D                         EQU   0E5H

TM31E                         EQU   0E6H
TM31D                         EQU   0E7H
;---------------------------------------------------
TM32_ENABLE                   EQU   03EEH
TM33_ENABLE                   EQU   03EEH
TM34_ENABLE                   EQU   03EEH
TM35_ENABLE                   EQU   03EEH

TM32E                         EQU   0E0H
TM32D                         EQU   0E1H

TM33E                         EQU   0E2H
TM33D                         EQU   0E3H

TM34E                         EQU   0E4H
TM34D                         EQU   0E5H

TM35E                         EQU   0E6H
TM35D                         EQU   0E7H
;----------------------------------------------------
TM36_ENABLE                   EQU   03EFH
TM37_ENABLE                   EQU   03EFH
TM38_ENABLE                   EQU   03EFH
TM39_ENABLE                   EQU   03EFH

TM36E                         EQU   0E0H
TM36D                         EQU   0E1H

TM37E                         EQU   0E2H
TM37D                         EQU   0E3H

TM38E                         EQU   0E4H
TM38D                         EQU   0E5H

TM39E                         EQU   0E6H
TM39D                         EQU   0E7H
;---------------------------------------------------
TM40_ENABLE                   EQU   03F0H
TM41_ENABLE                   EQU   03F0H
TM42_ENABLE                   EQU   03F0H
TM43_ENABLE                   EQU   03F0H

TM40E                         EQU   0E0H
TM40D                         EQU   0E1H

TM41E                         EQU   0E2H
TM41D                         EQU   0E3H

TM42E                         EQU   0E4H
TM42D                         EQU   0E5H

TM43E                         EQU   0E6H
TM43D                         EQU   0E7H
;---------------------------------------------------
TM44_ENABLE                   EQU   03F1H
TM45_ENABLE                   EQU   03F1H
TM46_ENABLE                   EQU   03F1H
TM47_ENABLE                   EQU   03F1H

TM44E                         EQU   0E0H
TM44D                         EQU   0E1H

TM45E                         EQU   0E2H
TM45D                         EQU   0E3H

TM46E                         EQU   0E4H
TM46D                         EQU   0E5H

TM47E                         EQU   0E6H
TM47D                         EQU   0E7H
;---------------------------------------------------
TM48_ENABLE                   EQU   03F2H
TM49_ENABLE                   EQU   03F2H
TM50_ENABLE                   EQU   03F2H
TM51_ENABLE                   EQU   03F2H

TM48E                         EQU   0E0H
TM48D                         EQU   0E1H

TM49E                         EQU   0E2H
TM49D                         EQU   0E3H

TM50E                         EQU   0E4H
TM50D                         EQU   0E5H

TM51E                         EQU   0E6H
TM51D                         EQU   0E7H
;-----------------------------------------------------
TM52_ENABLE                   EQU   03F3H
TM53_ENABLE                   EQU   03F3H
TM54_ENABLE                   EQU   03F3H
TM55_ENABLE                   EQU   03F3H

TM52E                         EQU   0E0H
TM52D                         EQU   0E1H

TM53E                         EQU   0E2H
TM53D                         EQU   0E3H

TM54E                         EQU   0E4H
TM54D                         EQU   0E5H

TM55E                         EQU   0E6H
TM55D                         EQU   0E7H
;-------------------------------------------------------
TM56_ENABLE                   EQU   03F4H
TM57_ENABLE                   EQU   03F4H
TM58_ENABLE                   EQU   03F4H
TM59_ENABLE                   EQU   03F4H

TM56E                         EQU   0E0H
TM56D                         EQU   0E1H

TM57E                         EQU   0E2H
TM57D                         EQU   0E3H

TM58E                         EQU   0E4H
TM58D                         EQU   0E5H

TM59E                         EQU   0E6H
TM59D                         EQU   0E7H
;--------------------------------------------------------
TM60_ENABLE                   EQU   03F5H
TM61_ENABLE                   EQU   03F5H
TM62_ENABLE                   EQU   03F5H
TM63_ENABLE                   EQU   03F5H

TM60E                         EQU   0E0H
TM60D                         EQU   0E1H

TM61E                         EQU   0E2H
TM61D                         EQU   0E3H

TM62E                         EQU   0E4H
TM62D                         EQU   0E5H

TM63E                         EQU   0E6H
TM63D                         EQU   0E7H
;-----------------------------------------------------
TM64_ENABLE                   EQU   03F6H
TM65_ENABLE                   EQU   03F6H
TM66_ENABLE                   EQU   03F6H
TM67_ENABLE                   EQU   03F6H

TM64E                         EQU   0E0H
TM64D                         EQU   0E1H

TM65E                         EQU   0E2H
TM65D                         EQU   0E3H

TM66E                         EQU   0E4H
TM66D                         EQU   0E5H

TM67E                         EQU   0E6H
TM67D                         EQU   0E7H
;-----------------------------------------------------
TM68_ENABLE                   EQU   03F7H
TM69_ENABLE                   EQU   03F7H
TM70_ENABLE                   EQU   03F7H
TM71_ENABLE                   EQU   03F7H

TM68E                         EQU   0E0H
TM68D                         EQU   0E1H

TM69E                         EQU   0E2H
TM69D                         EQU   0E3H

TM70E                         EQU   0E4H
TM70D                         EQU   0E5H

TM71E                         EQU   0E6H
TM71D                         EQU   0E7H
;-------------------------------------------------------
TM72_ENABLE                   EQU   03F8H
TM73_ENABLE                   EQU   03F8H
TM74_ENABLE                   EQU   03F8H
TM75_ENABLE                   EQU   03F8H

TM72E                         EQU   0E0H
TM72D                         EQU   0E1H

TM73E                         EQU   0E2H
TM73D                         EQU   0E3H

TM74E                         EQU   0E4H
TM74D                         EQU   0E5H

TM75E                         EQU   0E6H
TM75D                         EQU   0E7H
;---------------------------------------------------
TM76_ENABLE                   EQU   03F9H
TM77_ENABLE                   EQU   03F9H
TM78_ENABLE                   EQU   03F9H
TM79_ENABLE                   EQU   03F9H

TM76E                         EQU   0E0H
TM76D                         EQU   0E1H

TM77E                         EQU   0E2H
TM77D                         EQU   0E3H

TM78E                         EQU   0E4H
TM78D                         EQU   0E5H

TM79E                         EQU   0E6H
TM79D                         EQU   0E7H
;--------------------------------------------------------
TM100_ENABLE                   EQU   03FAH;0070H

TM100E                         EQU   0E0H
E2HS_TM100E                    EQU   0E0H

TM100D                         EQU   0E1H
E2HS_TM100D                    EQU   0E1H

TM101E                         EQU   0E2H
HEATER_SOFT_START_TM101E       EQU   0E2H

TM101D                         EQU   0E3H
HEATER_SOFT_START_TM101D       EQU   0E3H

TM102E                            EQU   0E4H
PREFORM_SENSR_DEBOUN_DLY_TM102E   EQU   0E4H

TM102D                            EQU   0E5H
PREFORM_SENSR_DEBOUN_DLY_TM102D   EQU   0E5H

TM103E                         EQU   0E6H
TM103D                         EQU   0E7H
;;----------------------------------------------------------
TM104_ENABLE                   EQU   03FBH
TM106_ENABLE                   EQU   03FBH
TM107_ENABLE                   EQU   03FBH

TM104E                       EQU    0E0H
HOPPER_ROLLER_JAM_TM104E     EQU    0E0H

TM104D                       EQU    0E1H
HOPPER_ROLLER_JAM_TM104D     EQU    0E1H

TM105E                       EQU    0E2H
HOPPER_PRM_EMPTY_TM105E      EQU    0E2H

TM105D                       EQU    0E3H
HOPPER_PRM_EMPTY_TM105D      EQU    0E3H

TM106E                       EQU    0E4H
MOULD_OPEN_IP_ERR_TM106E     EQU    0E4H

TM106D                         EQU    0E5H
MOULD_OPEN_IP_ERR_TM106D       EQU    0E5H

TM107E                         EQU    0E6H
PREFORMSHIFT_FWD_IP_ERR_TM107E EQU    0E6H

TM107D                         EQU    0E7H
PREFORMSHIFT_FWD_IP_ERR_TM107D EQU    0E7H
;----------------------------------------------------------   
TM108_ENABLE                   EQU   03FCH
TM109_ENABLE                   EQU   03FCH
TM110_ENABLE                   EQU   03FCH
TM111_ENABLE                   EQU   03FCH

TM108E                                 EQU    0E0H
PREFORMSHIFT_BACK_IP_ERR_TM108E        EQU    0E0H

PREFORMSHIFT_BACK_IP_ERR_TM108D        EQU    0E1H
TM108D                                 EQU    0E1H

TM109E                                 EQU    0E2H
PREFORMSHIFT_LOCK_IP_ERR_TM109E        EQU    0E2H

PREFORMSHIFT_LOCK_IP_ERR_TM109D        EQU    0E3H
TM109D                                 EQU    0E3H

TM110E                                 EQU    0E4H
MOULD_CLOSE_IP_ERR_TM110E              EQU    0E4H

MOULD_CLOSE_IP_ERR_TM110D              EQU    0E5H
TM110D                                 EQU    0E5H

TM111E                                 EQU    0E6H
MOULD_BOTTOM_IP_ERR_TM111E             EQU    0E6H

MOULD_BOTTOM_IP_ERR_TM111D             EQU    0E7H
TM111D                                 EQU    0E7H
;----------------------------------------------------------   
TM112_ENABLE                   EQU   03FDH
TM113_ENABLE                   EQU   03FDH
TM114_ENABLE                   EQU   03FDH
TM115_ENABLE                   EQU   03FDH

TM112E                         EQU    0E0H
BOTTLE_TRANSFER_IP_ERR_TM112E  EQU    0E0H

BOTTLE_TRANSFER_IP_ERR_TM112D  EQU    0E1H
TM112D                         EQU    0E1H


;-----------------------------------------------------------------------------------------------
;FIXED CHARACTER DEFINITION
;-------------------------------------------------------------------------------------------------

END_CHARACTER_1     EQU   0DH                            ;5AH
END_CHARACTER_2     EQU   0AH
HEADER              EQU   3AH
NO_OF_BYTES         EQU   24
;-----------------------------------------------------------------------------------------------

	org	0000h
	LJMP  MAIN                     ;	main

	ORG     0003H

	ORG     000BH
	LJMP    ISR_T0          ;	isr_t0		;timer0 interrupt

        ORG    0013H

	ORG	0023H
	LJMP	SERIAL		;serial interrupt


     

;-----------------------------------------------------------------------------------------------
;initialises stack pointer,bits & bytes variables
;-----------------------------------------------------------------------------------------------

        INIT:	

	MOV	IE,#00h				;interrupt enable reg.=00h
	MOV	TMOD,#00			;timer mode control reg.=00h
	MOV	TCON,#00h			;timer control=00h
	MOV	SCON,#00h			;serial port control reg.=00h
	MOV	TL0,#00h			;timer0=00h
	MOV	TH0,#00h
	MOV	TL1,#00h			;timer1=00h
	MOV	TH1,#00h	
	MOV	BYTE_CNT,#00
	MOV	COUNT_1S,#0FFH			;3.64*255*03=2784ms
	MOV	IP,#10H
        RET
;---------------------------------------------------
	INIT_1:
	
	clr	rcve_over
	clr	trans_over 
	clr	last_byte
	clr	delay_over
   RET
;-----------------------------------------------------------------------------------------------
;initialises timer0 for time interval of 3.5 char
;-----------------------------------------------------------------------------------------------
;--------------------------------------------------------------------
;(89h)
;TMOD-->GATE, C/T, M1,	M0, GATE, C/T, M1, M0, T/C (timer1,timer0)
;init timer 0  for 3.5 char time
   init_timer0:
	
	ORL	TMOD,#01H		;t0 in 16 bit timer mode.
	MOV	TL0,#0CCH    ;0CCH		;Init timer0 with count for 3.64 msec
	MOV	TH0,#0F8H    ;0F8H		;count=0f2dfh for 3.64msec.
	SETB	TR0			   ;start timer 0.
        SETB	ET0			   ;enable timer 0 Interrupt.
	SETB	EA
	RET 

;--------------------------------------------------------------------
;isr for timer0 interrupt
;--------------------------------------------------------------------


   ISR_T0:	

        PUSH    PSW
        MOV     TL0,#0CCH    ;0CCH
        MOV     TH0,#0F8H     ;0F8H
	INC     TIMECT
	INC     SECOND_CLK
	INC     IP_DEBOUNCE
	INC     TC_TIMECT
	;INC     CH_TIMECT
	DJNZ	COUNT_1S,OUT_ISRT0		;3.64*255
	SETB	DELAY_OVER			;3sec delay is over					

   
   
        OUT_ISRT0:
        
	POP     PSW
	RETI
;--------------------------------------------------------------------
   INIT_TIMER1:
	
	ORL	  TMOD,#20H  		;t1 in 8 bit auto reload mode.
	MOV     TH1,#0FDH               ;init. TH1 with count for
					;9600 baud (11.059MHz)
	SETB    TR1                     ;Start timer 1 (baud rate)
	RET

;-----------------------------------------------------------------------------------------------
;initialises to receive data on serial port
;-----------------------------------------------------------------------------------------------

   init_rcve:
	
   MOV	SCON,#50H       			;mode-1,8-bit,ren enabled
	ORL	IE,#10010000B			;enable serial interrupt

	LCALL	INIT_TIMER1		
   RET

;-----------------------------------------------------------------------------------------------
;initialises to xmit data on serial port
;-----------------------------------------------------------------------------------------------

   INIT_XMIT:
	
	MOV	SCON,#40H			;mode1,8-bit,ren disabled
	ORL	IE,#10010000B			;enable serial interrupt
   LCALL	INIT_TIMER1	
	RET

;-----------------------------------------------------------------------------------------------
;POWER ON INITALISATION
;-----------------------------------------------------------------------------------------------
   MAIN:
	
;--------PLC START POWER ON PROBLEM SOLVED BY VINAYAK DATED:310724------------
   MOV	 SP,#0E0H					
;-------------------------------------------   
   ;MOV    085H,#0F0H   ;WATCHDOG INITALISATION
;-------------------------------------------
   MOV    R7,#0FFH

   DLY100:

   MOV    R6,#0FFH

   DLY200:

   NOP
   NOP
   NOP
   DJNZ   R6,DLY200
   DJNZ   R7,DLY100
;--------PLC START POWER ON PROBLEM SOLVED BY VINAYAK DATED:310724------------
;-------------------------------------------------------------------------------------
   MOV    R0,#0
   MOV    R7,#255  
   MOV    A,#0
;----------------------------------
   CLEAR_NXT_INT_RAM:
   
   MOV    @R0,A
   INC    R0
   DJNZ   R7,CLEAR_NXT_INT_RAM

   LCALL    INIT
   LCALL    INIT_TIMER0
   ;MOV      TC_DEBOUNCE_TIME,#5

   T2CON    EQU   0C8H
   T2MOD    EQU   0C9H
   RACP2L   EQU   0CAH
   RCAP2H   EQU   0CBH
;-------------------------------------
   MOV      A,#0H
   MOV      DPTR,#ZONE1_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE2_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE3_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE4_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE5_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE6_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE7_ACT_L
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE8_ACT_L
   MOVX     @DPTR,A

   MOV      A,#0
   MOV      DPTR,#ZONE1_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE2_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE3_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE4_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE5_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE6_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE7_ACT_H
   MOVX     @DPTR,A
   MOV      DPTR,#ZONE8_ACT_H
   MOVX     @DPTR,A

   MOV      A,#0
   MOV      DPTR,#CYCLE_TIME_L
   MOVX     @DPTR,A
   MOV      A,#0
   MOV      DPTR,#CYCLE_TIME_H
   MOVX     @DPTR,A
   MOV      OUT0_7,#0
   MOV      OUT8_15,#0
   MOV      OUT16_23,#0
   LCALL    LOAD_OUTPUT

   

;----------------------------------------------------
;CLOCK FREQ.SETTING
;-------------------------------------------------
;   MOV    RACP2L,#40H;77H   ;0BDH    ;08EH;08FH  ;09AH  
;  ;RACP2L & RCAP2H IS THE SPEED OF PULSES WITH FFEAH A FREQ OF 250 KHZ IS GENERATED
;
;   MOV    RCAP2H,#0FEH      ;0FFH
;        
;   MOV    T2MOD,#02H      ;TMOD.1 I.E IS T20E
;   MOV    T2CON,#04H     ;T2CON.2 BIT
;-----------------------------------------------------------
;SERIAL INITALISATION
;-----------------------------------------------------------  
   
   
   MAIN_LOOP:
   
;-----------------------------------------------------------------   
;START OF MAIN PROGRAM
;-----------------------------------------------------------------
   
   MAIN_ROUTINE:
            
   LCALL  SERIAL_COMMUNICATION
   LCALL  TMR_HANDLER
   LCALL  LADDER
   LCALL  CTR_HANDLER	
   LCALL  READ_INPUTS
   LCALL  LADDER_INIT
   
   LCALL  CHECK_ALARM
  ; LCALL  BOTTLE_EJECTOR_AIR_THROW
   LCALL  LOAD_OUTPUT
   LCALL  POWER_CONTROL
   LCALL  PROD_COUNTER
   SETB   B_FIRST_CYCLE					               		
  ; LCALL  RESET_WDT   
   LJMP   MAIN_LOOP
   
;****************************************************
	
   TRANSMIT:
	
   CLR    IE.4                                             
   CLR	  RCVE_OVER	   
   LCALL  RESET_WDT   
   MOV    R0,#RX_BUF
   INC    R0
   INC    R0
   MOV    A,@R0
   INC    R0
   MOV    A,@R0
   CJNE   A,#31H,CHECK_QUERY_LESS_THAN_10H
   SJMP   CHECK_FN_CODE_10_QUERY
   
   CHECK_QUERY_LESS_THAN_10H:
   
   INC    R0
   MOV    A,@R0
   CJNE   A,#33H,CHECK_FN_CODE_06_QUERY
   LJMP   FN_CODE_03_REPLY
   
   CHECK_FN_CODE_06_QUERY:
   
   CJNE   A,#36H,CHECK_FN_01_QUERY
   LJMP   FN_CODE_06_QUERY
   
   CHECK_FN_01_QUERY:
   
   CJNE   A,#31H,CHECK_FN_CODE_02_QUERY
   LJMP   FN_CODE_01_QUERY
   
   CHECK_FN_CODE_02_QUERY:

   CJNE   A,#32H,CHECK_FN_CODE_05_QUERY
   LJMP   FN_CODE_02_QUERY
   
   CHECK_FN_CODE_05_QUERY:
   
   CJNE   A,#35H,CHECK_FN_CODE_0F_QUERY
   LJMP   FN_CODE_05_QUERY
   
   CHECK_FN_CODE_0F_QUERY:
   
   CJNE   A,#46H,NOT_MY_QUERY                            ;MAIN_LOOP                          ;
   LJMP   FN_CODE_0F_QUERY
   
   
   CHECK_FN_CODE_10_QUERY:
   
   INC    R0
   MOV    A,@R0
   CJNE   A,#30H,NOT_MY_QUERY                          ;MAIN_LOOP
   LJMP   FN_CODE_10_QUERY

   NOT_MY_QUERY:
   
   LCALL  INITALISE_RECEIVE
   RET
  ; LJMP   MAIN_LOOP  
      
;************************************************************************  
;   
   
   FN_CODE_03_REPLY:
      
   LCALL  CAL_START_ADDRESS
      
   TRANSMIT_DATA:
   
   LCALL  ASCII_TO_HEX    ;NO OF REGISTERS TO READ WILL NOT EXCEED 16 HENCE THESE LOCN ARE DISCARDED
   LCALL  ASCII_TO_HEX  
   MOV    BYTE_CNT,A    ;BYTE_COUNT
;------------------------------------------------     
  	LCALL HEADER_SLAVE_ID
;------------------------------------------------	
   INC   R1
	MOV   A,#30H    ;FUNCTION CODE
   MOV   @R1,A  
   INC   R1
   MOV   A,#33H
   MOV   @R1,A
   INC   R1
;------------------------------------------------   
;BYTE COUNT  
;------------------------------------------------   
   MOV   A,BYTE_CNT
   CLR   C
   RLC   A
   LCALL HEX_TO_ASCII
  
;------------------------------------------------------
   
   MOV   A,BYTE_CNT
   CLR   C
   RLC   A
   MOV   R7,A
 
   CAL_DPTR:
   
   MOV   DPTR,#START_ADDRESS_DATA_REG          ;-2               ;-2
   MOV   A,DPL
   ADD   A,TEMP2
   MOV   DPL,A
   MOV   A,DPH
   ADDC  A,TEMP1
   MOV   DPH,A
   
   GET_NEXT_DATA:
   
   MOVX  A,@DPTR                                   
   PUSH  ACC
   MOV   A,TEMP2
   CLR   C
   ADD   A,#01
   MOV   TEMP2,A
   ;INC   TEMP2
   JNC   NO_DPTR_INCREASE
   INC   TEMP1
   
   NO_DPTR_INCREASE:
   
   POP   ACC
;---------------------------
   LCALL HEX_TO_ASCII   
   DJNZ  R7,CAL_DPTR                         
  
;--------------------------------------------------------------------
	MOV   A,BYTE_CNT 
	MOV   B,#4
        MUL   AB
        ADD   A,#6
	MOV   R7,A             ;BYTE COUNT WHOSE LRC IS TO BE CALCULATED
	MOV   R1,#TX_BUF                              ;R0,#TX_BUF            
	INC   R1
;----------------------------------------------------	
	LCALL	CAL_LRC		;MODBUS ASCII CHECK IT SHOULD BE DIVIDE BY 2		      
;---------------------------------------------------	
	MOV     A,BYTE_CNT
	MOV     B,#4
	MUL     AB
	ADD     A,#7
	MOV     R7,A
	LCALL   ADD_LRC_ASC   		        
	LJMP    TRANSMIT_DATA_START
;--------------------------------------------------------	
;FN CODE 03 READ DAT REGS ENDS HERE	
;--------------------------------------------------------	
;*********************************************************************************************	
;-----------------------------------------   
;MOVES THE DATA INTO THE PRESET REGISTER
;-----------------------------------------   

   
   
   FN_CODE_06_QUERY:
   
   LCALL  CAL_START_ADDRESS   
;   MOV    A,TEMP2
;   MOV    START_ADDR_REG,A 
   LCALL  ASCII_TO_HEX
   MOV    B,A

   MOV    DPTR,#START_ADDRESS_DATA_REG          
   MOV    A,DPL
   CLR    C
   ADD    A,TEMP2
   MOV    DPL,A
   MOV    A,DPH
   ADDC   A,TEMP1
   MOV    DPH,A
   MOV    A,B   
   MOVX   @DPTR,A
   LCALL  ASCII_TO_HEX
   MOV    B,A
   MOV    DPTR,#START_ADDRESS_DATA_REG+1          
   MOV    A,DPL
   CLR    C
   ADD    A,TEMP2
   MOV    DPL,A
   MOV    A,DPH
   ADDC   A,TEMP1
   MOV    DPH,A
   MOV    A,B   
   MOVX   @DPTR,A
   
;-----------------------------------------------   
   TRANSMIT_REPLY:
   
   MOV   BYTE_CNT,#0
   
   REPEAT_TRANSFER_FROM_RX_TX:
   
   MOV   R0,#RX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R0
   MOV   R0,A
   MOV   A,@R0
   MOV   B,A
   MOV   R1,#TX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R1
   MOV   R1,A
   MOV   A,B   
   MOV   @R1,A
   INC   BYTE_CNT
   CJNE  A,#END_CHARACTER_2,REPEAT_TRANSFER_FROM_RX_TX
;   SETB  SAVE_SET_DATA
;   MOV   A,#0
;   MOV   START_ADDR_REG,A
;   MOV   SECOND_CLK,A

   LJMP  TRANSMIT_DATA_START
;----------------------------------------------------
;START OF FN 01 QUERY
;----------------------------------------------------   
   FN_CODE_01_QUERY:
   
   MOV    RSLT_0,#0
   INC    R0
   LCALL  ASCII_TO_HEX
   MOV    B,#32
   MUL    AB
   MOV    TEMP1,A
;-----------------------------------------
   LCALL  ASCII_TO_HEX
   MOV    B,#8
   DIV    AB
   CLR    C
   ADD    A,TEMP1
   MOV    TEMP2,A
   MOV    A,B       ;RETREIVE REMAINDER
   CLR    C
   MOV    R5,A    
   LCALL  ASCII_TO_HEX    ;NO OF BITS TO READ WILL NOT EXCEED 256 HENCE THESE LOCN ARE DISCARDED
   LCALL  ASCII_TO_HEX  
   MOV    BYTE_CNT,A    ;BYTE_COUNT
     
   
   LOAD_TRANSMIT_BUFFER_FN_CODE_01:
   
   LCALL  HEADER_SLAVE_ID
;--------------------------------------   
   INC   R1
   MOV   A,#30H    ;FUNCTION CODE
   MOV   @R1,A  
   INC   R1
   MOV   A,#31H
   MOV   @R1,A
   INC   R1
 
   MOV   A,#01
   MOV   RSLT_0,A
   LCALL HEX_TO_ASCII
;------------------------------------------------------------------
   
   BYTE_CNT_LOADED_FN_CODE_01:
   

;CHECK 
;   MOV   A,BYTE_CNT
;   CJNE  A,#01,CHECK_FOR_MORE_THAN_1_BIT
;   
;   CHECK_FOR_MORE_THAN_1_BIT:
;
;   JNC   READ_MORE_THAN_1_BIT
;   
;   MOV   A,#30H
;   MOV   @R1,A
;   INC   R1   
   
;---------------------------   
   MOV    R0,#OUT0_7                      ;BIT_START_ADDRESS
   MOV    A,R0
   ADD    A,TEMP2
   MOV    R0,A
   MOV    A,@R0
   MOV    TEMP1,A
   INC    R0
   MOV    A,@R0
   MOV    TEMP2,A
   CLR    C
   
   ;CHECK_NEXT_BIT:

   MOV   A,R5  ;; RETREIVE THE REMAINDER
   
   CJNE  A,#00H,CHECK_1_FN_CODE_01
   MOV   A,TEMP1 
   AJMP  TRANSMIT_START_FN_CODE_01

   CHECK_1_FN_CODE_01:
   
   CJNE   A,#01,CHECK_2_FN_CODE_01       ;HERE A CONTAINS THE NUMBER OF BITS TO BE READ
   MOV    A,TEMP1
   ANL    A,#11111110B                                        ;00000011B  
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00000001B   
   RR     A
   ORL    A,B
   AJMP   TRANSMIT_START_FN_CODE_01
   
   CHECK_2_FN_CODE_01:
   
   CJNE   A,#02,CHECK_3_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#11111100B                                                    
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00000011B
   RR     A
   RR     A
   ORL    A,B
   AJMP   TRANSMIT_START_FN_CODE_01
   
   CHECK_3_FN_CODE_01:
   
   CJNE   A,#03,CHECK_4_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#11111000B                                                       
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00000111B
   RR     A
   RR     A
   RR     A
   ORL    A,B                           
   AJMP   TRANSMIT_START_FN_CODE_01

   CHECK_4_FN_CODE_01:
   
   CJNE   A,#04,CHECK_5_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#11110000B                                                        
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00001111B
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                            
                        
   AJMP   TRANSMIT_START_FN_CODE_01

   CHECK_5_FN_CODE_01:
   
   CJNE   A,#05,CHECK_6_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#11100000B                                                      
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00011111B
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                             
   AJMP   TRANSMIT_START_FN_CODE_01

   CHECK_6_FN_CODE_01:
   
   CJNE   A,#06,CHECK_7_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#11000000B                                                      
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00111111B
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                             
   AJMP   TRANSMIT_START_FN_CODE_01

   CHECK_7_FN_CODE_01:
   
   CJNE   A,#07,CHECK_7_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#10000000B                                                      
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#01111111B
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                             

   
   TRANSMIT_START_FN_CODE_01:
   
   MOV    TEMP1,A
   MOV    A,BYTE_CNT
   CJNE   A,#01,CHECK_02_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#00000001B
   LJMP   TRANSMIT_FN_START_FN_01
   
   CHECK_02_BYTE_CNT_FN_CODE_01:
   
   CJNE   A,#02,CHECK_03_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#00000011B
   LJMP   TRANSMIT_FN_START_FN_01

   CHECK_03_BYTE_CNT_FN_CODE_01:
   
   CJNE   A,#03,CHECK_04_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#00000111B
   LJMP   TRANSMIT_FN_START_FN_01

   CHECK_04_BYTE_CNT_FN_CODE_01:
   
   CJNE   A,#04,CHECK_05_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#00001111B
   LJMP   TRANSMIT_FN_START_FN_01

   CHECK_05_BYTE_CNT_FN_CODE_01:
   
   CJNE   A,#05,CHECK_06_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#00011111B
   LJMP   TRANSMIT_FN_START_FN_01

   CHECK_06_BYTE_CNT_FN_CODE_01:
   
   CJNE   A,#06,CHECK_07_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#00111111B
   LJMP   TRANSMIT_FN_START_FN_01

   CHECK_07_BYTE_CNT_FN_CODE_01:
   
   CJNE   A,#07,CHECK_08_BYTE_CNT_FN_CODE_01
   MOV    A,TEMP1
   ANL    A,#01111111B
   LJMP   TRANSMIT_FN_START_FN_01

   CHECK_08_BYTE_CNT_FN_CODE_01:
   
   MOV    A,TEMP1


   TRANSMIT_FN_START_FN_01:

   LCALL  HEX_TO_ASCII
      
   REPLY_BIT_LOADED:
   	
    MOV	  R1,#TX_BUF                              ;R0,#TX_BUF            
    INC   R1	
    MOV   A,RSLT_0
   MOV   B,#02
   MUL   AB
	ADD   A,#06
   MOV   R7,A
   
   DO_NOT_INC_BYTE_COUNTER_1:
   
;----------------------------------------------------   
   LCALL	CAL_LRC		;MODBUS ASCII CHECK IT SHOULD BE 5		      
;----------------------------------------------------   
   MOV   A,RSLT_0
   MOV   B,#02
   MUL   AB  
	ADD   A,#07          
   MOV   R7,A

   LCALL ADD_LRC_ASC
   LJMP  TRANSMIT_DATA_START
;*******************************************************************************
   FN_CODE_02_QUERY:
;*******************************************************************************
   MOV    RSLT_0,#0
   INC    R0
   LCALL  ASCII_TO_HEX
   MOV    B,#32
   MUL    AB
   MOV    TEMP1,A
;-----------------------------------------
   LCALL  ASCII_TO_HEX
   MOV    B,#8
   DIV    AB
   CLR    C
   ADD    A,TEMP1
   MOV    TEMP2,A
   MOV    A,B       ;RETREIVE REMAINDER
   CLR    C
   MOV    REMAINDER,A                                 ;  R5,A    
   LCALL  ASCII_TO_HEX    ;NO OF BITS TO READ WILL NOT EXCEED 256 HENCE THESE LOCN ARE DISCARDED
   LCALL  ASCII_TO_HEX  
   MOV    BYTE_CNT,A    ;BYTE_COUNT
     
   
   LOAD_TRANSMIT_BUFFER_FN_CODE_02:
   
   LCALL  HEADER_SLAVE_ID
;--------------------------------------   
   INC   R1
   MOV   A,#30H    ;FUNCTION CODE
   MOV   @R1,A  
   INC   R1
   MOV   A,#32H
   MOV   @R1,A
   INC   R1
;---------------------------------------   
  
   
   CLR   BIT_READ_MORE_THAN_8   
   MOV   A,#01
   MOV   RSLT_0,A
   LCALL HEX_TO_ASCII

   
   ;PUSH   DPH
   ;PUSH   DPL
   MOV    R0,#INPUT_DISPLAY_ADDRESS                    ;BIT_START_ADDRESS
   MOV    A,R0
   ADD    A,TEMP2
   MOV    R0,A
   MOV    A,@R0
   CLR    C
   MOV    TEMP1,A
   INC    R0
   MOV    A,@R0
   MOV    TEMP2,A
   
;   MOV    A,DPH
;   ADDC   A,#0
;   MOV    DPH,A      
;   MOVX   A,@DPTR
;   
;   INC    DPTR
;   MOVX   A,@DPTR
;   MOV    TEMP2,A
;   POP    DPL
;   POP    DPH   
;-----------------------------------------------------      
   MOV    A,REMAINDER   
   CJNE   A,#0,CHECK_1_FN_CODE_02
   MOV    A,TEMP1
   AJMP   TRANSMIT_START_FN_CODE_02
   
   CHECK_1_FN_CODE_02:
   
   CJNE   A,#01,CHECK_2_FN_CODE_02          ;HERE A CONTAINS THE NUMBER OF BITS TO BE READ
   MOV    A,TEMP1
   ANL    A,#11111110B                                        ;00000011B  
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00000001B   
   RR     A
   ORL    A,B
   AJMP   TRANSMIT_START_FN_CODE_02
   
   CHECK_2_FN_CODE_02:
   
   CJNE   A,#02,CHECK_3_FN_CODE_02 
   MOV    A,TEMP1
   ANL    A,#11111100B                                                        ;00000111B  
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00000011B
   RR     A
   RR     A
   ORL    A,B
   AJMP   TRANSMIT_START_FN_CODE_02
   
   CHECK_3_FN_CODE_02:
   
   CJNE   A,#03,CHECK_4_FN_CODE_02 
   MOV    A,TEMP1
   ANL    A,#11111000B                                                        ;00000111B  
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00000111B
   RR     A
   RR     A
   RR     A
   ORL    A,B                             ;00001111B  
   AJMP   TRANSMIT_START_FN_CODE_02

   CHECK_4_FN_CODE_02:
   
   CJNE   A,#04,CHECK_5_FN_CODE_02 
   MOV    A,TEMP1
   ANL    A,#11110000B                                                        ;00000111B  
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00001111B
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                            
                        
   AJMP   TRANSMIT_START_FN_CODE_02

   CHECK_5_FN_CODE_02:
   
   CJNE   A,#05,CHECK_6_FN_CODE_02 
   MOV    A,TEMP1
   ANL    A,#11100000B                                                      
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00011111B
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                             
   AJMP   TRANSMIT_START_FN_CODE_02

   CHECK_6_FN_CODE_02:
   
   CJNE   A,#06,CHECK_7_FN_CODE_02 
   MOV    A,TEMP1
   ANL    A,#11000000B                                                      
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#00111111B
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                             
   AJMP   TRANSMIT_START_FN_CODE_02

   CHECK_7_FN_CODE_02:
   
   CJNE   A,#07,CHECK_7_FN_CODE_02 
   MOV    A,TEMP1
   ANL    A,#10000000B                                                      
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   MOV    B,A
   MOV    A,TEMP2
   ANL    A,#01111111B
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   RR     A
   ORL    A,B                             
;   MOV    B,A
;----------------------------------------------      
   TRANSMIT_START_FN_CODE_02:
   
   MOV    TEMP1,A
   MOV    A,BYTE_CNT
   CJNE   A,#01,CHECK_02_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#00000001B
   LJMP   TRANSMIT_FN_START_FN_02
   
   CHECK_02_BYTE_CNT:
   
   CJNE   A,#02,CHECK_03_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#00000011B
   LJMP   TRANSMIT_FN_START_FN_02

   CHECK_03_BYTE_CNT:
   
   CJNE   A,#03,CHECK_04_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#00000111B
   LJMP   TRANSMIT_FN_START_FN_02

   CHECK_04_BYTE_CNT:
   
   CJNE   A,#04,CHECK_05_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#00001111B
   LJMP   TRANSMIT_FN_START_FN_02

   CHECK_05_BYTE_CNT:
   
   CJNE   A,#05,CHECK_06_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#00011111B
   LJMP   TRANSMIT_FN_START_FN_02

   CHECK_06_BYTE_CNT:
   
   CJNE   A,#06,CHECK_07_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#00111111B
   LJMP   TRANSMIT_FN_START_FN_02

   CHECK_07_BYTE_CNT:
   
   CJNE   A,#07,CHECK_08_BYTE_CNT
   MOV    A,TEMP1
   ANL    A,#01111111B
   LJMP   TRANSMIT_FN_START_FN_02

   CHECK_08_BYTE_CNT:
   
   MOV    A,TEMP1
;--------------------------------------------------------   
   TRANSMIT_FN_START_FN_02:
   
   LCALL  HEX_TO_ASCII
      
   REPLY_BIT_LOADED_FN_CODE_02:

    MOV	  R1,#TX_BUF                              ;R0,#TX_BUF            
    INC   R1	
    MOV   A,RSLT_0
    MOV   B,#02
    MUL   AB
    ADD   A,#06
    MOV   R7,A
   
    DO_NOT_INC_BYTE_COUNTER_2:
     
   LCALL CAL_LRC		;MODBUS ASCII CHECK IT SHOULD BE 5		      
   MOV   A,RSLT_0
   MOV   B,#02
   MUL   AB  
   ADD   A,#07          
   MOV   R7,A
   LCALL ADD_LRC_ASC
   LJMP  TRANSMIT_DATA_START   

;********************************************************************************   
   FN_CODE_05_QUERY:
   
   INC    R0
   LCALL  ASCII_TO_HEX
   MOV    TEMP1,A
   MOV    B,#32
   MUL    AB
   MOV    TEMP1,A
   LCALL  ASCII_TO_HEX
   MOV    B,#8
   DIV    AB
   CLR    C
   ADD    A,TEMP1
   MOV    TEMP2,A
   MOV    A,B       ;RETREIVE REMAINDER
   CLR    C
   MOV    R5,A   
   LCALL  ASCII_TO_HEX
   MOV    B,A               ;LOAD DATA 00 OR FFH IF THE COIL IS ON IT IS FF ELSE IT IS 00.
   MOV    R0,#OUT0_7     ;BIT_START_ADDRESS
   MOV    A,R0
   ADD    A,TEMP2
   MOV    R0,A
   MOV    A,@R0
   MOV    TEMP1,A
   MOV    A,B
   
   CJNE   A,#0FFH,COIL_NOT_SET
   
   
   MOV    A,TEMP1
   CJNE   R5,#00,SET_BIT_01
   SETB   ACC.0
   SJMP   RELOAD_BACK_DATA
   
   SET_BIT_01:
   
   CJNE   R5,#01,SET_BIT_02
   SETB   ACC.1
   SJMP   RELOAD_BACK_DATA
   
   SET_BIT_02:
   
   CJNE   R5,#02,SET_BIT_03
   SETB   ACC.2
   SJMP   RELOAD_BACK_DATA
   
   SET_BIT_03:
   
   CJNE   R5,#03,SET_BIT_04
   SETB   ACC.3
   SJMP   RELOAD_BACK_DATA

   SET_BIT_04:
   
   CJNE   R5,#04,SET_BIT_05
   SETB   ACC.4
   SJMP   RELOAD_BACK_DATA
   
   
   SET_BIT_05:
   
   CJNE   R5,#05,SET_BIT_06
   SETB   ACC.5
   SJMP   RELOAD_BACK_DATA
   
   SET_BIT_06:
   
   CJNE   R5,#06,SET_BIT_07
   SETB   ACC.6
   SJMP   RELOAD_BACK_DATA
   
   
   SET_BIT_07:
   
   SETB   ACC.7
   SJMP   RELOAD_BACK_DATA
;----------------------------------------------   
   
   COIL_NOT_SET:
      
   MOV    A,TEMP1
   CJNE   R5,#00,CLR_BIT_01
   CLR    ACC.0
   SJMP   RELOAD_BACK_DATA
   
   CLR_BIT_01:
   
   CJNE   R5,#01,CLR_BIT_02
   CLR    ACC.1
   SJMP   RELOAD_BACK_DATA
   
   CLR_BIT_02:
   
   CJNE   R5,#02,CLR_BIT_03
   CLR    ACC.2
   SJMP   RELOAD_BACK_DATA
   
   CLR_BIT_03:
   
   CJNE   R5,#03,CLR_BIT_04
   CLR    ACC.3
   SJMP   RELOAD_BACK_DATA

   CLR_BIT_04:
   
   CJNE   R5,#04,CLR_BIT_05
   CLR    ACC.4
   SJMP   RELOAD_BACK_DATA
   
   
   CLR_BIT_05:
   
   CJNE   R5,#05,CLR_BIT_06
   CLR    ACC.5
   SJMP   RELOAD_BACK_DATA
   
   CLR_BIT_06:
   
   CJNE   R5,#06,CLR_BIT_07
   CLR    ACC.6
   SJMP   RELOAD_BACK_DATA
   
   
   CLR_BIT_07:
   
   CLR    ACC.7
    
;---------------------------------------------------------
   RELOAD_BACK_DATA:
   
   MOV    @R0,A
 
   REPLY_05_START:
   
   ;LCALL HEADER_SLAVE_ID
   MOV   BYTE_CNT,#0
   MOV   R7,#15
   
   REPEAT_05_REPLY:
      
   MOV   R0,#RX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R0
   MOV   R0,A
   MOV   A,@R0
   MOV   B,A
   MOV   R1,#TX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R1
   MOV   R1,A
   MOV   A,B
   MOV   @R1,A
   INC   BYTE_CNT
   CJNE	A,#END_CHARACTER_2,REPEAT_05_REPLY
   
   LJMP  TRANSMIT_DATA_START
;**********************************************************************   
   FN_CODE_0F_QUERY:
   
   
   INC    R0
   LCALL  ASCII_TO_HEX
   MOV    RSLT_1,A               ;RSLT_0
   MOV    B,#32
   MUL    AB
   MOV    TEMP1,A

   LCALL  ASCII_TO_HEX
   MOV    RSLT_0,A
   MOV    B,#8
   DIV    AB
   CLR    C
   ADD    A,TEMP1
   MOV    TEMP2,A
   LCALL  ASCII_TO_HEX    ;NO OF REGISTERS TO READ WILL NOT EXCEED 16 HENCE THESE LOCN ARE DISCARDED
   LCALL  ASCII_TO_HEX       
   LCALL  ASCII_TO_HEX  ;NO OF BYTES TO BE PRESET
   CLR    C
   RLC    A
   MOV    BYTE_CNT,A
   MOV    R7,A

   
   MOV    R1,#SCRATCHPAD_0
   
   NEXT_DATA:
   
   LCALL  ASCII_TO_HEX  ;HIGH ORDER BYTE OF DATA   
   MOV    @R1,A
   INC    R1
   DJNZ   R7,NEXT_DATA
  
  
   SAVE_DATA:
   
   MOV    R1,#OUT0_7    ;BIT_START_ADDRESS
   MOV    A,R1
   ADD    A,TEMP2
   MOV    R1,A  
   MOV    R7,BYTE_CNT
   MOV    R0,#SCRATCHPAD_0
   
   NEXT_BYTE_FN_CODE_0F:
   
   MOV    A,@R0   
   MOV    @R1,A
   INC    R1
   INC    R0
   DJNZ   R7,NEXT_BYTE_FN_CODE_0F
   
   
;------------------------------------------------
;START TRANSMISSION OF REPLY
;------------------------------------------------
   
   
   MOV   R7,#13
   MOV   BYTE_CNT,#0
   
   REPEAT_0F_REPLY:

   MOV   R0,#RX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R0
   MOV   R0,A
   MOV   A,@R0
   MOV   B,A
   MOV   R1,#TX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R1
   MOV   R1,A
   MOV   A,B
   MOV   @R1,A
   INC   BYTE_CNT
   DJNZ  R7,REPEAT_0F_REPLY
;-------------------------------------------------------------  	
  	MOV    R7,#12       ;MODBUS ASCII CHECK IT SHOULD BE 6
;-------------------------------------------------------------  	
  	MOV	 R1,#TX_BUF                              ;R0,#TX_BUF            
	INC    R1
	LCALL	 CAL_LRC				      ;calculates lrc code for ascii data

  	MOV    R7,#13
	LCALL  ADD_LRC_ASC   		     
   LJMP   TRANSMIT_DATA_START  
;***********************************************************   
   FN_CODE_10_QUERY:
   
   LCALL  CAL_START_ADDRESS   
   LCALL  ASCII_TO_HEX   ;NO. OF REGISTERS HIGH 
   LCALL  ASCII_TO_HEX   ;NO. OF REGISTERS LOW
   MOV    R5,A
   LCALL  ASCII_TO_HEX  ;BYTE COUNT
   
   NEXT_DATA_REG:
   
   LCALL  ASCII_TO_HEX
   MOV    B,A        ;DATA
   MOV    DPTR,#START_ADDRESS_DATA_REG          
   MOV    A,DPL
   CLR    C
   ADD    A,TEMP2
   MOV    DPL,A
   MOV    A,DPH
   ADDC   A,TEMP1
   MOV    DPH,A 
   MOV    A,B   
   MOVX   @DPTR,A
   LCALL  ASCII_TO_HEX
   MOV    B,A
   
   MOV    DPTR,#START_ADDRESS_DATA_REG          
   MOV    A,TEMP2
   CLR    C
   ADD    A,#01
   MOV    TEMP2,A
   MOV    A,TEMP1
   ADDC   A,#0
   MOV    TEMP1,A
   CLR    C
   
   MOV    A,DPL  
   ADD    A,TEMP2
   MOV    DPL,A
   
   MOV    A,DPH
   ADDC   A,TEMP1
   MOV    DPH,A   
   MOV    A,B
   MOVX   @DPTR,A  
    
   MOV    A,TEMP2
   CLR    C
   ADD    A,#01
   MOV    TEMP2,A
   MOV    A,TEMP1
   ADDC   A,#0 
   MOV    TEMP1,A
   
   DJNZ   R5,NEXT_DATA_REG
;-----------------------------------------------   
   TRANSMIT_REPLY_FN_CODE_10H:
   

   MOV   BYTE_CNT,#0
   
   REPEAT_TRANSFER_FROM_RX_TX_FN_CODE_10H:
   
   MOV   R0,#RX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R0
   MOV   R0,A
   MOV   A,@R0
   MOV   B,A
   MOV   R1,#TX_BUF
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,R1
   MOV   R1,A
   MOV   A,B   
   MOV   @R1,A
   MOV   A,BYTE_CNT
   CLR   C
   ADD   A,#01
   MOV   BYTE_CNT,A
   CJNE  A,#13,REPEAT_TRANSFER_FROM_RX_TX_FN_CODE_10H
;------------------------------------   
   MOV   R7,#12    ;MODBUS ASCII CHECK IT SHOULD BE 6
;------------------------------------   
   MOV	R1,#TX_BUF                              ;R0,#TX_BUF            
	INC   R1
	LCALL	CAL_LRC				      ;calculates lrc code for ascii data
	MOV   R7,#13
	LCALL ADD_LRC_ASC   		     
;   SETB  SAVE_SET_DATA
;   MOV   A,#0
;   MOV   START_ADDR_REG,A
;   MOV   SECOND_CLK,A

   LJMP  TRANSMIT_DATA_START  


  

;-----------------------------------------------------------   
;THIS IS THE COMMON PROGRAM FOR START OF REPLY OF EACH QUERY   
;-----------------------------------------------------------   
   
   
   TRANSMIT_DATA_START:
	
	LCALL   RESET_WDT
	LCALL	INIT_XMIT			      				          				      
   MOV   A,#0
   MOV   BYTE_CNT,A
	LCALL TRANS 				
	MOV   COUNT_1S,#0FFH			      						               
   CLR   DELAY_OVER
   RET
;--------------------------------------------------------   
   SERIAL_COMMUNICATION:
   
   JB	    DELAY_OVER,RESET_SERIAL_COMMUNICATION
   JB	    RCVE_OVER,START_TRANSMISSION_OF_REPLY
   JB     TRANS_OVER,RESET_SERIAL_COMMUNICATION   
   RET   
  
   START_TRANSMISSION_OF_REPLY:
   
   
   LCALL  TRANSMIT
   LCALL   RESET_WDT
	RET
   
   
   
   RESET_SERIAL_COMMUNICATION:
   
   
   LCALL   INITALISE_RECEIVE
   LCALL   RESET_WDT
   RET	

   


;---------------------------------------------------------------------------
;THIS PROGRAM CALCULATES THE DPTR START ADDRESS
;---------------------------------------------------------------------------   
   
   CAL_START_ADDRESS:
   
   INC    R0  
   LCALL  ASCII_TO_HEX
   CLR    C
   RLC    A
   MOV    TEMP1,A   
   LCALL  ASCII_TO_HEX
   CLR    C
   RLC    A                 ;MULTIPLY BY 2
   MOV    TEMP2,A
   MOV    A,TEMP1
   ADDC   A,#0
   MOV    TEMP1,A
   RET
;---------------------------------------------------------------
;THIS ROUTINE LOADS THE HEADER & THE SLAVE ID FOR EACH QUERY	
;---------------------------------------------------------------	
	HEADER_SLAVE_ID:
	
	MOV   R1,#TX_BUF                            
   MOV   A,#HEADER
	MOV   @R1,A              ;                            
	INC   R1
;-------------------------------------------------	
   MOV   A,#30H
	MOV   @R1,A  ;SLAVE ADDRESS
	INC   R1
	MOV   A,#31H
	MOV   @R1,A  ;
   RET
  
;-----------------------------------------------------------------------------------------------
;isr for serial interrupt
;-----------------------------------------------------------------------------------------------
	
   ;R0_ADDR     EQU   00H
   
   SERIAL:
	
	
  ; LCALL  RESET_WDT
	JB	   TI,LOOP1_SERIAL
	JB	   RI,RCVE
   
  ; OUT_ISR:
	
	
	RETI
;--------------------------------------
;PROGRAM FOR TRANSMISSION
;--------------------------------------   
   
   LOOP1_SERIAL:
	
	JNB	LAST_BYTE,LOOP2_SERIAL	
	SETB	TRANS_OVER
	CLR   TI
	RETI

   LOOP2_SERIAL:
	
	LCALL	TRANS
	RETI
;-----------------------------------------------
;PROGRAM FOR RECEIVING DATA ON THE SERIAL PORT
;-----------------------------------------------   
   
   RCVE:	
	
	PUSH  PSW
	PUSH  R0_ADDR	
	PUSH  ACC
	MOV   R0,#RX_BUF
	MOV   A,R0
	CLR   C
	ADD   A,BYTE_CNT
	MOV   R0,A
	MOV	A,SBUF				;get data from serial port into a
	MOV	@R0,A				;load data to ram starting from 25h
	INC	R0	
	INC	BYTE_CNT 
	CJNE	A,#END_CHARACTER_2,OUT_RCVE	  ;
	SETB	RCVE_OVER
   
   OUT_RCVE:

	POP   ACC
   POP   R0_ADDR
   POP   PSW
   CLR   RI	
	RETI

;-----------------------------------------------------------------   
;THIS ROUTINE TRANSFER THE DATA FROM TX_BUF TO SERIAL PORT
;-----------------------------------------------------------------  
   
   TRANS:
   
   PUSH  PSW
	PUSH	ACC
	PUSH  R1_ADDR
	
	CLR   TI            
   MOV   R1,#TX_BUF
   CLR   C
   MOV   A,R1
   ADD   A,BYTE_CNT
   MOV   R1,A
   MOV	A,@R1
	MOV	SBUF,A
	INC	R1
   INC   BYTE_CNT
   
   LOOP2_TRANS:

	CJNE	A,#END_CHARACTER_2,OUT_TRANS             

   LOOP3_TRANS:

	SETB	LAST_BYTE

   OUT_TRANS:
   
	POP   R1_ADDR
	POP	ACC
	POP   PSW
	RET


;---------------------------------------------------------------------------------
;data converted into ascii format which is to be xmitted to slave
;is stored from 40h
;storeslrc code  &  crlf at the end
;---------------------------------------------------------------------------------

   ADD_LRC_ASC:


   MOV	R1,#TX_BUF			;starting addr of ram where ascii code is stored
   MOV   A,R1
   ADD   A,R7
   MOV   R1,A
   MOV   A,LRC_HI
   MOV   @R1,A
   INC   R1
   MOV   A,LRC_LO
   MOV   @R1,A
	INC   R1	                           ;store clrc_hi		
   MOV   A,#END_CHARACTER_1
   MOV   @R1,A
   INC   R1
   MOV   A,#END_CHARACTER_2
   MOV   @R1,A	
  	
	RET
		
		
	
;---------------------------------------------------------------------------------
;the byte to be converted is in a
;---------------------------------------------------------------------------------
   conv_asc:
	
	MOV	DPTR,#LUT_RTU_ASC
	MOVC	A,@A+DPTR
   RET

   LUT_RTU_ASC:

	db	30h	;0
	db	31h	;1
	db	32h	;2
	db	33h	;3
	db	34h	;4
	db	35h	;5
	db	36h	;6
	db	37h	;7
	db	38h	;8
	db	39h	;9
	db	41h	;A
	db	42h	;B
	db	43h	;C
	db	44h	;D
	db	45h	;E
	db	46h	;F
;-----------------------------------------------------------------------------------------------	
   INITALISE_RECEIVE:	
	
	CLR    IE.4                                             ;LCALL	DISABLE_SERIAL			     
	CLR	 LAST_BYTE
	CLR	 TRANS_OVER
	CLR    RCVE_OVER
	LCALL  INIT_1         					                       		      
	MOV    A,#0
	MOV    BYTE_CNT,A
	LCALL  INIT_RCVE              			      ;initialises serial reception from master(rtu)
	CLR    DELAY_OVER
	MOV    COUNT_1S,#0FFH              
   RET
;----------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------
;this function calculates lrc code of ascii data received from slave 
;and the data which has to be sent to slave
;-----------------------------------------------------------------------------------------------

   CAL_LRC:
	
	MOV   A,R7
	CLR   C
	RR    A
	MOV   R7,A
	
	MOV	A,#00H

   LOOP1_CALLRC:					;add all data bytes

   MOV   B,A
   MOV   A,@R1	
	LCALL ASCII_TO_HEX_LRC
	CLR   C
	ADD	A,B
;	INC	DPTR	
	DJNZ	R7,LOOP1_CALLRC	
	CPL	A				
	INC	A				
	MOV	LRC_CODE,A			
	MOV	TEMP,LRC_CODE			
	ANL	A,#0F0H				
	SWAP	A				
	LCALL	CONV_ASC			
	MOV	LRC_HI,A			
	MOV	A,TEMP				
	ANL	A,#0FH 			
	LCALL CONV_ASC						
   MOV	LRC_LO,A			
	
	RET

;****************************************************************************
;INPUTS R0 -> LOCATION CONTAINING ASCII CHARACTERS HIGHER BYTE FIRST, LOWER BYTE NEXT
;OUTPUT A = ASSEMBLED HEX CHARACTER
;USES R2,A
;****************************************************************************
   ASCII_TO_HEX:   
   
   MOV     A,@R0
	CLR     C
	SUBB    A,#30H
	CJNE    A,#10,A_T_H_1
   
   A_T_H_1:        
   
   JC      A_T_H_2
	SUBB    A,#7
   
   A_T_H_2:        
   
   SWAP    A
	MOV     R2,A
	INC     R0
	MOV     A,@R0
	INC     R0
	CLR     C
	SUBB    A,#30H
	CJNE    A,#10,A_T_H_3
   
   A_T_H_3:        
   
   JC      A_T_H_4
	SUBB    A,#7
   
   A_T_H_4:        
   
   ORL     A,R2
	RET
;****************************************************************************
   ASCII_TO_HEX_LRC:

   
   MOV     A,@R1
	CLR     C
	SUBB    A,#30H
	CJNE    A,#10,A_T_H_1_LRC
   
   A_T_H_1_LRC:        
   
   JC      A_T_H_2_LRC
	SUBB    A,#7
   
   A_T_H_2_LRC:        
   
   SWAP    A
	MOV     R2,A
	INC     R1
	MOV     A,@R1
	INC     R1
	CLR     C
	SUBB    A,#30H
	CJNE    A,#10,A_T_H_3_LRC
   
   A_T_H_3_LRC:        
   
   JC      A_T_H_4_LRC
	SUBB    A,#7
   
   A_T_H_4_LRC:        
   
   ORL     A,R2
	RET








;****************************************************************************
;INPUTS A = HEX DATA R1 -> LOCATION IN TX_BUF TO STORE ASCII DATA
;****************************************************************************
   HEX_TO_ASCII:   
   
   PUSH    ACC
	ANL     A,#0F0H
	SWAP    A
	ADD     A,#30H
	CJNE    A,#3AH,H_T_A_1
   
   H_T_A_1:        
   
   JC      H_T_A_2
	ADD     A,#7
   
   H_T_A_2:        
   
   MOV     @R1,A
	INC     R1
	POP     ACC
	ANL     A,#0FH
	ADD     A,#30H
	CJNE    A,#3AH,H_T_A_3
   
   H_T_A_3:        
   
   JC      H_T_A_4
	ADD     A,#7
   
   H_T_A_4:        
   
   MOV     @R1,A
	INC     R1
	RET     
;****************************************************************************
  HEX_TO_ASCII_R0:
   
   PUSH    ACC
	ANL     A,#0F0H
	SWAP    A
	ADD     A,#30H
	CJNE    A,#3AH,H_T_A_1_R0
   
   H_T_A_1_R0:        
   
   JC      H_T_A_2_R0
	ADD     A,#7
   
   H_T_A_2_R0:        
   
   MOV     @R1,A
	INC     R1
	POP     ACC
	ANL     A,#0FH
	ADD     A,#30H
	CJNE    A,#3AH,H_T_A_3_R0
   
   H_T_A_3_R0:        
   
   JC      H_T_A_4_R0
	ADD     A,#7
   
   H_T_A_4_R0:        
   
   MOV     @R1,A
	INC     R1
	RET     


;***************************************************************************
;THIS ROUTINE DIVIDES ONE 16 BIT NUMBER BY ANOTHER
;R7  = LOOP COUNT
;RSLT_0 = LSB OF DIVIDEND/QUOTIENT    
;RSLT_1 = MSB OF DIVIDEND/QUOTIENT
;R2 = LSB OF DIVISOR
;R3 = MSB OF DIVISOR
;R4 = LSB OF REMAINDER
;R5 = MSB OF REMAINDER
;TEMP_0 = TEMP. (LSB OF REMAINDER)
;TEMP_1 = TEMP. (MSB OF REMAINDER)
;***************************************************************************
DIV_16BIT:	CLR	C
	MOV	R7,#16
	MOV	R4,#0
	MOV	R5,#0
ADIVLOOP:	MOV	A,RSLT_0
	RLC	A
	MOV	RSLT_0,A
	MOV	A,RSLT_1
	RLC	A
	MOV	RSLT_1,A
	MOV	A,R4
	RLC	A
	MOV	R4,A
	MOV	TEMP1,A
	MOV	A,R5
	RLC	A
	MOV	R5,A
	MOV	TEMP2,A
	MOV	A,R4
	SUBB	A,R2
	MOV	R4,A
	MOV	A,R5
	SUBB	A,R3
	MOV	R5,A	
	CPL	C
	JC	ADROP
	MOV	A,TEMP1
	MOV	R4,A
	MOV	A,TEMP2
	MOV	R5,A
ADROP:	DJNZ	R7,ADIVLOOP
	MOV	A,RSLT_0
	RLC	A
	MOV	RSLT_0,A
	MOV	A,RSLT_1
	RLC	A
	MOV	RSLT_1,A
	RET
;******************************************************************************
;COMPARE:	THIS ROUTINE COMPARES TWO NUBER STORED IN LOCATION <R3><R2> AND 
;	<R5><R4> RESULT OF COPARISON IS GIVEN THROUGH RELAY.
;	RLY43 IS SET IF <R3><R2> < <R5><R4> 
;	RLY44 IS SET IF <R3><R2> = <R5><R4> 
;	RLY45 IS SET IF <R3><R2> > <R5><R4> 
;REGISTER USED: A,PSW
NUM1L			EQU	04	
NUM1H			EQU	05
NUM2L			EQU	02
NUM2H			EQU	03
;*****************************************************************************
      
   COMPARE:	
   
   CLR	RLY33
	CLR	RLY34	
	CLR	RLY35
	MOV	A,R2
	CLR	C
	SUBB	A,R4
	MOV	R6,A
	MOV	A,R3
	SUBB	A,R5
	JNC	NOT_LESS
	SETB	RLY33
	RET
   
   NOT_LESS:	
   
   ORL	A,R6
	JNZ	NOT_EQUAL
	SETB	RLY34
	RET
   
   NOT_EQUAL:	
   
   SETB	RLY35
	RET	



;-----------------------------------------------------

;----------------------------------------------------------   
        MULTIPLICATION:	
        
	MOV	B,#22     ;16
	CLR	A
	MOV	R7,A
	MOV	R6,A
	MOV	R5,A
	MOV	R4,A
	CLR	C
   
   CONT_MUL_32:	
   
   MOV	A,R2
	RLC	A
	MOV	R2,A
	MOV	A,R3
	RLC	A
	MOV	R3,A
	JNC	ZERO_BIT_32
	MOV	A,R4
	ADD	A,R0
	MOV	R4,A
	MOV	A,R5
	ADDC	A,R1
	MOV	R5,A
	MOV	A,R6
	ADDC	A,#0
	MOV	R6,A
	MOV	A,R7
	ADDC	A,#0
	MOV	R7,A
	JC	   MUL_OV_32
   
   ZERO_BIT_32:	
   
   DJNZ	B,MOV_RES_LEFT
	CLR	C
   
   MUL_OV_32:	
   
   RET
	
   MOV_RES_LEFT:	
   
   CLR	C
	MOV	A,R4
	RLC	A
	MOV	R4,A
	MOV	A,R5
	RLC	A
	MOV	R5,A
	MOV	A,R6
	RLC	A
	MOV	R6,A
	MOV	A,R7
	RLC	A
	MOV	R7,A
	SJMP	CONT_MUL_32  
;**************************************************************************   
;THIS IS SCALE DATA THE 2 16 BIT NOS ARE MULTIPLIED & DIVIDED BY 1024	
;MULTIPLIES A 16 BIT NUMBER WITH A 16 BIT NUMBER
;MULTIPLICAND -> R1..R0
;MULTIPLIER   -> R3..R2
;RESULT       -> R7....R4
;***********************************************************************

        SCALE_1024:
   	
	MOV	B,#22
	CLR	A
	MOV	R7,A
	MOV	R6,A
	MOV	R5,A
	MOV	R4,A
	CLR	C
   
        CONT_MUL_32_SCALE1024:	
   
        MOV	A,R2
	RLC	A
	MOV	R2,A
	MOV	A,R3
	RLC	A
	MOV	R3,A
	JNC	ZERO_BIT_32_SCALE1024
	MOV	A,R4
	ADD	A,R0
	MOV	R4,A
	MOV	A,R5
	ADDC	A,R1
	MOV	R5,A
	MOV	A,R6
	ADDC	A,#0
	MOV	R6,A
	MOV	A,R7
	ADDC	A,#0
	MOV	R7,A
	JC	   MUL_OV_32_SCALE1024
   
   ZERO_BIT_32_SCALE1024:	
   
   DJNZ	B,MOV_RES_LEFT_SCALE1024
	CLR	C
   
   MUL_OV_32_SCALE1024:	
   
   RET
	
   MOV_RES_LEFT_SCALE1024:	
   
   CLR	C
	MOV	A,R4
	RLC	A
	MOV	R4,A
	MOV	A,R5
	RLC	A
	MOV	R5,A
	MOV	A,R6
	RLC	A
	MOV	R6,A
	MOV	A,R7
	RLC	A
	MOV	R7,A
	SJMP	CONT_MUL_32_SCALE1024
;----------------------------------------------------
;        DELAY_IO_READ:
;
;        MOV    R7,#0FH
;
;        DELAY_IO_1:
;        
;        NOP
;        NOP
;        DJNZ   R7,DELAY_IO_1
;-----------------------------------------------------
   SEPERATE_OP_DATA_IN_BYTES:

   MOV   BIT_COUNTER,A
   MOV   TEMP_BIT,C
   MOV   A,BIT_COUNTER
   MOV   R3,A
   CLR   C
   SUBB  A,#08
   JC    LOAD_1ST_BYTE
   CLR   C
   MOV   R3,A
   SUBB  A,#08
   JC    LOAD_2ND_BYTE
   MOV   R3,A
   MOV   R2,DATA_OP_3
   LCALL LOAD_BIT
   MOV   DATA_OP_3,A
   RET

   LOAD_1ST_BYTE:

   MOV   R2,DATA_OP_1
   LCALL LOAD_BIT
   MOV   DATA_OP_1,A
   RET

   LOAD_2ND_BYTE:

   MOV   R2,DATA_OP_2
   LCALL LOAD_BIT
   MOV   DATA_OP_2,A
   RET

   LOAD_3RD_BYTE:

   MOV   R2,DATA_OP_3
   LCALL LOAD_BIT
   MOV   DATA_OP_3,A
   RET
;------------------------------------------

   LOAD_BIT:

   CJNE   R3,#0,CHECK_BIT1
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.0,C
   RET

   CHECK_BIT1:

   CJNE   R3,#1,CHECK_BIT2
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.1,C
   RET 

   CHECK_BIT2:

   CJNE   R3,#2,CHECK_BIT3
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.2,C
   RET  

   CHECK_BIT3:

   CJNE   R3,#3,CHECK_BIT4
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.3,C
   RET 

   CHECK_BIT4:

   CJNE   R3,#4,CHECK_BIT5
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.4,C
   RET   

   CHECK_BIT5:

   CJNE   R3,#5,CHECK_BIT6
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.5,C
   RET

   CHECK_BIT6:

   CJNE   R3,#6,CHECK_BIT7
   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.6,C
   RET  

   CHECK_BIT7:

   MOV    A,R2
   MOV    C,TEMP_BIT
   MOV    ACC.7,C

   RET
;-----------------------------------------------  
        READ_INPUTS:

        MOV    A,IP_DEBOUNCE
   CLR    C
   SUBB   A,#10
   JC    MY_SCAN
   LJMP   NOT_MY_SCAN


   MY_SCAN:
   
   MOV    IP_DEBOUNCE,#0

   CLR   P3.2
   SETB  P3.4
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   MOV   A,P1
   CPL   A
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   
   SETB  P3.2
   SETB  P3.4
	
	MOV	CUR_DC_INPUT,A
        XRL	A,PREV_DCINP0	;ONLY THOSE LOCATION WHITCH ARE
        MOV     R5,A
        
        MOV     A,DC_INPUT0
        MOV     DC_INPUT_TEMP,A
        LCALL   COMPILE_INPUTS

        MOV     A,DC_INPUT_TEMP
	MOV     DC_INPUT0,A

	MOV     A,CUR_DC_INPUT
	MOV     PREV_DCINP0,A
;---------------------------------------	
        MOV    DPTR,#INPUT_ADDRESS	
	MOVX    A,@DPTR
	CPL	A
	MOV	CUR_DC_INPUT,A
        XRL	A,PREV_DCINP1	;ONLY THOSE LOCATION WHITCH ARE
        MOV     R5,A
        
        MOV     A,DC_INPUT1;DC_INPUT3
        MOV     DC_INPUT_TEMP,A
        LCALL   COMPILE_INPUTS

        MOV     A,DC_INPUT_TEMP
	MOV     DC_INPUT1,A

	MOV     A,CUR_DC_INPUT
	MOV     PREV_DCINP1,A
;--------------------------------------------
        INC     DPTR
	MOVX    A,@DPTR
	CPL	A
	MOV	CUR_DC_INPUT,A
        XRL	A,PREV_DCINP2	
        MOV     R5,A
        
        MOV     A,DC_INPUT2
        MOV     DC_INPUT_TEMP,A
        LCALL   COMPILE_INPUTS

        MOV     A,DC_INPUT_TEMP
	MOV     DC_INPUT2,A

	MOV     A,CUR_DC_INPUT
	MOV     PREV_DCINP2,A	
;----------------------------------------
        INC     DPTR
	MOVX    A,@DPTR
	CPL	A
	MOV	CUR_DC_INPUT,A
        XRL	A,PREV_DCINP3	
        MOV     R5,A
        
        MOV     A,DC_INPUT3
        MOV     DC_INPUT_TEMP,A
        LCALL   COMPILE_INPUTS

        MOV     A,DC_INPUT_TEMP
	MOV     DC_INPUT3,A

	MOV     A,CUR_DC_INPUT
	MOV     PREV_DCINP3,A	
;--------------------------------------------------------

   MOV   DPTR,#BIT_START_ADDRESS_INPUT
   MOV   A,DC_INPUT0
   MOVX  @DPTR,A

   MOV   A,DC_INPUT1
   INC   DPTR
   MOVX  @DPTR,A

   MOV   A,DC_INPUT2
   INC   DPTR
   MOVX  @DPTR,A

   MOV   A,DC_INPUT3
   INC   DPTR
   MOVX  @DPTR,A

;   MOV   A,DC_INPUT4
;   INC   DPTR
;   MOVX  @DPTR,A

   NOT_MY_SCAN:
;-----------------------------------------------------------
       COMPILE_INPUTS:

    MOV   A,R5
    JNB   ACC.0,NO_CHANGE_BIT0
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.0
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.0,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT1

    NO_CHANGE_BIT0:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.0
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.0,C
    MOV   DC_INPUT_TEMP,A
;-----------------    
    BIT1:

    MOV   A,R5
    JNB   ACC.1,NO_CHANGE_BIT1
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.1
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.1,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT2

    NO_CHANGE_BIT1:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.1
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.1,C
    MOV   DC_INPUT_TEMP,A
;-------------------------
    BIT2:

    MOV   A,R5
    JNB   ACC.2,NO_CHANGE_BIT2
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.2
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.2,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT3

    NO_CHANGE_BIT2:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.2
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.2,C
    MOV   DC_INPUT_TEMP,A
;--------------------
    BIT3:

    MOV   A,R5
    JNB   ACC.3,NO_CHANGE_BIT3
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.3
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.3,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT4

    NO_CHANGE_BIT3:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.3
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.3,C
    MOV   DC_INPUT_TEMP,A    
;---------------------------
    BIT4:

    MOV   A,R5
    JNB   ACC.4,NO_CHANGE_BIT4
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.4
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.4,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT5

    NO_CHANGE_BIT4:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.4
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.4,C
    MOV   DC_INPUT_TEMP,A    
;--------------------------
    BIT5:

    MOV   A,R5
    JNB   ACC.5,NO_CHANGE_BIT5
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.5
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.5,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT6

    NO_CHANGE_BIT5:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.5
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.5,C
    MOV   DC_INPUT_TEMP,A 
;-------------------------------------------------       
    BIT6:

    MOV   A,R5
    JNB   ACC.6,NO_CHANGE_BIT6
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.6
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.6,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT7

    NO_CHANGE_BIT6:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.6
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.6,C
    MOV   DC_INPUT_TEMP,A 
;-----------------------------
    BIT7:

    MOV   A,R5
    JNB   ACC.7,NO_CHANGE_BIT7
    MOV   A,DC_INPUT_TEMP
    MOV   C,ACC.7
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.7,C
    MOV   DC_INPUT_TEMP,A
    SJMP  BIT8

    NO_CHANGE_BIT7:

    MOV   A,CUR_DC_INPUT
    MOV   C,ACC.7
    MOV   A,DC_INPUT_TEMP
    MOV   ACC.7,C
    MOV   DC_INPUT_TEMP,A 

    BIT8:

    RET
;--------------------------------------
   LOAD_OUTPUT:

   JB    B_FIRST_CYCLE,LOAD_OPS
   CLR   A
   SETB  P3.5
   SJMP  DONT_LOAD_OPS
   
   LOAD_OPS:
   
   CLR    P3.5   

;   MOV    DPTR,#RLY592_599
;   MOVX   A,@DPTR
   JB     OUTPUT_TEST_51,LOAD_FORCE_OUTPUT
   LJMP   REGULAR_OP 

   LOAD_FORCE_OUTPUT:

 ;  CLR    PREFORM_FEEDER_LOADER_OP00
   MOV    A,OUT0_7               ;OP01_08
   MOV    P1,A
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP 
   CLR    P3.4
   SETB   P3.2
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   SETB   P3.2
   SETB   P3.4 
   MOV    P1,#0FFH   ;INPUT 5,6,7 STATUS PROBLEM SOLVED
;----------------------------------------------    
   MOV    A,OUT8_15             ;OP8_15
   MOV    DPTR,#OUTPUT_ADDRESS+0
   MOVX   @DPTR,A

   MOV    A,OUT16_23            ;OP8_15  
   MOV    DPTR,#OUTPUT_ADDRESS+1
   MOVX   @DPTR,A   

   MOV    A,OUT24_31
   MOV    DPTR,#OUTPUT_ADDRESS+2
   MOVX   @DPTR,A   

   DONT_LOAD_OPS:

   RET  

   REGULAR_OP:

   MOV    A,OUT0_7               ;OP01_08
   MOV    P1,A
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP 
   CLR    P3.4
   SETB   P3.2
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   SETB   P3.2
   SETB   P3.4 
   MOV    P1,#0FFH   ;INPUT 5,6,7 STATUS PROBLEM SOLVED
;----------------------------------------------    
   MOV    A,OUT8_15             ;OP8_15
   MOV    DPTR,#OUTPUT_ADDRESS+0
   MOVX   @DPTR,A

   MOV    A,OUT16_23            ;OP8_15  
   MOV    DPTR,#OUTPUT_ADDRESS+1
   MOVX   @DPTR,A   

   MOV    A,OUT24_31
   MOV    DPTR,#OUTPUT_ADDRESS+2
   MOVX   @DPTR,A   

   RET 
;--------------------------------------------------------------
   TMR_HANDLER:
   
    
   MOV   A,TIMECT
   CLR   C
   CLR   TEN_MSEC_BIT
   SUBB  A,#10
   JC    NOT_10MSEC
   
   SETB  TEN_MSEC_BIT
   CLR   C
   MOV   TIMECT,#0               
   
   NOT_10MSEC:
;-----------------------------------------
   MOV   A,SECOND_CLK                              
   CLR   C
   CLR   HUND_MSEC_BIT
   CJNE  A,#100,TIME_LESS_HUND_MILLISEC
   
   TIME_LESS_HUND_MILLISEC:
   
   JC    NOT_100MSEC
   SETB  HUND_MSEC_BIT
   CLR   C
   MOV   SECOND_CLK,#0              
   
   NOT_100MSEC:
;--------------------------------------------------------------------------
   TM00_HANDLER:
   
   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   JNB	 TM00E,TMR00_NOT_ENABLED
   JB	 TM00D,TM00_END
   
   MOV   DPTR,#TMS00L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC00L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS00H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC00H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR00_DONE
   
   JNB   TEN_MSEC_BIT,TM00_END

   MOV   DPTR,#TMC00L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC00H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM00_END   	


   SET_TMR00_DONE:	
   
   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   SETB	 TM00D
   MOVX  @DPTR,A

   SJMP	 TM00_END	
   
   TMR00_NOT_ENABLED:
	
   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   CLR	 TM00D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC00H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM00_END:

;---------------------------------------------
    TM01_HANDLER:
   
   MOV   DPTR,#TM01_ENABLE
   MOVX  A,@DPTR
   JNB	 TM01E,TMR01_NOT_ENABLED
   JB	 TM01D,TM01_END
   
   MOV   DPTR,#TMS01L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC01L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS01H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC01H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR01_DONE
   
   JNB   TEN_MSEC_BIT,TM01_END

   MOV   DPTR,#TMC01L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC01H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM01_END   	


   SET_TMR01_DONE:	
   
   MOV   DPTR,#TM01_ENABLE
   MOVX  A,@DPTR
   SETB	 TM01D
   MOVX  @DPTR,A

   SJMP	 TM01_END	
   
   TMR01_NOT_ENABLED:
	
   MOV   DPTR,#TM01_ENABLE
   MOVX  A,@DPTR
   CLR	 TM01D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC01H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM01_END:
   
;---------------------------------------------
   TM02_HANDLER:
   
   MOV   DPTR,#TM02_ENABLE
   MOVX  A,@DPTR
   JNB	 TM02E,TMR02_NOT_ENABLED
   JB	 TM02D,TM02_END
   
   MOV   DPTR,#TMS02L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC02L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS02H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC02H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR02_DONE
   
   JNB   TEN_MSEC_BIT,TM02_END

   MOV   DPTR,#TMC02L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC02H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM02_END   	


   SET_TMR02_DONE:	
   
   MOV   DPTR,#TM02_ENABLE
   MOVX  A,@DPTR
   SETB	 TM02D
   MOVX  @DPTR,A

   SJMP	 TM02_END	
   
   TMR02_NOT_ENABLED:
	
   MOV   DPTR,#TM02_ENABLE
   MOVX  A,@DPTR
   CLR	 TM02D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC02H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM02_END:
;---------------------------------------------
   TM03_HANDLER:
   
   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR
   JNB	 TM03E,TMR03_NOT_ENABLED
   JB	 TM03D,TM03_END
   
   MOV   DPTR,#TMS03L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC03L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS03H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC03H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR03_DONE
   
   JNB   TEN_MSEC_BIT,TM03_END

   MOV   DPTR,#TMC03L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC03H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM03_END   	


   SET_TMR03_DONE:	
   
   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR
   SETB	 TM03D
   MOVX  @DPTR,A

   SJMP	 TM03_END	
   
   TMR03_NOT_ENABLED:
	
   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR
   CLR	 TM03D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC03H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM03_END:
;---------------------------------------------
   TM04_HANDLER:
   
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   JNB	 TM04E,TMR04_NOT_ENABLED
   JB	 TM04D,TM04_END
   
   MOV   DPTR,#TMS04L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC04L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS04H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC04H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR04_DONE
   
   JNB   TEN_MSEC_BIT,TM04_END

   MOV   DPTR,#TMC04L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC04H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM04_END   	


   SET_TMR04_DONE:	
   
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   SETB	 TM04D
   MOVX  @DPTR,A

   SJMP	 TM04_END	
   
   TMR04_NOT_ENABLED:
	
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   CLR	 TM04D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC04H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM04_END:
;---------------------------------------------
   TM05_HANDLER:
   
   MOV   DPTR,#TM05_ENABLE
   MOVX  A,@DPTR
   JNB	 TM05E,TMR05_NOT_ENABLED
   JB	 TM05D,TM05_END
   
   MOV   DPTR,#TMS05L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC05L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS05H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC05H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR05_DONE
   
   JNB   TEN_MSEC_BIT,TM05_END

   MOV   DPTR,#TMC05L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC05H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM05_END   	


   SET_TMR05_DONE:	
   
   MOV   DPTR,#TM05_ENABLE
   MOVX  A,@DPTR
   SETB	 TM05D
   MOVX  @DPTR,A

   SJMP	 TM05_END	
   
   TMR05_NOT_ENABLED:
	
   MOV   DPTR,#TM05_ENABLE
   MOVX  A,@DPTR
   CLR	 TM05D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC05H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM05_END:
;---------------------------------------------
   TM06_HANDLER:
   
   MOV   DPTR,#TM06_ENABLE
   MOVX  A,@DPTR
   JNB	 TM06E,TMR06_NOT_ENABLED
   JB	 TM06D,TM06_END
   
   MOV   DPTR,#TMS06L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC06L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS06H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC06H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR06_DONE
   
   JNB   TEN_MSEC_BIT,TM06_END

   MOV   DPTR,#TMC06L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC06H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM06_END   	


   SET_TMR06_DONE:	
   
   MOV   DPTR,#TM06_ENABLE
   MOVX  A,@DPTR
   SETB	 TM06D
   MOVX  @DPTR,A

   SJMP	 TM06_END	
   
   TMR06_NOT_ENABLED:
	
   MOV   DPTR,#TM06_ENABLE
   MOVX  A,@DPTR
   CLR	 TM06D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC06H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM06_END:
;---------------------------------------------
   TM07_HANDLER:
   
   MOV   DPTR,#TM07_ENABLE
   MOVX  A,@DPTR
   JNB	 TM07E,TMR07_NOT_ENABLED
   JB	 TM07D,TM07_END
   
   MOV   DPTR,#TMS07L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC07L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS07H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC07H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR07_DONE
   
   JNB   TEN_MSEC_BIT,TM07_END

   MOV   DPTR,#TMC07L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC07H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM07_END   	


   SET_TMR07_DONE:	
   
   MOV   DPTR,#TM07_ENABLE
   MOVX  A,@DPTR
   SETB	 TM07D
   MOVX  @DPTR,A

   SJMP	 TM07_END	
   
   TMR07_NOT_ENABLED:
	
   MOV   DPTR,#TM07_ENABLE
   MOVX  A,@DPTR
   CLR	 TM07D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC07H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM07_END:
;---------------------------------------------
   TM08_HANDLER:
   
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR
   JNB	 TM08E,TMR08_NOT_ENABLED
   JB	 TM08D,TM08_END
   
   MOV   DPTR,#TMS08L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC08L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS08H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC08H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR08_DONE
   
   JNB   TEN_MSEC_BIT,TM08_END

   MOV   DPTR,#TMC08L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC08H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM08_END   	


   SET_TMR08_DONE:	
   
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR
   SETB	 TM08D
   MOVX  @DPTR,A

   SJMP	 TM08_END	
   
   TMR08_NOT_ENABLED:
	
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR
   CLR	 TM08D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC08H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM08_END:
;---------------------------------------------
  TM09_HANDLER:
   
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   JNB	 TM09E,TMR09_NOT_ENABLED
   JB	 TM09D,TM09_END
   
   MOV   DPTR,#TMS09L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC09L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS09H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC09H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR09_DONE
   
   JNB   TEN_MSEC_BIT,TM09_END

   MOV   DPTR,#TMC09L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC09H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM09_END   	


   SET_TMR09_DONE:	
   
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   SETB	 TM09D
   MOVX  @DPTR,A

   SJMP	 TM09_END	
   
   TMR09_NOT_ENABLED:
	
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   CLR	 TM09D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC09H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM09_END:
;----------------------------------------------
   TM10_HANDLER:
   
   MOV   DPTR,#TM10_ENABLE
   MOVX  A,@DPTR
   JNB	 TM10E,TMR10_NOT_ENABLED
    JB	 TM10D,TM10_END
   
   MOV   DPTR,#TMS10L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC10L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS10H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC10H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR10_DONE
   
   JNB   TEN_MSEC_BIT,TM10_END

   MOV   DPTR,#TMC10L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC10H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM10_END   	


   SET_TMR10_DONE:	
   
   MOV   DPTR,#TM10_ENABLE
   MOVX  A,@DPTR
   SETB	 TM10D
   MOVX  @DPTR,A

   SJMP	 TM10_END	
   
   TMR10_NOT_ENABLED:
	
   MOV   DPTR,#TM10_ENABLE
   MOVX  A,@DPTR
   CLR	 TM10D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC10H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM10_END:
;----------------------------------------------
    TM11_HANDLER:
   
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   JNB	 TM11E,TMR11_NOT_ENABLED
   JB	 TM11D,TM11_END
   
   MOV   DPTR,#TMS11L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC11L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS11H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC11H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR11_DONE
   
   JNB   TEN_MSEC_BIT,TM11_END

   MOV   DPTR,#TMC11L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC11H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM11_END   	


   SET_TMR11_DONE:	
   
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   SETB	 TM11D
   MOVX  @DPTR,A

   SJMP	 TM11_END	
   
   TMR11_NOT_ENABLED:
	
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   CLR	 TM11D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC11H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM11_END:
;----------------------------------------------
   TM12_HANDLER:
   
   MOV   DPTR,#TM12_ENABLE
   MOVX  A,@DPTR
   JNB	 TM12E,TMR12_NOT_ENABLED
   JB	 TM12D,TM12_END
   
   MOV   DPTR,#TMS12L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC12L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS12H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC12H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR12_DONE
   
   JNB   TEN_MSEC_BIT,TM12_END

   MOV   DPTR,#TMC12L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC12H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM12_END   	


   SET_TMR12_DONE:	
   
   MOV   DPTR,#TM12_ENABLE
   MOVX  A,@DPTR
   SETB	 TM12D
   MOVX  @DPTR,A

   SJMP	 TM12_END	
   
   TMR12_NOT_ENABLED:
	
   MOV   DPTR,#TM12_ENABLE
   MOVX  A,@DPTR
   CLR	 TM12D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC12H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM12_END:
;----------------------------------------------
         TM13_HANDLER:
   
   MOV   DPTR,#TM13_ENABLE
   MOVX  A,@DPTR
   JNB	 TM13E,TMR13_NOT_ENABLED
   JB	 TM13D,TM13_END
   
   MOV   DPTR,#TMS13L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC13L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS13H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC13H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR13_DONE
   
   JNB   TEN_MSEC_BIT,TM13_END

   MOV   DPTR,#TMC13L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC13H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM13_END   	

   SET_TMR13_DONE:	
   
   MOV   DPTR,#TM13_ENABLE
   MOVX  A,@DPTR
   SETB	 TM13D
   MOVX  @DPTR,A

   SJMP	 TM13_END	
   
   TMR13_NOT_ENABLED:
	
   MOV   DPTR,#TM13_ENABLE
   MOVX  A,@DPTR
   CLR	 TM13D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC13H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM13_END:

;----------------------------------------------
         TM14_HANDLER:
   
   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   JNB	 TM14E,TMR14_NOT_ENABLED
   JB	 TM14D,TM14_END
   
   MOV   DPTR,#TMS14L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC14L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS14H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC14H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR14_DONE
   
   JNB   TEN_MSEC_BIT,TM14_END

   MOV   DPTR,#TMC14L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC14H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM14_END   	


   SET_TMR14_DONE:	
   
   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   SETB	 TM14D
   MOVX  @DPTR,A

   SJMP	 TM14_END	
   
   TMR14_NOT_ENABLED:
	
   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   CLR	 TM14D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC14H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM14_END:

;----------------------------------------------
        TM15_HANDLER:
   
   MOV   DPTR,#TM15_ENABLE
   MOVX  A,@DPTR
   JNB	 TM15E,TMR15_NOT_ENABLED
   JB	 TM15D,TM15_END
   
   MOV   DPTR,#TMS15L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC15L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS15H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC15H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR15_DONE
   
   JNB   TEN_MSEC_BIT,TM15_END

   MOV   DPTR,#TMC15L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC15H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM15_END   	


   SET_TMR15_DONE:	
   
   MOV   DPTR,#TM15_ENABLE
   MOVX  A,@DPTR
   SETB	 TM15D
   MOVX  @DPTR,A

   SJMP	 TM15_END	
   
   TMR15_NOT_ENABLED:
	
   MOV   DPTR,#TM15_ENABLE
   MOVX  A,@DPTR
   CLR	 TM15D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC15H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM15_END:

;----------------------------------------------
   TM16_HANDLER:
   
   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   JNB	 TM16E,TMR16_NOT_ENABLED
   JNB   TEN_MSEC_BIT,TM16_END

   MOV   DPTR,#TMC16L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC16H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM16_END   	

  TMR16_NOT_ENABLED:
	
   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   CLR	 TM16D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC16H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM16_END:
;----------------------------------------------
    TM17_HANDLER:
   
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   JNB	 TM17E,TMR17_NOT_ENABLED
   JB	 TM17D,TM17_END
   
   MOV   DPTR,#TMS17L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC17L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS17H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC17H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR17_DONE
   
   JNB   TEN_MSEC_BIT,TM17_END

   MOV   DPTR,#TMC17L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC17H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM17_END   	


   SET_TMR17_DONE:	
   
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   SETB	 TM17D
   MOVX  @DPTR,A

   SJMP	 TM17_END	
   
   TMR17_NOT_ENABLED:
	
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   CLR	 TM17D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC17H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM17_END:
;----------------------------------------------
         TM18_HANDLER:
   
   MOV   DPTR,#TM18_ENABLE
   MOVX  A,@DPTR
   JNB	 TM18E,TMR18_NOT_ENABLED
   JB	 TM18D,TM18_END
   
   MOV   DPTR,#TMS18L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC18L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS18H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC18H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR18_DONE
   
   JNB   TEN_MSEC_BIT,TM18_END

   MOV   DPTR,#TMC18L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC18H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM18_END   	


   SET_TMR18_DONE:	
   
   MOV   DPTR,#TM18_ENABLE
   MOVX  A,@DPTR
   SETB	 TM18D
   MOVX  @DPTR,A

   SJMP	 TM18_END	
   
   TMR18_NOT_ENABLED:
	
   MOV   DPTR,#TM18_ENABLE
   MOVX  A,@DPTR
   CLR	 TM18D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC18H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM18_END:

;-----------------------------------------------
        TM19_HANDLER:
   
   MOV   DPTR,#TM19_ENABLE
   MOVX  A,@DPTR
   JNB	 TM19E,TMR19_NOT_ENABLED
   JB	 TM19D,TM19_END
   
   MOV   DPTR,#TMS19L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC19L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS19H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC19H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR19_DONE
   
   JNB   TEN_MSEC_BIT,TM19_END

   MOV   DPTR,#TMC19L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC19H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM19_END   	


   SET_TMR19_DONE:	
   
   MOV   DPTR,#TM19_ENABLE
   MOVX  A,@DPTR
   SETB	 TM19D
   MOVX  @DPTR,A

   SJMP	 TM19_END	
   
   TMR19_NOT_ENABLED:
	
   MOV   DPTR,#TM19_ENABLE
   MOVX  A,@DPTR
   CLR	 TM19D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC19H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM19_END:

;----------------------------------------------
   TM20_HANDLER:
   
   MOV   DPTR,#TM20_ENABLE
   MOVX  A,@DPTR
   JNB	 TM20E,TMR20_NOT_ENABLED
   JB	 TM20D,TM20_END
   
   MOV   DPTR,#TMS20L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC20L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS20H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC20H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR20_DONE
   
   JNB   TEN_MSEC_BIT,TM20_END

   MOV   DPTR,#TMC20L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC20H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM20_END   	


   SET_TMR20_DONE:	
   
   MOV   DPTR,#TM20_ENABLE
   MOVX  A,@DPTR
   SETB	 TM20D
   MOVX  @DPTR,A

   SJMP	 TM20_END	
   
   TMR20_NOT_ENABLED:
	
   MOV   DPTR,#TM20_ENABLE
   MOVX  A,@DPTR
   CLR	 TM20D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC20H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM20_END:
;----------------------------------------------
   TM21_HANDLER:
   
   MOV   DPTR,#TM21_ENABLE
   MOVX  A,@DPTR
   JNB	 TM21E,TMR21_NOT_ENABLED
   JB	 TM21D,TM21_END
   
   MOV   DPTR,#TMS21L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC21L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS21H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC21H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR21_DONE
   
   JNB   TEN_MSEC_BIT,TM21_END

   MOV   DPTR,#TMC21L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC21H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM21_END   	


   SET_TMR21_DONE:	
   
   MOV   DPTR,#TM21_ENABLE
   MOVX  A,@DPTR
   SETB	 TM21D
   MOVX  @DPTR,A

   SJMP	 TM21_END	
   
   TMR21_NOT_ENABLED:
	
   MOV   DPTR,#TM21_ENABLE
   MOVX  A,@DPTR
   CLR	 TM21D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC21H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM21_END:
;---------------------------------------------   
   TM22_HANDLER:
   
   MOV   DPTR,#TM22_ENABLE
   MOVX  A,@DPTR
   JNB	 TM22E,TMR22_NOT_ENABLED
   JB	 TM22D,TM22_END
   
   MOV   DPTR,#TMS22L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC22L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS22H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC22H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR22_DONE
   
   JNB   TEN_MSEC_BIT,TM22_END

   MOV   DPTR,#TMC22L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC22H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM22_END   	


   SET_TMR22_DONE:	
   
   MOV   DPTR,#TM22_ENABLE
   MOVX  A,@DPTR
   SETB	 TM22D
   MOVX  @DPTR,A

   SJMP	 TM22_END	
   
   TMR22_NOT_ENABLED:
	
   MOV   DPTR,#TM22_ENABLE
   MOVX  A,@DPTR
   CLR	 TM22D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC22H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM22_END:
;----------------------------------------------
      TM23_HANDLER:
   
   MOV   DPTR,#TM23_ENABLE
   MOVX  A,@DPTR
   JNB	 TM23E,TMR23_NOT_ENABLED
   JB	 TM23D,TM23_END
   
   MOV   DPTR,#TMS23L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC23L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS23H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC23H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR23_DONE
   
   JNB   TEN_MSEC_BIT,TM23_END

   MOV   DPTR,#TMC23L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC23H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM23_END   	


   SET_TMR23_DONE:	
   
   MOV   DPTR,#TM23_ENABLE
   MOVX  A,@DPTR
   SETB	 TM23D
   MOVX  @DPTR,A

   SJMP	 TM23_END	
   
   TMR23_NOT_ENABLED:
	
   MOV   DPTR,#TM23_ENABLE
   MOVX  A,@DPTR
   CLR	 TM23D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC23H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM23_END:

;----------------------------------------------
    TM24_HANDLER:
   
   MOV   DPTR,#TM24_ENABLE
   MOVX  A,@DPTR
   JNB	 TM24E,TMR24_NOT_ENABLED
   JB	 TM24D,TM24_END
   
   MOV   DPTR,#TMS24L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC24L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS24H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC24H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR24_DONE
   
   JNB   TEN_MSEC_BIT,TM24_END

   MOV   DPTR,#TMC24L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC24H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM24_END   	


   SET_TMR24_DONE:	
   
   MOV   DPTR,#TM24_ENABLE
   MOVX  A,@DPTR
   SETB	 TM24D
   MOVX  @DPTR,A

   SJMP	 TM24_END	
   
   TMR24_NOT_ENABLED:
	
   MOV   DPTR,#TM24_ENABLE
   MOVX  A,@DPTR
   CLR	 TM24D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC24H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM24_END:
;----------------------------------------------   
   TM25_HANDLER:
   
   MOV   DPTR,#TM25_ENABLE
   MOVX  A,@DPTR
   JNB	 TM25E,TMR25_NOT_ENABLED
   JB	 TM25D,TM25_END
   
   MOV   DPTR,#TMS25L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC25L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS25H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC25H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR25_DONE
   
   JNB   TEN_MSEC_BIT,TM25_END

   MOV   DPTR,#TMC25L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC25H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM25_END   	


   SET_TMR25_DONE:	
   
   MOV   DPTR,#TM25_ENABLE
   MOVX  A,@DPTR
   SETB	 TM25D
   MOVX  @DPTR,A

   SJMP	 TM25_END	
   
   TMR25_NOT_ENABLED:
	
   MOV   DPTR,#TM25_ENABLE
   MOVX  A,@DPTR
   CLR	 TM25D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC25H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM25_END:
;----------------------------------------------
  TM26_HANDLER:
   
   MOV   DPTR,#TM26_ENABLE
   MOVX  A,@DPTR
   JNB	 TM26E,TMR26_NOT_ENABLED
   JB	 TM26D,TM26_END
   
   MOV   DPTR,#TMS26L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC26L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS26H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC26H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR26_DONE
   
   JNB   TEN_MSEC_BIT,TM26_END

   MOV   DPTR,#TMC26L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC26H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM26_END   	


   SET_TMR26_DONE:	
   
   MOV   DPTR,#TM26_ENABLE
   MOVX  A,@DPTR
   SETB	 TM26D
   MOVX  @DPTR,A

   SJMP	 TM26_END	
   
   TMR26_NOT_ENABLED:
	
   MOV   DPTR,#TM26_ENABLE
   MOVX  A,@DPTR
   CLR	 TM26D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC26H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM26_END:
;----------------------------------------------
  TM27_HANDLER:
   
   MOV   DPTR,#TM27_ENABLE
   MOVX  A,@DPTR
   JNB	 TM27E,TMR27_NOT_ENABLED
   JB	 TM27D,TM27_END
   
   MOV   DPTR,#TMS27L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC27L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS27H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC27H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR27_DONE
   
   JNB   TEN_MSEC_BIT,TM27_END

   MOV   DPTR,#TMC27L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC27H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM27_END   	


   SET_TMR27_DONE:	
   
   MOV   DPTR,#TM27_ENABLE
   MOVX  A,@DPTR
   SETB	 TM27D
   MOVX  @DPTR,A

   SJMP	 TM27_END	
   
   TMR27_NOT_ENABLED:
	
   MOV   DPTR,#TM27_ENABLE
   MOVX  A,@DPTR
   CLR	 TM27D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC27H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM27_END:
;--------------------------------------------
       TM28_HANDLER:
   
   MOV   DPTR,#TM28_ENABLE
   MOVX  A,@DPTR
   JNB	 TM28E,TMR28_NOT_ENABLED
   JB	 TM28D,TM28_END
   
   MOV   DPTR,#TMS28L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC28L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS28H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC28H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR28_DONE
   
   JNB   TEN_MSEC_BIT,TM28_END

   MOV   DPTR,#TMC28L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC28H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM28_END   	


   SET_TMR28_DONE:	
   
   MOV   DPTR,#TM28_ENABLE
   MOVX  A,@DPTR
   SETB	 TM28D
   MOVX  @DPTR,A

   SJMP	 TM28_END	
   
   TMR28_NOT_ENABLED:
	
   MOV   DPTR,#TM28_ENABLE
   MOVX  A,@DPTR
   CLR	 TM28D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC28H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM28_END:

;---------------------------------------------
 TM29_HANDLER:
   
   MOV   DPTR,#TM29_ENABLE
   MOVX  A,@DPTR
   JNB	 TM29E,TMR29_NOT_ENABLED
   JB	 TM29D,TM29_END
   
   MOV   DPTR,#TMS29L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC29L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS29H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC29H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR29_DONE
   
   JNB   TEN_MSEC_BIT,TM29_END

   MOV   DPTR,#TMC29L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC29H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM29_END   	


   SET_TMR29_DONE:	
   
   MOV   DPTR,#TM29_ENABLE
   MOVX  A,@DPTR
   SETB	 TM29D
   MOVX  @DPTR,A

   SJMP	 TM29_END	
   
   TMR29_NOT_ENABLED:
	
   MOV   DPTR,#TM29_ENABLE
   MOVX  A,@DPTR
   CLR	 TM29D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC29H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM29_END:
;---------------------------------------------
  TM30_HANDLER:
   
   MOV   DPTR,#TM30_ENABLE
   MOVX  A,@DPTR
   JNB	 TM30E,TMR30_NOT_ENABLED
   JB	 TM30D,TM30_END
   
   MOV   DPTR,#TMS30L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC30L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS30H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC30H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR30_DONE
   
   JNB   TEN_MSEC_BIT,TM30_END

   MOV   DPTR,#TMC30L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC30H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM30_END   	


   SET_TMR30_DONE:	
   
   MOV   DPTR,#TM30_ENABLE
   MOVX  A,@DPTR
   SETB	 TM30D
   MOVX  @DPTR,A

   SJMP	 TM30_END	
   
   TMR30_NOT_ENABLED:
	
   MOV   DPTR,#TM30_ENABLE
   MOVX  A,@DPTR
   CLR	 TM30D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC30H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM30_END:
;---------------------------------------------
      TM31_HANDLER:
   
   MOV   DPTR,#TM31_ENABLE
   MOVX  A,@DPTR
   JNB	 TM31E,TMR31_NOT_ENABLED
   JB	 TM31D,TM31_END
   
   MOV   DPTR,#TMS31L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC31L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS31H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC31H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR31_DONE
   
   JNB   TEN_MSEC_BIT,TM31_END

   MOV   DPTR,#TMC31L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC31H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM31_END   	


   SET_TMR31_DONE:	
   
   MOV   DPTR,#TM31_ENABLE
   MOVX  A,@DPTR
   SETB	 TM31D
   MOVX  @DPTR,A

   SJMP	 TM31_END	
   
   TMR31_NOT_ENABLED:
	
   MOV   DPTR,#TM31_ENABLE
   MOVX  A,@DPTR
   CLR	 TM31D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC31H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM31_END:

;---------------------------------------------
       TM32_HANDLER:
   
   MOV   DPTR,#TM32_ENABLE
   MOVX  A,@DPTR
   JNB	 TM32E,TMR32_NOT_ENABLED
   JB	 TM32D,TM32_END
   
   MOV   DPTR,#TMS32L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC32L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS32H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC32H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR32_DONE
   
   JNB   TEN_MSEC_BIT,TM32_END

   MOV   DPTR,#TMC32L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC32H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM32_END   	


   SET_TMR32_DONE:	
   
   MOV   DPTR,#TM32_ENABLE
   MOVX  A,@DPTR
   SETB	 TM32D
   MOVX  @DPTR,A

   SJMP	 TM32_END	
   
   TMR32_NOT_ENABLED:
	
   MOV   DPTR,#TM32_ENABLE
   MOVX  A,@DPTR
   CLR	 TM32D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC32H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM32_END:

;---------------------------------------------
   TM33_HANDLER:
   
   MOV   DPTR,#TM33_ENABLE
   MOVX  A,@DPTR
   JNB	 TM33E,TMR33_NOT_ENABLED
   JB	 TM33D,TM33_END
   
   MOV   DPTR,#TMS33L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC33L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS33H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC33H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR33_DONE
   
   JNB   TEN_MSEC_BIT,TM33_END

   MOV   DPTR,#TMC33L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC33H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM33_END   	


   SET_TMR33_DONE:	
   
   MOV   DPTR,#TM33_ENABLE
   MOVX  A,@DPTR
   SETB	 TM33D
   MOVX  @DPTR,A

   SJMP	 TM33_END	
   
   TMR33_NOT_ENABLED:
	
   MOV   DPTR,#TM33_ENABLE
   MOVX  A,@DPTR
   CLR	 TM33D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC33H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM33_END:
;---------------------------------------------
  TM34_HANDLER:
   
   MOV   DPTR,#TM34_ENABLE
   MOVX  A,@DPTR
   JNB	 TM34E,TMR34_NOT_ENABLED
   JB	 TM34D,TM34_END
   
   MOV   DPTR,#TMS34L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC34L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS34H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC34H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR34_DONE
   
   JNB   TEN_MSEC_BIT,TM34_END

   MOV   DPTR,#TMC34L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC34H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM34_END   	


   SET_TMR34_DONE:	
   
   MOV   DPTR,#TM34_ENABLE
   MOVX  A,@DPTR
   SETB	 TM34D
   MOVX  @DPTR,A

   SJMP	 TM34_END	
   
   TMR34_NOT_ENABLED:
	
   MOV   DPTR,#TM34_ENABLE
   MOVX  A,@DPTR
   CLR	 TM34D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC34H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM34_END:
;---------------------------------------------
       TM35_HANDLER:
   
   MOV   DPTR,#TM35_ENABLE
   MOVX  A,@DPTR
   JNB	 TM35E,TMR35_NOT_ENABLED
   JB	 TM35D,TM35_END
   
   MOV   DPTR,#TMS35L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC35L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS35H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC35H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR35_DONE
   
   JNB   TEN_MSEC_BIT,TM35_END

   MOV   DPTR,#TMC35L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC35H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM35_END   	


   SET_TMR35_DONE:	
   
   MOV   DPTR,#TM35_ENABLE
   MOVX  A,@DPTR
   SETB	 TM35D
   MOVX  @DPTR,A

   SJMP	 TM35_END	
   
   TMR35_NOT_ENABLED:
	
   MOV   DPTR,#TM35_ENABLE
   MOVX  A,@DPTR
   CLR	 TM35D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC35H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM35_END:

;---------------------------------------------
  TM36_HANDLER:
   
   MOV   DPTR,#TM36_ENABLE
   MOVX  A,@DPTR
   JNB	 TM36E,TMR36_NOT_ENABLED
   JB	 TM36D,TM36_END
   
   MOV   DPTR,#TMS36L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC36L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS36H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC36H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR36_DONE
   
   JNB   TEN_MSEC_BIT,TM36_END

   MOV   DPTR,#TMC36L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC36H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM36_END   	


   SET_TMR36_DONE:	
   
   MOV   DPTR,#TM36_ENABLE
   MOVX  A,@DPTR
   SETB	 TM36D
   MOVX  @DPTR,A

   SJMP	 TM36_END	
   
   TMR36_NOT_ENABLED:
	
   MOV   DPTR,#TM36_ENABLE
   MOVX  A,@DPTR
   CLR	 TM36D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC36H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM36_END:
;---------------------------------------------
  TM37_HANDLER:
   
   MOV   DPTR,#TM37_ENABLE
   MOVX  A,@DPTR
   JNB	 TM37E,TMR37_NOT_ENABLED
   JB	 TM37D,TM37_END
   
   MOV   DPTR,#TMS37L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC37L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS37H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC37H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR37_DONE
   
   JNB   TEN_MSEC_BIT,TM37_END

   MOV   DPTR,#TMC37L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC37H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM37_END   	


   SET_TMR37_DONE:	
   
   MOV   DPTR,#TM37_ENABLE
   MOVX  A,@DPTR
   SETB	 TM37D
   MOVX  @DPTR,A

   SJMP	 TM37_END	
   
   TMR37_NOT_ENABLED:
	
   MOV   DPTR,#TM37_ENABLE
   MOVX  A,@DPTR
   CLR	 TM37D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC37H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM37_END:
;---------------------------------------------
  TM38_HANDLER:
   
   MOV   DPTR,#TM38_ENABLE
   MOVX  A,@DPTR
   JNB	 TM38E,TMR38_NOT_ENABLED
   JB	 TM38D,TM38_END
   
   MOV   DPTR,#TMS38L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC38L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS38H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC38H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR38_DONE
   
   JNB   TEN_MSEC_BIT,TM38_END

   MOV   DPTR,#TMC38L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC38H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM38_END   	


   SET_TMR38_DONE:	
   
   MOV   DPTR,#TM38_ENABLE
   MOVX  A,@DPTR
   SETB	 TM38D
   MOVX  @DPTR,A

   SJMP	 TM38_END	
   
   TMR38_NOT_ENABLED:
	
   MOV   DPTR,#TM38_ENABLE
   MOVX  A,@DPTR
   CLR	 TM38D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC38H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM38_END:
;---------------------------------------------
  TM39_HANDLER:
   
   MOV   DPTR,#TM39_ENABLE
   MOVX  A,@DPTR
   JNB	 TM39E,TMR39_NOT_ENABLED
   JB	 TM39D,TM39_END
   
   MOV   DPTR,#TMS39L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC39L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS39H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC39H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR39_DONE
   
   JNB   TEN_MSEC_BIT,TM39_END

   MOV   DPTR,#TMC39L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC39H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM39_END   	


   SET_TMR39_DONE:	
   
   MOV   DPTR,#TM39_ENABLE
   MOVX  A,@DPTR
   SETB	 TM39D
   MOVX  @DPTR,A

   SJMP	 TM39_END	
   
   TMR39_NOT_ENABLED:
	
   MOV   DPTR,#TM39_ENABLE
   MOVX  A,@DPTR
   CLR	 TM39D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC39H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM39_END:
;---------------------------------------------
        TM40_HANDLER:
   
   MOV   DPTR,#TM40_ENABLE
   MOVX  A,@DPTR
   JNB	 TM40E,TMR40_NOT_ENABLED
   JB	 TM40D,TM40_END
   
   MOV   DPTR,#TMS40L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC40L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS40H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC40H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR40_DONE
   
   JNB   TEN_MSEC_BIT,TM40_END

   MOV   DPTR,#TMC40L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC40H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM40_END   	


   SET_TMR40_DONE:	
   
   MOV   DPTR,#TM40_ENABLE
   MOVX  A,@DPTR
   SETB	 TM40D
   MOVX  @DPTR,A

   SJMP	 TM40_END	
   
   TMR40_NOT_ENABLED:
	
   MOV   DPTR,#TM40_ENABLE
   MOVX  A,@DPTR
   CLR	 TM40D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC40H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM40_END:

;---------------------------------------------
       TM41_HANDLER:
   
   MOV   DPTR,#TM41_ENABLE
   MOVX  A,@DPTR
   JNB	 TM41E,TMR41_NOT_ENABLED
   JB	 TM41D,TM41_END
   
   MOV   DPTR,#TMS41L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC41L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS41H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC41H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR41_DONE
   
   JNB   TEN_MSEC_BIT,TM41_END

   MOV   DPTR,#TMC41L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC41H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM41_END   	


   SET_TMR41_DONE:	
   
   MOV   DPTR,#TM41_ENABLE
   MOVX  A,@DPTR
   SETB	 TM41D
   MOVX  @DPTR,A

   SJMP	 TM41_END	
   
   TMR41_NOT_ENABLED:
	
   MOV   DPTR,#TM41_ENABLE
   MOVX  A,@DPTR
   CLR	 TM41D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC41H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM41_END:

;---------------------------------------------
       TM42_HANDLER:
   
   MOV   DPTR,#TM42_ENABLE
   MOVX  A,@DPTR
   JNB	 TM42E,TMR42_NOT_ENABLED
   JB	 TM42D,TM42_END
   
   MOV   DPTR,#TMS42L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC42L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS42H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC42H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR42_DONE
   
   JNB   TEN_MSEC_BIT,TM42_END

   MOV   DPTR,#TMC42L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC42H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM42_END   	


   SET_TMR42_DONE:	
   
   MOV   DPTR,#TM42_ENABLE
   MOVX  A,@DPTR
   SETB	 TM42D
   MOVX  @DPTR,A

   SJMP	 TM42_END	
   
   TMR42_NOT_ENABLED:
	
   MOV   DPTR,#TM42_ENABLE
   MOVX  A,@DPTR
   CLR	 TM42D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC42H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM42_END:

;---------------------------------------------
       TM43_HANDLER:
   
   MOV   DPTR,#TM43_ENABLE
   MOVX  A,@DPTR
   JNB	 TM43E,TMR43_NOT_ENABLED
   JB	 TM43D,TM43_END
   
   MOV   DPTR,#TMS43L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC43L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS43H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC43H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR43_DONE
   
   JNB   TEN_MSEC_BIT,TM43_END

   MOV   DPTR,#TMC43L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC43H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM43_END   	


   SET_TMR43_DONE:	
   
   MOV   DPTR,#TM43_ENABLE
   MOVX  A,@DPTR
   SETB	 TM43D
   MOVX  @DPTR,A

   SJMP	 TM43_END	
   
   TMR43_NOT_ENABLED:
	
   MOV   DPTR,#TM43_ENABLE
   MOVX  A,@DPTR
   CLR	 TM43D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC43H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM43_END:

;---------------------------------------------
       TM44_HANDLER:
   
   MOV   DPTR,#TM44_ENABLE
   MOVX  A,@DPTR
   JNB	 TM44E,TMR44_NOT_ENABLED
   JB	 TM44D,TM44_END
   
   MOV   DPTR,#TMS44L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC44L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS44H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC44H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR44_DONE
   
   JNB   TEN_MSEC_BIT,TM44_END

   MOV   DPTR,#TMC44L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC44H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM44_END   	


   SET_TMR44_DONE:	
   
   MOV   DPTR,#TM44_ENABLE
   MOVX  A,@DPTR
   SETB	 TM44D
   MOVX  @DPTR,A

   SJMP	 TM44_END	
   
   TMR44_NOT_ENABLED:
	
   MOV   DPTR,#TM44_ENABLE
   MOVX  A,@DPTR
   CLR	 TM44D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC44H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM44_END:

;---------------------------------------------
       TM45_HANDLER:
   
   MOV   DPTR,#TM45_ENABLE
   MOVX  A,@DPTR
   JNB	 TM45E,TMR45_NOT_ENABLED
   JB	 TM45D,TM45_END
   
   MOV   DPTR,#TMS45L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC45L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS45H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC45H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR45_DONE
   
   JNB   TEN_MSEC_BIT,TM45_END

   MOV   DPTR,#TMC45L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC45H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM45_END   	


   SET_TMR45_DONE:	
   
   MOV   DPTR,#TM45_ENABLE
   MOVX  A,@DPTR
   SETB	 TM45D
   MOVX  @DPTR,A

   SJMP	 TM45_END	
   
   TMR45_NOT_ENABLED:
	
   MOV   DPTR,#TM45_ENABLE
   MOVX  A,@DPTR
   CLR	 TM45D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC45H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM45_END:

;---------------------------------------------
        TM46_HANDLER:
   
   MOV   DPTR,#TM46_ENABLE
   MOVX  A,@DPTR
   JNB	 TM46E,TMR46_NOT_ENABLED
   JB	 TM46D,TM46_END
   
   MOV   DPTR,#TMS46L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC46L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS46H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC46H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR46_DONE
   
   JNB   TEN_MSEC_BIT,TM46_END

   MOV   DPTR,#TMC46L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC46H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM46_END   	


   SET_TMR46_DONE:	
   
   MOV   DPTR,#TM46_ENABLE
   MOVX  A,@DPTR
   SETB	 TM46D
   MOVX  @DPTR,A

   SJMP	 TM46_END	
   
   TMR46_NOT_ENABLED:
	
   MOV   DPTR,#TM46_ENABLE
   MOVX  A,@DPTR
   CLR	 TM46D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC46H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM46_END:

;---------------------------------------------
       TM47_HANDLER:
   
   MOV   DPTR,#TM47_ENABLE
   MOVX  A,@DPTR
   JNB	 TM47E,TMR47_NOT_ENABLED
   JB	 TM47D,TM47_END
   
   MOV   DPTR,#TMS47L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC47L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS47H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC47H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR47_DONE
   
   JNB   TEN_MSEC_BIT,TM47_END

   MOV   DPTR,#TMC47L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC47H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM47_END   	


   SET_TMR47_DONE:	
   
   MOV   DPTR,#TM47_ENABLE
   MOVX  A,@DPTR
   SETB	 TM47D
   MOVX  @DPTR,A

   SJMP	 TM47_END	
   
   TMR47_NOT_ENABLED:
	
   MOV   DPTR,#TM47_ENABLE
   MOVX  A,@DPTR
   CLR	 TM47D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC47H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM47_END:

;---------------------------------------------
       TM48_HANDLER:
   
   MOV   DPTR,#TM48_ENABLE
   MOVX  A,@DPTR
   JNB	 TM48E,TMR48_NOT_ENABLED
   JB	 TM48D,TM48_END
   
   MOV   DPTR,#TMS48L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC48L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS48H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC48H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR48_DONE
   
   JNB   TEN_MSEC_BIT,TM48_END

   MOV   DPTR,#TMC48L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC48H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM48_END   	


   SET_TMR48_DONE:	
   
   MOV   DPTR,#TM48_ENABLE
   MOVX  A,@DPTR
   SETB	 TM48D
   MOVX  @DPTR,A

   SJMP	 TM48_END	
   
   TMR48_NOT_ENABLED:
	
   MOV   DPTR,#TM48_ENABLE
   MOVX  A,@DPTR
   CLR	 TM48D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC48H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM48_END:

;---------------------------------------------
      TM49_HANDLER:
   
   MOV   DPTR,#TM49_ENABLE
   MOVX  A,@DPTR
   JNB	 TM49E,TMR49_NOT_ENABLED
   JB	 TM49D,TM49_END
   
   MOV   DPTR,#TMS49L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC49L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS49H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC49H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR49_DONE
   
   JNB   TEN_MSEC_BIT,TM49_END

   MOV   DPTR,#TMC49L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC49H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM49_END   	


   SET_TMR49_DONE:	
   
   MOV   DPTR,#TM49_ENABLE
   MOVX  A,@DPTR
   SETB	 TM49D
   MOVX  @DPTR,A

   SJMP	 TM49_END	
   
   TMR49_NOT_ENABLED:
	
   MOV   DPTR,#TM49_ENABLE
   MOVX  A,@DPTR
   CLR	 TM49D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC49H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM49_END:

;---------------------------------------------
      TM50_HANDLER:
   
   MOV   DPTR,#TM50_ENABLE
   MOVX  A,@DPTR
   JNB	 TM50E,TMR50_NOT_ENABLED
   JB	 TM50D,TM50_END
   
   MOV   DPTR,#TMS50L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC50L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS50H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC50H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR50_DONE
   
   JNB   TEN_MSEC_BIT,TM50_END

   MOV   DPTR,#TMC50L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC50H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM50_END   	


   SET_TMR50_DONE:	
   
   MOV   DPTR,#TM50_ENABLE
   MOVX  A,@DPTR
   SETB	 TM50D
   MOVX  @DPTR,A

   SJMP	 TM50_END	
   
   TMR50_NOT_ENABLED:
	
   MOV   DPTR,#TM50_ENABLE
   MOVX  A,@DPTR
   CLR	 TM50D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC50H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM50_END:
;---------------------------------------------
 TM51_HANDLER:
   
   MOV   DPTR,#TM51_ENABLE
   MOVX  A,@DPTR
   JNB	 TM51E,TMR51_NOT_ENABLED
   JB	 TM51D,TM51_END
   
   MOV   DPTR,#TMS51L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC51L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS51H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC51H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR51_DONE
   
   JNB   TEN_MSEC_BIT,TM51_END

   MOV   DPTR,#TMC51L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#51
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC51H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM51_END   	


   SET_TMR51_DONE:	
   
   MOV   DPTR,#TM51_ENABLE
   MOVX  A,@DPTR
   SETB	 TM51D
   MOVX  @DPTR,A

   SJMP	 TM51_END	
   
   TMR51_NOT_ENABLED:
	
   MOV   DPTR,#TM51_ENABLE
   MOVX  A,@DPTR
   CLR	 TM51D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC51H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM51_END:
;------------------------------------------------
 TM52_HANDLER:
   
   MOV   DPTR,#TM52_ENABLE
   MOVX  A,@DPTR
   JNB	 TM52E,TMR52_NOT_ENABLED
   JB	 TM52D,TM52_END
   JNB   TEN_MSEC_BIT,TM52_END

   MOV   DPTR,#TMC52L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC52H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC52H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS52H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC52H                    
   SJMP  CHK_TMC52L
			
   CHK_TMC52H:	
   
   JC	 SET_TMR52_DONE
   JNC   TMR52_NOT_DONE
   
   CHK_TMC52L:
   
   MOV   DPTR,#TMC52L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS52L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM52
   SJMP  SET_TMR52_DONE
	
   CHECK_CARRY_TM52:
	
   JC	 SET_TMR52_DONE	
  
   TMR52_NOT_DONE:
	
   MOV   DPTR,#TM52_ENABLE
   MOVX  A,@DPTR
   CLR	 TM52D
   MOVX  @DPTR,A
   SJMP	 TM52_END		
	
   SET_TMR52_DONE:	
   
   MOV   DPTR,#TM52_ENABLE
   MOVX  A,@DPTR
   SETB	 TM52D
   MOVX  @DPTR,A

   SJMP	 TM52_END	
   
   TMR52_NOT_ENABLED:
	
   MOV   DPTR,#TM52_ENABLE
   MOVX  A,@DPTR
   CLR	 TM52D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC52H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM52_END:
;----------------------------------------------   
       TM53_HANDLER:
   
   MOV   DPTR,#TM53_ENABLE
   MOVX  A,@DPTR
   JNB	 TM53E,TMR53_NOT_ENABLED
   JB	 TM53D,TM53_END
   
   MOV   DPTR,#TMS53L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC53L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS53H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC53H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR53_DONE
   
   JNB   TEN_MSEC_BIT,TM53_END

   MOV   DPTR,#TMC53L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#53
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC53H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM53_END   	


   SET_TMR53_DONE:	
   
   MOV   DPTR,#TM53_ENABLE
   MOVX  A,@DPTR
   SETB	 TM53D
   MOVX  @DPTR,A

   SJMP	 TM53_END	
   
   TMR53_NOT_ENABLED:
	
   MOV   DPTR,#TM53_ENABLE
   MOVX  A,@DPTR
   CLR	 TM53D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC53H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM53_END:

;---------------------------------------------
     TM54_HANDLER:
   
   MOV   DPTR,#TM54_ENABLE
   MOVX  A,@DPTR
   JNB	 TM54E,TMR54_NOT_ENABLED
   JB	 TM54D,TM54_END
   
   MOV   DPTR,#TMS54L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC54L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS54H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC54H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR54_DONE
   
   JNB   TEN_MSEC_BIT,TM54_END

   MOV   DPTR,#TMC54L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#54
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC54H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM54_END   	


   SET_TMR54_DONE:	
   
   MOV   DPTR,#TM54_ENABLE
   MOVX  A,@DPTR
   SETB	 TM54D
   MOVX  @DPTR,A

   SJMP	 TM54_END	
   
   TMR54_NOT_ENABLED:
	
   MOV   DPTR,#TM54_ENABLE
   MOVX  A,@DPTR
   CLR	 TM54D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC54H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM54_END:

;---------------------------------------------   
        TM55_HANDLER:
   
   MOV   DPTR,#TM55_ENABLE
   MOVX  A,@DPTR
   JNB	 TM55E,TMR55_NOT_ENABLED
   JB	 TM55D,TM55_END
   
   MOV   DPTR,#TMS55L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC55L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS55H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC55H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR55_DONE
   
   JNB   TEN_MSEC_BIT,TM55_END

   MOV   DPTR,#TMC55L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#55
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC55H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM55_END   	


   SET_TMR55_DONE:	
   
   MOV   DPTR,#TM55_ENABLE
   MOVX  A,@DPTR
   SETB	 TM55D
   MOVX  @DPTR,A

   SJMP	 TM55_END	
   
   TMR55_NOT_ENABLED:
	
   MOV   DPTR,#TM55_ENABLE
   MOVX  A,@DPTR
   CLR	 TM55D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC55H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM55_END:

;----------------------------------------------
     TM56_HANDLER:
   
   MOV   DPTR,#TM56_ENABLE
   MOVX  A,@DPTR
   JNB	 TM56E,TMR56_NOT_ENABLED
   JB	 TM56D,TM56_END
   
   MOV   DPTR,#TMS56L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC56L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS56H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC56H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR56_DONE
   
   JNB   TEN_MSEC_BIT,TM56_END

   MOV   DPTR,#TMC56L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#56
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC56H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM56_END   	


   SET_TMR56_DONE:	
   
   MOV   DPTR,#TM56_ENABLE
   MOVX  A,@DPTR
   SETB	 TM56D
   MOVX  @DPTR,A

   SJMP	 TM56_END	
   
   TMR56_NOT_ENABLED:
	
   MOV   DPTR,#TM56_ENABLE
   MOVX  A,@DPTR
   CLR	 TM56D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC56H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM56_END:

;----------------------------------------------
      TM57_HANDLER:
   
   MOV   DPTR,#TM57_ENABLE
   MOVX  A,@DPTR
   JNB	 TM57E,TMR57_NOT_ENABLED
   JB	 TM57D,TM57_END
   
   MOV   DPTR,#TMS57L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC57L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS57H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC57H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR57_DONE
   
   JNB   TEN_MSEC_BIT,TM57_END

   MOV   DPTR,#TMC57L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#57
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC57H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM57_END   	


   SET_TMR57_DONE:	
   
   MOV   DPTR,#TM57_ENABLE
   MOVX  A,@DPTR
   SETB	 TM57D
   MOVX  @DPTR,A

   SJMP	 TM57_END	
   
   TMR57_NOT_ENABLED:
	
   MOV   DPTR,#TM57_ENABLE
   MOVX  A,@DPTR
   CLR	 TM57D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC57H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM57_END:

;----------------------------------------------
     TM58_HANDLER:
   
   MOV   DPTR,#TM58_ENABLE
   MOVX  A,@DPTR
   JNB	 TM58E,TMR58_NOT_ENABLED
   JB	 TM58D,TM58_END
   
   MOV   DPTR,#TMS58L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC58L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS58H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC58H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR58_DONE
   
   JNB   TEN_MSEC_BIT,TM58_END

   MOV   DPTR,#TMC58L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#58
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC58H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM58_END   	


   SET_TMR58_DONE:	
   
   MOV   DPTR,#TM58_ENABLE
   MOVX  A,@DPTR
   SETB	 TM58D
   MOVX  @DPTR,A

   SJMP	 TM58_END	
   
   TMR58_NOT_ENABLED:
	
   MOV   DPTR,#TM58_ENABLE
   MOVX  A,@DPTR
   CLR	 TM58D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC58H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM58_END:

;----------------------------------------------
      TM59_HANDLER:
   
   MOV   DPTR,#TM59_ENABLE
   MOVX  A,@DPTR
   JNB	 TM59E,TMR59_NOT_ENABLED
   JB	 TM59D,TM59_END
   
   MOV   DPTR,#TMS59L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC59L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS59H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC59H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR59_DONE
   
   JNB   TEN_MSEC_BIT,TM59_END

   MOV   DPTR,#TMC59L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#59
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC59H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM59_END   	


   SET_TMR59_DONE:	
   
   MOV   DPTR,#TM59_ENABLE
   MOVX  A,@DPTR
   SETB	 TM59D
   MOVX  @DPTR,A

   SJMP	 TM59_END	
   
   TMR59_NOT_ENABLED:
	
   MOV   DPTR,#TM59_ENABLE
   MOVX  A,@DPTR
   CLR	 TM59D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC59H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM59_END:

;---------------------------------------------- 
     TM60_HANDLER:
   
   MOV   DPTR,#TM60_ENABLE
   MOVX  A,@DPTR
   JNB	 TM60E,TMR60_NOT_ENABLED
   JB	 TM60D,TM60_END
   
   MOV   DPTR,#TMS60L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC60L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS60H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC60H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR60_DONE
   
   JNB   TEN_MSEC_BIT,TM60_END

   MOV   DPTR,#TMC60L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#60
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC60H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM60_END   	


   SET_TMR60_DONE:	
   
   MOV   DPTR,#TM60_ENABLE
   MOVX  A,@DPTR
   SETB	 TM60D
   MOVX  @DPTR,A

   SJMP	 TM60_END	
   
   TMR60_NOT_ENABLED:
	
   MOV   DPTR,#TM60_ENABLE
   MOVX  A,@DPTR
   CLR	 TM60D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC60H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM60_END:

;----------------------------------------------
      TM61_HANDLER:
   
   MOV   DPTR,#TM61_ENABLE
   MOVX  A,@DPTR
   JNB	 TM61E,TMR61_NOT_ENABLED
   JB	 TM61D,TM61_END
   
   MOV   DPTR,#TMS61L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC61L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS61H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC61H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR61_DONE
   
   JNB   TEN_MSEC_BIT,TM61_END

   MOV   DPTR,#TMC61L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#61
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC61H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM61_END   	


   SET_TMR61_DONE:	
   
   MOV   DPTR,#TM61_ENABLE
   MOVX  A,@DPTR
   SETB	 TM61D
   MOVX  @DPTR,A

   SJMP	 TM61_END	
   
   TMR61_NOT_ENABLED:
	
   MOV   DPTR,#TM61_ENABLE
   MOVX  A,@DPTR
   CLR	 TM61D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC61H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM61_END:

;----------------------------------------------
      TM62_HANDLER:
   
   MOV   DPTR,#TM62_ENABLE
   MOVX  A,@DPTR
   JNB	 TM62E,TMR62_NOT_ENABLED
   JB	 TM62D,TM62_END
   
   MOV   DPTR,#TMS62L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC62L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS62H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC62H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR62_DONE
   
   JNB   TEN_MSEC_BIT,TM62_END

   MOV   DPTR,#TMC62L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#62
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC62H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM62_END   	


   SET_TMR62_DONE:	
   
   MOV   DPTR,#TM62_ENABLE
   MOVX  A,@DPTR
   SETB	 TM62D
   MOVX  @DPTR,A

   SJMP	 TM62_END	
   
   TMR62_NOT_ENABLED:
	
   MOV   DPTR,#TM62_ENABLE
   MOVX  A,@DPTR
   CLR	 TM62D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC62H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM62_END:

;----------------------------------------------
      TM63_HANDLER:
   
   MOV   DPTR,#TM63_ENABLE
   MOVX  A,@DPTR
   JNB	 TM63E,TMR63_NOT_ENABLED
   JB	 TM63D,TM63_END
   
   MOV   DPTR,#TMS63L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC63L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS63H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC63H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR63_DONE
   
   JNB   TEN_MSEC_BIT,TM63_END

   MOV   DPTR,#TMC63L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#63
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC63H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM63_END   	


   SET_TMR63_DONE:	
   
   MOV   DPTR,#TM63_ENABLE
   MOVX  A,@DPTR
   SETB	 TM63D
   MOVX  @DPTR,A

   SJMP	 TM63_END	
   
   TMR63_NOT_ENABLED:
	
   MOV   DPTR,#TM63_ENABLE
   MOVX  A,@DPTR
   CLR	 TM63D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC63H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM63_END:
;----------------------------------------------------
      TM64_HANDLER:
   
   MOV   DPTR,#TM64_ENABLE
   MOVX  A,@DPTR
   JNB	 TM64E,TMR64_NOT_ENABLED
   JB	 TM64D,TM64_END
   
   MOV   DPTR,#TMS64L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC64L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS64H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC64H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR64_DONE
   
   JNB   TEN_MSEC_BIT,TM64_END

   MOV   DPTR,#TMC64L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#64
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC64H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM64_END   	


   SET_TMR64_DONE:	
   
   MOV   DPTR,#TM64_ENABLE
   MOVX  A,@DPTR
   SETB	 TM64D
   MOVX  @DPTR,A

   SJMP	 TM64_END	
   
   TMR64_NOT_ENABLED:
	
   MOV   DPTR,#TM64_ENABLE
   MOVX  A,@DPTR
   CLR	 TM64D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC64H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM64_END:

;----------------------------------------------
       TM65_HANDLER:
   
   MOV   DPTR,#TM65_ENABLE
   MOVX  A,@DPTR
   JNB	 TM65E,TMR65_NOT_ENABLED
   JB	 TM65D,TM65_END
   
   MOV   DPTR,#TMS65L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC65L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS65H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC65H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR65_DONE
   
   JNB   TEN_MSEC_BIT,TM65_END

   MOV   DPTR,#TMC65L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#65
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC65H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM65_END   	


   SET_TMR65_DONE:	
   
   MOV   DPTR,#TM65_ENABLE
   MOVX  A,@DPTR
   SETB	 TM65D
   MOVX  @DPTR,A

   SJMP	 TM65_END	
   
   TMR65_NOT_ENABLED:
	
   MOV   DPTR,#TM65_ENABLE
   MOVX  A,@DPTR
   CLR	 TM65D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC65H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM65_END:

;----------------------------------------------
      TM66_HANDLER:
   
   MOV   DPTR,#TM66_ENABLE
   MOVX  A,@DPTR
   JNB	 TM66E,TMR66_NOT_ENABLED
   JB	 TM66D,TM66_END
   
   MOV   DPTR,#TMS66L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC66L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS66H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC66H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR66_DONE
   
   JNB   TEN_MSEC_BIT,TM66_END

   MOV   DPTR,#TMC66L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#66
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC66H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM66_END   	


   SET_TMR66_DONE:	
   
   MOV   DPTR,#TM66_ENABLE
   MOVX  A,@DPTR
   SETB	 TM66D
   MOVX  @DPTR,A

   SJMP	 TM66_END	
   
   TMR66_NOT_ENABLED:
	
   MOV   DPTR,#TM66_ENABLE
   MOVX  A,@DPTR
   CLR	 TM66D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC66H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM66_END:

;----------------------------------------------
       TM67_HANDLER:
   
   MOV   DPTR,#TM67_ENABLE
   MOVX  A,@DPTR
   JNB	 TM67E,TMR67_NOT_ENABLED
   JB	 TM67D,TM67_END
   
   MOV   DPTR,#TMS67L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC67L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS67H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC67H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR67_DONE
   
   JNB   TEN_MSEC_BIT,TM67_END

   MOV   DPTR,#TMC67L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#67
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC67H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM67_END   	


   SET_TMR67_DONE:	
   
   MOV   DPTR,#TM67_ENABLE
   MOVX  A,@DPTR
   SETB	 TM67D
   MOVX  @DPTR,A

   SJMP	 TM67_END	
   
   TMR67_NOT_ENABLED:
	
   MOV   DPTR,#TM67_ENABLE
   MOVX  A,@DPTR
   CLR	 TM67D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC67H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM67_END:

;----------------------------------------------
      TM68_HANDLER:
   
   MOV   DPTR,#TM68_ENABLE
   MOVX  A,@DPTR
   JNB	 TM68E,TMR68_NOT_ENABLED
   JB	 TM68D,TM68_END
   
   MOV   DPTR,#TMS68L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC68L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS68H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC68H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR68_DONE
   
   JNB   TEN_MSEC_BIT,TM68_END

   MOV   DPTR,#TMC68L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#68
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC68H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM68_END   	


   SET_TMR68_DONE:	
   
   MOV   DPTR,#TM68_ENABLE
   MOVX  A,@DPTR
   SETB	 TM68D
   MOVX  @DPTR,A

   SJMP	 TM68_END	
   
   TMR68_NOT_ENABLED:
	
   MOV   DPTR,#TM68_ENABLE
   MOVX  A,@DPTR
   CLR	 TM68D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC68H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM68_END:

;----------------------------------------------
      TM69_HANDLER:
   
   MOV   DPTR,#TM69_ENABLE
   MOVX  A,@DPTR
   JNB	 TM69E,TMR69_NOT_ENABLED
   JB	 TM69D,TM69_END
   
   MOV   DPTR,#TMS69L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC69L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS69H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC69H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR69_DONE
   
   JNB   TEN_MSEC_BIT,TM69_END

   MOV   DPTR,#TMC69L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#69
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC69H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM69_END   	


   SET_TMR69_DONE:	
   
   MOV   DPTR,#TM69_ENABLE
   MOVX  A,@DPTR
   SETB	 TM69D
   MOVX  @DPTR,A

   SJMP	 TM69_END	
   
   TMR69_NOT_ENABLED:
	
   MOV   DPTR,#TM69_ENABLE
   MOVX  A,@DPTR
   CLR	 TM69D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC69H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM69_END:

;----------------------------------------------
      TM70_HANDLER:
   
   MOV   DPTR,#TM70_ENABLE
   MOVX  A,@DPTR
   JNB	 TM70E,TMR70_NOT_ENABLED
   JB	 TM70D,TM70_END
   
   MOV   DPTR,#TMS70L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC70L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS70H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC70H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR70_DONE
   
   JNB   TEN_MSEC_BIT,TM70_END

   MOV   DPTR,#TMC70L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#70
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC70H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM70_END   	


   SET_TMR70_DONE:	
   
   MOV   DPTR,#TM70_ENABLE
   MOVX  A,@DPTR
   SETB	 TM70D
   MOVX  @DPTR,A

   SJMP	 TM70_END	
   
   TMR70_NOT_ENABLED:
	
   MOV   DPTR,#TM70_ENABLE
   MOVX  A,@DPTR
   CLR	 TM70D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC70H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM70_END:

;----------------------------------------------
        TM71_HANDLER:
   
   MOV   DPTR,#TM71_ENABLE
   MOVX  A,@DPTR
   JNB	 TM71E,TMR71_NOT_ENABLED
   JB	 TM71D,TM71_END
   
   MOV   DPTR,#TMS71L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC71L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS71H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC71H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR71_DONE
   
   JNB   TEN_MSEC_BIT,TM71_END

   MOV   DPTR,#TMC71L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#71
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC71H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM71_END   	


   SET_TMR71_DONE:	
   
   MOV   DPTR,#TM71_ENABLE
   MOVX  A,@DPTR
   SETB	 TM71D
   MOVX  @DPTR,A

   SJMP	 TM71_END	
   
   TMR71_NOT_ENABLED:
	
   MOV   DPTR,#TM71_ENABLE
   MOVX  A,@DPTR
   CLR	 TM71D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC71H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM71_END:

;----------------------------------------------
        TM72_HANDLER:
   
   MOV   DPTR,#TM72_ENABLE
   MOVX  A,@DPTR
   JNB	 TM72E,TMR72_NOT_ENABLED
   JB	 TM72D,TM72_END
   
   MOV   DPTR,#TMS72L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC72L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS72H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC72H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR72_DONE
   
   JNB   TEN_MSEC_BIT,TM72_END

   MOV   DPTR,#TMC72L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#72
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC72H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM72_END   	


   SET_TMR72_DONE:	
   
   MOV   DPTR,#TM72_ENABLE
   MOVX  A,@DPTR
   SETB	 TM72D
   MOVX  @DPTR,A

   SJMP	 TM72_END	
   
   TMR72_NOT_ENABLED:
	
   MOV   DPTR,#TM72_ENABLE
   MOVX  A,@DPTR
   CLR	 TM72D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC72H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM72_END:

;----------------------------------------------
        TM73_HANDLER:
   
   MOV   DPTR,#TM73_ENABLE
   MOVX  A,@DPTR
   JNB	 TM73E,TMR73_NOT_ENABLED
   JB	 TM73D,TM73_END
   
   MOV   DPTR,#TMS73L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC73L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS73H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC73H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR73_DONE
   
   JNB   TEN_MSEC_BIT,TM73_END

   MOV   DPTR,#TMC73L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#73
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC73H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM73_END   	


   SET_TMR73_DONE:	
   
   MOV   DPTR,#TM73_ENABLE
   MOVX  A,@DPTR
   SETB	 TM73D
   MOVX  @DPTR,A

   SJMP	 TM73_END	
   
   TMR73_NOT_ENABLED:
	
   MOV   DPTR,#TM73_ENABLE
   MOVX  A,@DPTR
   CLR	 TM73D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC73H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM73_END:

;----------------------------------------------
        TM74_HANDLER:
   
   MOV   DPTR,#TM74_ENABLE
   MOVX  A,@DPTR
   JNB	 TM74E,TMR74_NOT_ENABLED
   JB	 TM74D,TM74_END
   
   MOV   DPTR,#TMS74L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC74L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS74H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC74H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR74_DONE
   
   JNB   TEN_MSEC_BIT,TM74_END

   MOV   DPTR,#TMC74L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#74
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC74H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM74_END   	


   SET_TMR74_DONE:	
   
   MOV   DPTR,#TM74_ENABLE
   MOVX  A,@DPTR
   SETB	 TM74D
   MOVX  @DPTR,A

   SJMP	 TM74_END	
   
   TMR74_NOT_ENABLED:
	
   MOV   DPTR,#TM74_ENABLE
   MOVX  A,@DPTR
   CLR	 TM74D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC74H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM74_END:

;----------------------------------------------
       TM75_HANDLER:
   
   MOV   DPTR,#TM75_ENABLE
   MOVX  A,@DPTR
   JNB	 TM75E,TMR75_NOT_ENABLED
   JB	 TM75D,TM75_END
   
   MOV   DPTR,#TMS75L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC75L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS75H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC75H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR75_DONE
   
   JNB   TEN_MSEC_BIT,TM75_END

   MOV   DPTR,#TMC75L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#75
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC75H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM75_END   	


   SET_TMR75_DONE:	
   
   MOV   DPTR,#TM75_ENABLE
   MOVX  A,@DPTR
   SETB	 TM75D
   MOVX  @DPTR,A

   SJMP	 TM75_END	
   
   TMR75_NOT_ENABLED:
	
   MOV   DPTR,#TM75_ENABLE
   MOVX  A,@DPTR
   CLR	 TM75D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC75H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM75_END:

;----------------------------------------------
        TM76_HANDLER:
   
   MOV   DPTR,#TM76_ENABLE
   MOVX  A,@DPTR
   JNB	 TM76E,TMR76_NOT_ENABLED
   JB	 TM76D,TM76_END
   
   MOV   DPTR,#TMS76L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC76L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS76H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC76H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR76_DONE
   
   JNB   TEN_MSEC_BIT,TM76_END

   MOV   DPTR,#TMC76L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#76
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC76H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM76_END   	


   SET_TMR76_DONE:	
   
   MOV   DPTR,#TM76_ENABLE
   MOVX  A,@DPTR
   SETB	 TM76D
   MOVX  @DPTR,A

   SJMP	 TM76_END	
   
   TMR76_NOT_ENABLED:
	
   MOV   DPTR,#TM76_ENABLE
   MOVX  A,@DPTR
   CLR	 TM76D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC76H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM76_END:

;----------------------------------------------
        TM77_HANDLER:
   
   MOV   DPTR,#TM77_ENABLE
   MOVX  A,@DPTR
   JNB	 TM77E,TMR77_NOT_ENABLED
   JB	 TM77D,TM77_END
   
   MOV   DPTR,#TMS77L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC77L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS77H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC77H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR77_DONE
   
   JNB   TEN_MSEC_BIT,TM77_END

   MOV   DPTR,#TMC77L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#77
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC77H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM77_END   	


   SET_TMR77_DONE:	
   
   MOV   DPTR,#TM77_ENABLE
   MOVX  A,@DPTR
   SETB	 TM77D
   MOVX  @DPTR,A

   SJMP	 TM77_END	
   
   TMR77_NOT_ENABLED:
	
   MOV   DPTR,#TM77_ENABLE
   MOVX  A,@DPTR
   CLR	 TM77D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC77H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM77_END:

;----------------------------------------------
        TM78_HANDLER:
   
   MOV   DPTR,#TM78_ENABLE
   MOVX  A,@DPTR
   JNB	 TM78E,TMR78_NOT_ENABLED
   JB	 TM78D,TM78_END
   
   MOV   DPTR,#TMS78L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC78L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS78H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC78H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR78_DONE
   
   JNB   TEN_MSEC_BIT,TM78_END

   MOV   DPTR,#TMC78L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#78
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC78H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM78_END   	


   SET_TMR78_DONE:	
   
   MOV   DPTR,#TM78_ENABLE
   MOVX  A,@DPTR
   SETB	 TM78D
   MOVX  @DPTR,A

   SJMP	 TM78_END	
   
   TMR78_NOT_ENABLED:
	
   MOV   DPTR,#TM78_ENABLE
   MOVX  A,@DPTR
   CLR	 TM78D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC78H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM78_END:
;----------------------------------------------
        TM79_HANDLER:
   
   MOV   DPTR,#TM79_ENABLE
   MOVX  A,@DPTR
   JNB	 TM79E,TMR79_NOT_ENABLED
   JB	 TM79D,TM79_END
   
   MOV   DPTR,#TMS79L
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC79L
   MOVX  A,@DPTR
   CLR   C
   SUBB  A,B
   MOV   DPTR,#TMS79H
   MOVX  A,@DPTR
   MOV   B,A
   MOV   DPTR,#TMC79H
   MOVX  A,@DPTR
   SUBB  A,B
   JNC   SET_TMR79_DONE
   
   JNB   TEN_MSEC_BIT,TM79_END

   MOV   DPTR,#TMC79L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#79
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC79H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
   SJMP  TM79_END   	


   SET_TMR79_DONE:	
   
   MOV   DPTR,#TM79_ENABLE
   MOVX  A,@DPTR
   SETB	 TM79D
   MOVX  @DPTR,A

   SJMP	 TM79_END	
   
   TMR79_NOT_ENABLED:
	
   MOV   DPTR,#TM79_ENABLE
   MOVX  A,@DPTR
   CLR	 TM79D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC79H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM79_END:


;----------------------------------------------
;   TM00_HANDLER:
;    
;   JNB	TM00E,TMR0_NOT_ENABLED
;   JB	TM00D,TM01_HANDLER
;   JNB  TEN_MSEC_BIT,TM01_HANDLER
;;--------------------------------------------------------------	
;   MOV   DPTR,#TMC00L
;   MOVX  A,@DPTR                                               
;   CLR   C
;   ADD	 A,#01
;   MOVX	 @DPTR,A                           
;   MOV   DPTR,#TMC00H
;   MOVX  A,@DPTR
;   ADDC  A,#0
;   MOVX	 @DPTR,A       
;	
;	MOV   DPTR,#TMC00H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS00H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC00H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC00L
;			
;   CHK_TMC00H:	
;   
;   JC	   SET_TMR_DONE
;   JNC   TMR00_NOT_DONE
;   
;   CHK_TMC00L:
;   
;   MOV   DPTR,#TMC00L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS00L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY
;	SJMP  SET_TMR_DONE
;	
;	CHECK_CARRY:
;	
;	JC	   SET_TMR_DONE	
;  
;   TMR00_NOT_DONE:
;	
;	CLR	TM00D
;	SJMP	TM01_HANDLER			
;	
;   SET_TMR_DONE:	
;   
;   SETB	TM00D
;	SJMP	TM01_HANDLER	
;   
;   TMR0_NOT_ENABLED:
;	
;	CLR	TM00D
;   CLR   A
;   MOV   DPTR,#TMC00H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;
;	
;	
;;---------------------------------------------------------------------------------------
;	TM01_HANDLER:
;	
;	JNB	TM01E,TMR1_NOT_ENABLED
;	JB	   TM01D,TM02_HANDLER
;	JNB   TEN_MSEC_BIT,TM02_HANDLER
;	CLR	C
;	MOV   DPTR,#TMC01L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC01H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC01H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS01H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC01H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC01L
;			
;   CHK_TMC01H:	
;   
;   JC	   SET_TMR01_DONE
;   JNC   TMR01_NOT_DONE
;   
;   CHK_TMC01L:
;   
;   MOV   DPTR,#TMC01L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS01L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM01
;	SJMP  SET_TMR01_DONE
;	
;	CHECK_CARRY_TM01:
;	
;	JC	   SET_TMR01_DONE	
;  
;   TMR01_NOT_DONE:
;	
;	CLR	TM01D
;	SJMP	TM02_HANDLER			
;	
;   SET_TMR01_DONE:	
;   
;   SETB	TM01D
;	SJMP	TM02_HANDLER	
;   
;   TMR1_NOT_ENABLED:
;	
;	CLR	TM01D
;   CLR   A
;   MOV   DPTR,#TMC01H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;---------------------------------------------------------------------
;   TM02_HANDLER:
;   
;   JNB	TM02E,TMR2_NOT_ENABLED
;	JB	   TM02D,TM03_HANDLER
;   JNB   TEN_MSEC_BIT,TM03_HANDLER
;   MOV   DPTR,#TMC02L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC02H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC02H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS02H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC02H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC02L
;			
;   CHK_TMC02H:	
;   
;   JC	   SET_TMR02_DONE
;   JNC   TMR02_NOT_DONE
;   
;   CHK_TMC02L:
;   
;   MOV   DPTR,#TMC02L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS02L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM02
;	SJMP  SET_TMR02_DONE
;	
;	CHECK_CARRY_TM02:
;	
;	JC	   SET_TMR02_DONE	
;  
;   TMR02_NOT_DONE:
;	
;	CLR	TM02D
;	SJMP	TM03_HANDLER			
;	
;   SET_TMR02_DONE:	
;   
;   SETB	TM02D
;	SJMP	TM03_HANDLER	
;   
;   TMR2_NOT_ENABLED:
;	
;	CLR	TM02D
;   CLR   A
;   MOV   DPTR,#TMC02H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;-------------------------------------------------------------------	
;	TM03_HANDLER:
;	
;	JNB	TM03E,TMR3_NOT_ENABLED
;	JB	   BLOW_DLY_TM03D,TM04_HANDLER
;	JNB   TEN_MSEC_BIT,TM04_HANDLER
;	MOV   DPTR,#TMC03L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC03H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC03H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS03H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC03H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC03L
;			
;   CHK_TMC03H:	
;   
;   JC	   SET_TMR03_DONE
;   JNC   TMR03_NOT_DONE
;   
;   CHK_TMC03L:
;   
;   MOV   DPTR,#TMC03L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS03L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM03
;	SJMP  SET_TMR03_DONE
;	
;	CHECK_CARRY_TM03:
;	
;	JC	   SET_TMR03_DONE	
;  
;   TMR03_NOT_DONE:
;	
;	CLR	BLOW_DLY_TM03D
;	SJMP	TM04_HANDLER			
;	
;   SET_TMR03_DONE:	
;   
;   SETB	BLOW_DLY_TM03D
;	SJMP	TM04_HANDLER	
;   
;   TMR3_NOT_ENABLED:
;	
;	CLR	BLOW_DLY_TM03D
;   CLR   A
;   MOV   DPTR,#TMC03H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;
;;--------------------------------------------------------------------	
;   TM04_HANDLER:
;   
;   JNB	TM04E,TMR4_NOT_ENABLED
;	JB	   TM04D,TM05_HANDLER	
;	JNB   TEN_MSEC_BIT,TM05_HANDLER
;	MOV   DPTR,#TMC04L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC04H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC04H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS04H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC04H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC04L
;			
;   CHK_TMC04H:	
;   
;   JC	   SET_TMR04_DONE
;   JNC   TMR04_NOT_DONE
;   
;   CHK_TMC04L:
;   
;   MOV   DPTR,#TMC04L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS04L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM04
;	SJMP  SET_TMR04_DONE
;	
;	CHECK_CARRY_TM04:
;	
;	JC	   SET_TMR04_DONE	
;  
;   TMR04_NOT_DONE:
;	
;	CLR	TM04D
;	SJMP	TM05_HANDLER			
;	
;   SET_TMR04_DONE:	
;   
;   SETB	TM04D
;	SJMP	TM05_HANDLER	
;   
;   TMR4_NOT_ENABLED:
;	
;	CLR	TM04D
;   CLR   A
;   MOV   DPTR,#TMC04H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;---------------------------------------------------------------------   
;   TM05_HANDLER:
;   
;   JNB	TM05E,TMR5_NOT_ENABLED
;	JB	   TM05D,TM06_HANDLER	
;	JNB   TEN_MSEC_BIT,TM06_HANDLER
;   	
;	MOV   DPTR,#TMC05L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC05H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC05H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS05H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC05H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC05L
;			
;   CHK_TMC05H:	
;   
;   JC	   SET_TMR05_DONE
;   JNC   TMR05_NOT_DONE
;   
;   CHK_TMC05L:
;   
;   MOV   DPTR,#TMC05L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS05L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM05
;	SJMP  SET_TMR05_DONE
;	
;	CHECK_CARRY_TM05:
;	
;	JC	   SET_TMR05_DONE	
;  
;   TMR05_NOT_DONE:
;	
;	CLR	TM05D
;	SJMP	TM06_HANDLER			
;	
;   SET_TMR05_DONE:	
;   
;   SETB	TM05D
;	SJMP	TM06_HANDLER	
;   
;   TMR5_NOT_ENABLED:
;	
;	CLR	TM05D
;   CLR   A
;   MOV   DPTR,#TMC05H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;---------------------------------------------------------------
;   TM06_HANDLER:
;   
;   JNB	TM06E,TMR6_NOT_ENABLED
;	JB	   TM06D,TM07_HANDLER	
;	JNB   TEN_MSEC_BIT,TM07_HANDLER
;      	
;	MOV   DPTR,#TMC06L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC06H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC06H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS06H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC06H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC06L
;			
;   CHK_TMC06H:	
;   
;   JC	   SET_TMR06_DONE
;   JNC   TMR06_NOT_DONE
;   
;   CHK_TMC06L:
;   
;   MOV   DPTR,#TMC06L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS06L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM06
;	SJMP  SET_TMR06_DONE
;	
;	CHECK_CARRY_TM06:
;	
;	JC	   SET_TMR06_DONE	
;  
;   TMR06_NOT_DONE:
;	
;	CLR	TM06D
;	SJMP	TM07_HANDLER			
;	
;   SET_TMR06_DONE:	
;   
;   SETB	TM06D
;	SJMP	TM07_HANDLER	
;   
;   TMR6_NOT_ENABLED:
;	
;	CLR	TM06D
;   CLR   A
;   MOV   DPTR,#TMC06H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;-------------------------------------------------------------------
;   TM07_HANDLER:
;   
;   JNB	TM07E,TMR7_NOT_ENABLED
;	JB	   TM07D,TM08_HANDLER	
;	JNB   TEN_MSEC_BIT,TM08_HANDLER
;         	
;	MOV   DPTR,#TMC07L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC07H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC07H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS07H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC07H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC07L
;			
;   CHK_TMC07H:	
;   
;   JC	   SET_TMR07_DONE
;   JNC   TMR07_NOT_DONE
;   
;   CHK_TMC07L:
;   
;   MOV   DPTR,#TMC07L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS07L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM07
;	SJMP  SET_TMR07_DONE
;	
;	CHECK_CARRY_TM07:
;	
;	JC	   SET_TMR07_DONE	
;  
;   TMR07_NOT_DONE:
;	
;	CLR	TM07D
;	SJMP	TM08_HANDLER			
;	
;   SET_TMR07_DONE:	
;   
;   SETB	TM07D
;	SJMP	TM08_HANDLER	
;   
;   TMR7_NOT_ENABLED:
;	
;	CLR	TM07D
;   CLR   A
;   MOV   DPTR,#TMC07H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;-------------------------------------------------------------------
;   TM08_HANDLER:
;   
;      
;   JNB	TM08E,TMR8_NOT_ENABLED
;	JB	   TM08D,TM09_HANDLER	
;	JNB   TEN_MSEC_BIT,TM09_HANDLER
;         	
;	MOV   DPTR,#TMC08L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC08H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC08H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS08H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC08H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC08L
;			
;   CHK_TMC08H:	
;   
;   JC	   SET_TMR08_DONE
;   JNC   TMR08_NOT_DONE
;   
;   CHK_TMC08L:
;   
;   MOV   DPTR,#TMC08L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS08L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM08
;	SJMP  SET_TMR08_DONE
;	
;	CHECK_CARRY_TM08:
;	
;	JC	   SET_TMR08_DONE	
;  
;   TMR08_NOT_DONE:
;	
;	CLR	TM08D
;	SJMP	TM09_HANDLER			
;	
;   SET_TMR08_DONE:	
;   
;   SETB	TM08D
;	SJMP	TM09_HANDLER	
;   
;   TMR8_NOT_ENABLED:
;	
;	CLR	TM08D
;   CLR   A
;   MOV   DPTR,#TMC08H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;--------------------------------------------------------------------
;   TM09_HANDLER:
;   
;         
;   JNB	TM09E,TMR9_NOT_ENABLED
;	JB	   TM09D,TM10_HANDLER	
;	JNB   TEN_MSEC_BIT,TM10_HANDLER
;         	
;	MOV   DPTR,#TMC09L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC09H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC09H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS09H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC09H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC09L
;			
;   CHK_TMC09H:	
;   
;   JC	   SET_TMR09_DONE
;   JNC   TMR09_NOT_DONE
;   
;   CHK_TMC09L:
;   
;   MOV   DPTR,#TMC09L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS09L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM09
;	SJMP  SET_TMR09_DONE
;	
;	CHECK_CARRY_TM09:
;	
;	JC	   SET_TMR09_DONE	
;  
;   TMR09_NOT_DONE:
;	
;	CLR	TM09D
;	SJMP	TM10_HANDLER			
;	
;   SET_TMR09_DONE:	
;   
;   SETB	TM09D
;	SJMP	TM10_HANDLER	
;   
;   TMR9_NOT_ENABLED:
;	
;	CLR	TM09D
;   CLR   A
;   MOV   DPTR,#TMC09H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;------------------------------------------------------------------   
;   
;   TM10_HANDLER:
;         
;   JNB	TM10E,TMR10_NOT_ENABLED
;	JB	   TM10D,TM11_HANDLER	
;	JNB   TEN_MSEC_BIT,TM11_HANDLER
;         	
;	MOV   DPTR,#TMC10L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC10H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC10H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS10H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC10H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC10L
;			
;   CHK_TMC10H:	
;   
;   JC	   SET_TMR10_DONE
;   JNC   TMR10_NOT_DONE
;   
;   CHK_TMC10L:
;   
;   MOV   DPTR,#TMC10L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS10L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM10
;	SJMP  SET_TMR10_DONE
;	
;	CHECK_CARRY_TM10:
;	
;	JC	   SET_TMR10_DONE	
;  
;   TMR10_NOT_DONE:
;	
;	CLR	TM10D
;	SJMP	TM11_HANDLER			
;	
;   SET_TMR10_DONE:	
;   
;   SETB	TM10D
;	SJMP	TM11_HANDLER	
;   
;   TMR10_NOT_ENABLED:
;	
;	CLR	TM10D
;   CLR   A
;   MOV   DPTR,#TMC10H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;-------------------------------------------------------------------   
;   TM11_HANDLER:
;   
;   JNB	TM11E,TMR11_NOT_ENABLED
;	JB	   TM11D,TM12_HANDLER	
;	JNB   TEN_MSEC_BIT,TM12_HANDLER
;            	
;	MOV   DPTR,#TMC11L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC11H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC11H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS11H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC11H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC11L
;			
;   CHK_TMC11H:	
;   
;   JC	   SET_TMR11_DONE
;   JNC   TMR11_NOT_DONE
;   
;   CHK_TMC11L:
;   
;   MOV   DPTR,#TMC11L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS11L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM11
;	SJMP  SET_TMR11_DONE
;	
;	CHECK_CARRY_TM11:
;	
;	JC	   SET_TMR11_DONE	
;  
;   TMR11_NOT_DONE:
;	
;	CLR	TM11D
;	SJMP	TM12_HANDLER			
;	
;   SET_TMR11_DONE:	
;   
;   SETB	TM11D
;	SJMP	TM12_HANDLER	
;   
;   TMR11_NOT_ENABLED:
;	
;	CLR	TM11D
;   CLR   A
;   MOV   DPTR,#TMC11H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;;-------------------------------------------------------------------
;   TM12_HANDLER:
;   
;;   JNB	TM12E,TMR12_NOT_ENABLED
;;	JB	   TM12D,TM13_HANDLER	
;;	JNB   TEN_MSEC_BIT,TM13_HANDLER
;;               	
;;	MOV   DPTR,#TMC12L
;;   MOVX  A,@DPTR                                               
;;	CLR   C
;;	ADD	A,#01
;;	MOVX	@DPTR,A                           
;;   MOV   DPTR,#TMC12H
;;   MOVX  A,@DPTR
;;   ADDC 	A,#0
;;	MOVX	@DPTR,A       
;;	
;;	MOV   DPTR,#TMC12H
;;	MOVX  A,@DPTR              
;;	MOV   B,A
;;   MOV   DPTR,#TMS12H
;;   MOVX  A,@DPTR
;;   CJNE  A,B,CHK_TMC12H                    ;TMR00_NOT_DONE
;;	SJMP  CHK_TMC12L
;;			
;;   CHK_TMC12H:	
;;   
;;   JC	   SET_TMR12_DONE
;;   JNC   TMR12_NOT_DONE
;;   
;;   CHK_TMC12L:
;;   
;;   MOV   DPTR,#TMC12L
;;   MOVX	A,@DPTR                               ;A,TMC00L
;;	MOV   B,A
;;	MOV   DPTR,#TMS12L
;;	MOVX  A,@DPTR
;;	CJNE  A,B,CHECK_CARRY_TM12
;;	SJMP  SET_TMR12_DONE
;;	
;;	CHECK_CARRY_TM12:
;;	
;;	JC	   SET_TMR12_DONE	
;;  
;;   TMR12_NOT_DONE:
;;	
;;	CLR	TM12D
;;	SJMP	TM13_HANDLER			
;;	
;;   SET_TMR12_DONE:	
;;   
;;   SETB	TM12D
;;	SJMP	TM13_HANDLER	
;;   
;;   TMR12_NOT_ENABLED:
;;	
;;	CLR	TM12D
;;   CLR   A
;;   MOV   DPTR,#TMC12H
;;   MOVX  @DPTR,A
;;   INC   DPTR
;;   MOVX  @DPTR,A
;;
;;   
;;;--------------------------------------------------------------------   
;;   TM13_HANDLER:
;;   
;;   JNB	TM13E,TMR13_NOT_ENABLED
;;	JB	   TM13D,TM14_HANDLER	
;;	JNB   TEN_MSEC_BIT,TM14_HANDLER
;;               	
;;	MOV   DPTR,#TMC13L
;;   MOVX  A,@DPTR                                               
;;	CLR   C
;;	ADD	A,#01
;;	MOVX	@DPTR,A                           
;;   MOV   DPTR,#TMC13H
;;   MOVX  A,@DPTR
;;   ADDC 	A,#0
;;	MOVX	@DPTR,A       
;;	
;;	MOV   DPTR,#TMC13H
;;	MOVX  A,@DPTR              
;;	MOV   B,A
;;   MOV   DPTR,#TMS13H
;;   MOVX  A,@DPTR
;;   CJNE  A,B,CHK_TMC13H                    ;TMR00_NOT_DONE
;;	SJMP  CHK_TMC13L
;;			
;;   CHK_TMC13H:	
;;   
;;   JC	   SET_TMR13_DONE
;;   JNC   TMR13_NOT_DONE
;;   
;;   CHK_TMC13L:
;;   
;;   MOV   DPTR,#TMC13L
;;   MOVX	A,@DPTR                               ;A,TMC00L
;;	MOV   B,A
;;	MOV   DPTR,#TMS13L
;;	MOVX  A,@DPTR
;;	CJNE  A,B,CHECK_CARRY_TM13
;;	SJMP  SET_TMR13_DONE
;;	
;;	CHECK_CARRY_TM13:
;;	
;;	JC	   SET_TMR13_DONE	
;;  
;;   TMR13_NOT_DONE:
;;	
;;	CLR	TM13D
;;	SJMP	TM14_HANDLER			
;;	
;;   SET_TMR13_DONE:	
;;   
;;   SETB	TM13D
;;	SJMP	TM14_HANDLER	
;;   
;;   TMR13_NOT_ENABLED:
;;	
;;   CLR	TM13D
;;   CLR   A
;;   MOV   DPTR,#TMC13H
;;   MOVX  @DPTR,A
;;   INC   DPTR
;;   MOVX  @DPTR,A
;;;--------------------------------------------------------------------------
;;   TM14_HANDLER:
;;   
;;   JNB	TM14E,TMR14_NOT_ENABLED
;;	JB	   TM14D,TM14_END
;;	JNB   TEN_MSEC_BIT,TM14_END
;;                  	
;;	MOV   DPTR,#TMC14L
;;   MOVX  A,@DPTR                                               
;;	CLR   C
;;	ADD	A,#01
;;	MOVX	@DPTR,A                           
;;   MOV   DPTR,#TMC14H
;;   MOVX  A,@DPTR
;;   ADDC 	A,#0
;;	MOVX	@DPTR,A       
;;	
;;	MOV   DPTR,#TMC14H
;;	MOVX  A,@DPTR              
;;	MOV   B,A
;;   MOV   DPTR,#TMS14H
;;   MOVX  A,@DPTR
;;   CJNE  A,B,CHK_TMC14H                    ;TMR00_NOT_DONE
;;	SJMP  CHK_TMC14L
;;			
;;   CHK_TMC14H:	
;;   
;;   JC	   SET_TMR14_DONE
;;   JNC   TMR14_NOT_DONE
;;   
;;   CHK_TMC14L:
;;   
;;   MOV   DPTR,#TMC14L
;;   MOVX	A,@DPTR                               ;A,TMC00L
;;	MOV   B,A
;;	MOV   DPTR,#TMS14L
;;	MOVX  A,@DPTR
;;	CJNE  A,B,CHECK_CARRY_TM14
;;	SJMP  SET_TMR14_DONE
;;	
;;	CHECK_CARRY_TM14:
;;	
;;	JC	   SET_TMR14_DONE	
;;  
;;   TMR14_NOT_DONE:
;;	
;;	CLR	TM14D
;;	SJMP	TM14_END		
;;	
;;   SET_TMR14_DONE:	
;;   
;;   SETB	TM14D
;;	SJMP	TM14_END
;;   
;;   TMR14_NOT_ENABLED:
;;	
;;	CLR	TM14D
;;   CLR   A
;;   MOV   DPTR,#TMC14H
;;   MOVX  @DPTR,A
;;   INC   DPTR
;;   MOVX  @DPTR,A
;;
;;   TM14_END:
;;;--------------------------------------------------------------------
;;   TM15_HANDLER:
;;   
;;   JNB	TM15E,TMR15_NOT_ENABLED
;;	JB	   TM15D,TM15_END	
;;	JNB   TEN_MSEC_BIT,TM15_END
;;                  	
;;                     	
;;	MOV   DPTR,#TMC15L
;;   MOVX  A,@DPTR                                               
;;	CLR   C
;;	ADD	A,#01
;;	MOVX	@DPTR,A                           
;;   MOV   DPTR,#TMC15H
;;   MOVX  A,@DPTR
;;   ADDC 	A,#0
;;	MOVX	@DPTR,A       
;;	
;;	MOV   DPTR,#TMC15H
;;	MOVX  A,@DPTR              
;;	MOV   B,A
;;   MOV   DPTR,#TMS15H
;;   MOVX  A,@DPTR
;;   CJNE  A,B,CHK_TMC15H                    ;TMR00_NOT_DONE
;;	SJMP  CHK_TMC15L
;;			
;;   CHK_TMC15H:	
;;   
;;   JC	   SET_TMR15_DONE
;;   JNC   TMR15_NOT_DONE
;;   
;;   CHK_TMC15L:
;;   
;;   MOV   DPTR,#TMC15L
;;   MOVX	A,@DPTR                               ;A,TMC00L
;;	MOV   B,A
;;	MOV   DPTR,#TMS15L
;;	MOVX  A,@DPTR
;;	CJNE  A,B,CHECK_CARRY_TM15
;;	SJMP  SET_TMR15_DONE
;;	
;;	CHECK_CARRY_TM15:
;;	
;;	JC	   SET_TMR15_DONE	
;;  
;;   TMR15_NOT_DONE:
;;	
;;	CLR	TM15D
;;	SJMP	TM15_END		
;;	
;;   SET_TMR15_DONE:	
;;   
;;   SETB	TM15D
;;	SJMP	TM15_END
;;   
;;   TMR15_NOT_ENABLED:
;;	
;;	CLR	TM15D
;;   CLR   A
;;   MOV   DPTR,#TMC15H
;;   MOVX  @DPTR,A
;;   INC   DPTR
;;   MOVX  @DPTR,A
;;
;;   TM15_END:
;;---------------------------------------------------------------------
;   TM16_HANDLER:
;                           	
;   JNB	TM16E,TMR16_NOT_ENABLED	
;	JNB   TEN_MSEC_BIT,TM17_HANDLER
;
;	MOV   DPTR,#TMC16L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC16H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	SJMP  TM17_HANDLER
;			     
;   TMR16_NOT_ENABLED:
;	
;	CLR	TM16D
;   CLR   A
;   MOV   DPTR,#TMC16H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A

;---------------------------------------------------------------------   
   ;TM17_HANDLER:
;
;      JNB	TM17E,TMR17_NOT_ENABLED
;	JB	   TM17D,TM17_END	
;	JNB   TEN_MSEC_BIT,TM17_END
;                  	
;                     	
;	MOV   DPTR,#TMC17L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC17H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC17H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS17H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC17H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC17L
;			
;   CHK_TMC17H:	
;   
;   JC	   SET_TMR17_DONE
;   JNC   TMR17_NOT_DONE
;   
;   CHK_TMC17L:
;   
;   MOV   DPTR,#TMC17L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS17L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM17
;	SJMP  SET_TMR17_DONE
;	
;	CHECK_CARRY_TM17:
;	
;	JC	   SET_TMR17_DONE	
;  
;   TMR17_NOT_DONE:
;	
;	CLR	TM17D
;	SJMP	TM17_END		
;	
;   SET_TMR17_DONE:	
;   
;   SETB	TM17D
;	SJMP	TM17_END
;   
;   TMR17_NOT_ENABLED:
;	
;	CLR	TM17D
;   CLR   A
;   MOV   DPTR,#TMC17H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;
;   TM17_END:
;;----------------------------------------------------
;   TM20_HANDLER:
;
;   JNB	TM20E,TMR20_NOT_ENABLED
;	JB	   TM20D,TM21_HANDLER	
;	JNB   TEN_MSEC_BIT,TM21_HANDLER
;                  	
;	MOV   DPTR,#TMC20L
;   MOVX  A,@DPTR                                               
;	CLR   C
;	ADD	A,#01
;	MOVX	@DPTR,A                           
;   MOV   DPTR,#TMC20H
;   MOVX  A,@DPTR
;   ADDC 	A,#0
;	MOVX	@DPTR,A       
;	
;	MOV   DPTR,#TMC20H
;	MOVX  A,@DPTR              
;	MOV   B,A
;   MOV   DPTR,#TMS20H
;   MOVX  A,@DPTR
;   CJNE  A,B,CHK_TMC20H                    ;TMR00_NOT_DONE
;	SJMP  CHK_TMC20L
;			
;   CHK_TMC20H:	
;   
;   JC	   SET_TMR20_DONE
;   JNC   TMR20_NOT_DONE
;   
;   CHK_TMC20L:
;   
;   MOV   DPTR,#TMC20L
;   MOVX	A,@DPTR                               ;A,TMC00L
;	MOV   B,A
;	MOV   DPTR,#TMS20L
;	MOVX  A,@DPTR
;	CJNE  A,B,CHECK_CARRY_TM20
;	SJMP  SET_TMR20_DONE
;	
;	CHECK_CARRY_TM20:
;	
;	JC	   SET_TMR20_DONE	
;  
;   TMR20_NOT_DONE:
;	
;	CLR	TM20D
;	SJMP	TM21_HANDLER			
;	
;   SET_TMR20_DONE:	
;   
;   SETB	TM20D
;	SJMP	TM21_HANDLER	
;   
;   TMR20_NOT_ENABLED:
;	
;	CLR	TM20D
;   CLR   A
;   MOV   DPTR,#TMC20H
;   MOVX  @DPTR,A
;   INC   DPTR
;   MOVX  @DPTR,A
;
;   TM21_HANDLER:
;------------------------------------------------------------
   TM100_HANDLER:
   
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   JNB	TM100E,TMR100_NOT_ENABLED
	JB	   TM100D,TM100_END
	JNB   TEN_MSEC_BIT,TM100_END

	MOV   DPTR,#TMC100L
   MOVX  A,@DPTR                                               
	CLR   C
	ADD	A,#01
	MOVX	@DPTR,A                           
   MOV   DPTR,#TMC100H
   MOVX  A,@DPTR
   ADDC 	A,#0
	MOVX	@DPTR,A       
	
	MOV   DPTR,#TMC100H
	MOVX  A,@DPTR              
	MOV   B,A
   MOV   DPTR,#TMS100H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC100H                    
	SJMP  CHK_TMC100L
			
   CHK_TMC100H:	
   
   JC	   SET_TMR100_DONE
   JNC   TMR100_NOT_DONE
   
   CHK_TMC100L:
   
   MOV   DPTR,#TMC100L
   MOVX	A,@DPTR                              
	MOV   B,A
	MOV   DPTR,#TMS100L
	MOVX  A,@DPTR
	CJNE  A,B,CHECK_CARRY_TM100
	SJMP  SET_TMR100_DONE
	
	CHECK_CARRY_TM100:
	
	JC	   SET_TMR100_DONE	
  
   TMR100_NOT_DONE:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM100D
	MOVX  @DPTR,A
	SJMP	TM100_END		
	
   SET_TMR100_DONE:	
   
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	SETB	TM100D
	MOVX  @DPTR,A

	SJMP	TM100_END	
   
   TMR100_NOT_ENABLED:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM100D
	MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC100H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
  
   TM100_END:
;------------------------------------------
   TM101_HANDLER: 
  
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   JNB	 TM101E,TMR101_NOT_ENABLED
   JB	 TM101D,TM101_END
	   
   MOV   DPTR,#TMS101H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_101
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_101
   SJMP  SET_TMR101_DONE

   CHK_TM_101:
	
   JNB   TEN_MSEC_BIT,TM101_END

	MOV   DPTR,#TMC101L
   MOVX  A,@DPTR                                               
	CLR   C
	ADD	A,#01
	MOVX	@DPTR,A                           
   MOV   DPTR,#TMC101H
   MOVX  A,@DPTR
   ADDC 	A,#0
	MOVX	@DPTR,A       
	
	MOV   DPTR,#TMC101H
	MOVX  A,@DPTR              
	MOV   B,A
   MOV   DPTR,#TMS101H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC101H                    
	SJMP  CHK_TMC101L
			
   CHK_TMC101H:	
   
   JC	   SET_TMR101_DONE
   JNC   TMR101_NOT_DONE
   
   CHK_TMC101L:
   
   MOV   DPTR,#TMC101L
   MOVX	A,@DPTR                              
	MOV   B,A
	MOV   DPTR,#TMS101L
	MOVX  A,@DPTR
	CJNE  A,B,CHECK_CARRY_TM101
	SJMP  SET_TMR101_DONE
	
	CHECK_CARRY_TM101:
	
	JC	   SET_TMR101_DONE	
  
   TMR101_NOT_DONE:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM101D
	MOVX  @DPTR,A
	SJMP	TM101_END		
	
   SET_TMR101_DONE:	
   
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	SETB	TM101D
	MOVX  @DPTR,A

	SJMP	TM101_END	
   
   TMR101_NOT_ENABLED:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM101D
	MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC101H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM101_END:
;---------------------------------------------------------------- 
   TM102_HANDLER:
   
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   JNB	TM102E,TMR102_NOT_ENABLED
	JB	   TM102D,TM102_END
	   
   MOV   DPTR,#TMS102H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_102
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_102
   SJMP  SET_TMR102_DONE

   CHK_TM_102:
	
	JNB   TEN_MSEC_BIT,TM102_END

	MOV   DPTR,#TMC102L
   MOVX  A,@DPTR                                               
	CLR   C
	ADD	A,#01
	MOVX	@DPTR,A                           
   MOV   DPTR,#TMC102H
   MOVX  A,@DPTR
   ADDC 	A,#0
	MOVX	@DPTR,A       
	
	MOV   DPTR,#TMC102H
	MOVX  A,@DPTR              
	MOV   B,A
   MOV   DPTR,#TMS102H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC102H                    
	SJMP  CHK_TMC102L
			
   CHK_TMC102H:	
   
   JC	   SET_TMR102_DONE
   JNC   TMR102_NOT_DONE
   
   CHK_TMC102L:
   
   MOV   DPTR,#TMC102L
   MOVX	A,@DPTR                              
	MOV   B,A
	MOV   DPTR,#TMS102L
	MOVX  A,@DPTR
	CJNE  A,B,CHECK_CARRY_TM102
	SJMP  SET_TMR102_DONE
	
	CHECK_CARRY_TM102:
	
	JC	   SET_TMR102_DONE	
  
   TMR102_NOT_DONE:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM102D
	MOVX  @DPTR,A
	SJMP	TM102_END		
	
   SET_TMR102_DONE:	
   
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	SETB	TM102D
	MOVX  @DPTR,A

	SJMP	TM102_END	
   
   TMR102_NOT_ENABLED:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM102D
	MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC102H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A
   
   TM102_END:
;----------------------------------------------------------   
   TM103_HANDLER: 
  
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   JNB	 TM103E,TMR103_NOT_ENABLED
   JB	 TM103D,TM103_END
	   
   MOV   DPTR,#TMS103H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_103
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_103
   SJMP  SET_TMR103_DONE

   CHK_TM_103:
	
	JNB   TEN_MSEC_BIT,TM103_END

	MOV   DPTR,#TMC103L
   MOVX  A,@DPTR                                               
	CLR   C
	ADD	A,#01
	MOVX	@DPTR,A                           
   MOV   DPTR,#TMC103H
   MOVX  A,@DPTR
   ADDC 	A,#0
	MOVX	@DPTR,A       
	
	MOV   DPTR,#TMC103H
	MOVX  A,@DPTR              
	MOV   B,A
   MOV   DPTR,#TMS103H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC103H                    
	SJMP  CHK_TMC103L
			
   CHK_TMC103H:	
   
   JC	   SET_TMR103_DONE
   JNC   TMR103_NOT_DONE
   
   CHK_TMC103L:
   
   MOV   DPTR,#TMC103L
   MOVX	A,@DPTR                              
	MOV   B,A
	MOV   DPTR,#TMS103L
	MOVX  A,@DPTR
	CJNE  A,B,CHECK_CARRY_TM103
	SJMP  SET_TMR103_DONE
	
	CHECK_CARRY_TM103:
	
	JC	   SET_TMR103_DONE	
  
   TMR103_NOT_DONE:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM103D
	MOVX  @DPTR,A
	SJMP	TM103_END		
	
   SET_TMR103_DONE:	
   
   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	SETB	TM103D
	MOVX  @DPTR,A

	SJMP	TM103_END	
   
   TMR103_NOT_ENABLED:
	
	MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
	CLR	TM103D
	MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC103H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM103_END:
;--------------------------------------------
   TM104_HANDLER: 
  
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   JNB	 TM104E,TMR104_NOT_ENABLED
   JB	 TM104D,TM104_END
	   
   MOV   DPTR,#TMS104H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_104
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_104
   SJMP  SET_TMR104_DONE

   CHK_TM_104:
	
   JNB   TEN_MSEC_BIT,TM104_END

   MOV   DPTR,#TMC104L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC104H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC104H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS104H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC104H                    
   SJMP  CHK_TMC104L
			
   CHK_TMC104H:	
   
   JC	 SET_TMR104_DONE
   JNC   TMR104_NOT_DONE
   
   CHK_TMC104L:
   
   MOV   DPTR,#TMC104L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS104L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM104
   SJMP  SET_TMR104_DONE
	
   CHECK_CARRY_TM104:
	
   JC	 SET_TMR104_DONE	
  
   TMR104_NOT_DONE:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM104D
   MOVX  @DPTR,A
   SJMP  TM104_END		
	
   SET_TMR104_DONE:	
   
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   SETB	 TM104D
   MOVX  @DPTR,A

   SJMP	 TM104_END	
   
   TMR104_NOT_ENABLED:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM104D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC104H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM104_END: 
;---------------------------------------
   TM105_HANDLER: 
  
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   JNB	 TM105E,TMR105_NOT_ENABLED
   JB	 TM105D,TM105_END
	   
   MOV   DPTR,#TMS105H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_105
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_105
   SJMP  SET_TMR105_DONE

   CHK_TM_105:
	
  ; JNB   TEN_MSEC_BIT,TM105_END
   JNB   HUND_MSEC_BIT,TM105_END

   MOV   DPTR,#TMC105L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC105H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC105H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS105H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC105H                    
   SJMP  CHK_TMC105L
			
   CHK_TMC105H:	
   
   JC	 SET_TMR105_DONE
   JNC   TMR105_NOT_DONE
   
   CHK_TMC105L:
   
   MOV   DPTR,#TMC105L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS105L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM105
   SJMP  SET_TMR105_DONE
	
   CHECK_CARRY_TM105:
	
   JC	 SET_TMR105_DONE	
  
   TMR105_NOT_DONE:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM105D
   MOVX  @DPTR,A
   SJMP  TM105_END		
	
   SET_TMR105_DONE:	
   
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   SETB	 TM105D
   MOVX  @DPTR,A

   SJMP	 TM105_END	
   
   TMR105_NOT_ENABLED:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM105D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC105H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM105_END:
;---------------------------------------
   TM106_HANDLER: 
  
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   JNB	 TM106E,TMR106_NOT_ENABLED
   JB	 TM106D,TM106_END
	   
   MOV   DPTR,#TMS106H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_106
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_106
   SJMP  SET_TMR106_DONE

   CHK_TM_106:
	
   JNB   HUND_MSEC_BIT,TM106_END

   MOV   DPTR,#TMC106L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC106H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC106H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS106H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC106H                    
   SJMP  CHK_TMC106L
			
   CHK_TMC106H:	
   
   JC	 SET_TMR106_DONE
   JNC   TMR106_NOT_DONE
   
   CHK_TMC106L:
   
   MOV   DPTR,#TMC106L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS106L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM106
   SJMP  SET_TMR106_DONE
	
   CHECK_CARRY_TM106:
	
   JC	 SET_TMR106_DONE	
  
   TMR106_NOT_DONE:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM106D
   MOVX  @DPTR,A
   SJMP  TM106_END		
	
   SET_TMR106_DONE:	
   
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   SETB	 TM106D
   MOVX  @DPTR,A

   SJMP	 TM106_END	
   
   TMR106_NOT_ENABLED:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM106D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC106H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM106_END:
;----------------------------------------------
   TM107_HANDLER: 
  
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   JNB	 TM107E,TMR107_NOT_ENABLED
   JB	 TM107D,TM107_END
	   
   MOV   DPTR,#TMS107H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_107
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_107
   SJMP  SET_TMR107_DONE

   CHK_TM_107:
	
   JNB   HUND_MSEC_BIT,TM107_END

   MOV   DPTR,#TMC107L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC107H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC107H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS107H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC107H                    
   SJMP  CHK_TMC107L
			
   CHK_TMC107H:	
   
   JC	 SET_TMR107_DONE
   JNC   TMR107_NOT_DONE
   
   CHK_TMC107L:
   
   MOV   DPTR,#TMC107L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS107L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM107
   SJMP  SET_TMR107_DONE
	
   CHECK_CARRY_TM107:
	
   JC	 SET_TMR107_DONE	
  
   TMR107_NOT_DONE:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM107D
   MOVX  @DPTR,A
   SJMP  TM107_END		
	
   SET_TMR107_DONE:	
   
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   SETB	 TM107D
   MOVX  @DPTR,A

   SJMP	 TM107_END	
   
   TMR107_NOT_ENABLED:
	
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   CLR	 TM107D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC107H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM107_END:
;----------------------------------
   TM108_HANDLER: 
  
   MOV   DPTR,#TM108_ENABLE
   MOVX  A,@DPTR
   JNB	 TM108E,TMR108_NOT_ENABLED
   JB	 TM108D,TM108_END
	   
   MOV   DPTR,#TMS108H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_108
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_108
   SJMP  SET_TMR108_DONE

   CHK_TM_108:
	
   JNB   HUND_MSEC_BIT,TM108_END

   MOV   DPTR,#TMC108L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC108H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC108H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS108H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC108H                    
   SJMP  CHK_TMC108L
			
   CHK_TMC108H:	
   
   JC	 SET_TMR108_DONE
   JNC   TMR108_NOT_DONE
   
   CHK_TMC108L:
   
   MOV   DPTR,#TMC108L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS108L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM108
   SJMP  SET_TMR108_DONE
	
   CHECK_CARRY_TM108:
	
   JC	 SET_TMR108_DONE	
  
   TMR108_NOT_DONE:
	
   MOV   DPTR,#TM108_ENABLE
   MOVX  A,@DPTR
   CLR	 TM108D
   MOVX  @DPTR,A
   SJMP  TM108_END		
	
   SET_TMR108_DONE:	
   
   MOV   DPTR,#TM108_ENABLE
   MOVX  A,@DPTR
   SETB	 TM108D
   MOVX  @DPTR,A

   SJMP	 TM108_END	
   
   TMR108_NOT_ENABLED:
	
   MOV   DPTR,#TM108_ENABLE
   MOVX  A,@DPTR
   CLR	 TM108D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC108H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM108_END:                   
 ;--------------------------------                                
           
   TM109_HANDLER: 
  
   MOV   DPTR,#TM109_ENABLE
   MOVX  A,@DPTR
   JNB	 TM109E,TMR109_NOT_ENABLED
   JB	 TM109D,TM109_END
	   
   MOV   DPTR,#TMS109H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_109
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_109
   SJMP  SET_TMR109_DONE

   CHK_TM_109:
	
   JNB   HUND_MSEC_BIT,TM109_END

   MOV   DPTR,#TMC109L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC109H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC109H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS109H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC109H                    
   SJMP  CHK_TMC109L
			
   CHK_TMC109H:	
   
   JC	 SET_TMR109_DONE
   JNC   TMR109_NOT_DONE
   
   CHK_TMC109L:
   
   MOV   DPTR,#TMC109L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS109L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM109
   SJMP  SET_TMR109_DONE
	
   CHECK_CARRY_TM109:
	
   JC	 SET_TMR109_DONE	
  
   TMR109_NOT_DONE:
	
   MOV   DPTR,#TM109_ENABLE
   MOVX  A,@DPTR
   CLR	 TM109D
   MOVX  @DPTR,A
   SJMP  TM109_END		
	
   SET_TMR109_DONE:	
   
   MOV   DPTR,#TM109_ENABLE
   MOVX  A,@DPTR
   SETB	 TM109D
   MOVX  @DPTR,A

   SJMP	 TM109_END	
   
   TMR109_NOT_ENABLED:
	
   MOV   DPTR,#TM109_ENABLE
   MOVX  A,@DPTR
   CLR	 TM109D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC109H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM109_END:
;-------------------------------------

   TM110_HANDLER: 
  
   MOV   DPTR,#TM110_ENABLE
   MOVX  A,@DPTR
   JNB	 TM110E,TMR110_NOT_ENABLED
   JB	 TM110D,TM110_END
	   
   MOV   DPTR,#TMS110H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_110
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_110
   SJMP  SET_TMR110_DONE

   CHK_TM_110:
	
   JNB   HUND_MSEC_BIT,TM110_END

   MOV   DPTR,#TMC110L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC110H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC110H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS110H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC110H                    
   SJMP  CHK_TMC110L
			
   CHK_TMC110H:	
   
   JC	 SET_TMR110_DONE
   JNC   TMR110_NOT_DONE
   
   CHK_TMC110L:
   
   MOV   DPTR,#TMC110L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS110L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM110
   SJMP  SET_TMR110_DONE
	
   CHECK_CARRY_TM110:
	
   JC	 SET_TMR110_DONE	
  
   TMR110_NOT_DONE:
	
   MOV   DPTR,#TM110_ENABLE
   MOVX  A,@DPTR
   CLR	 TM110D
   MOVX  @DPTR,A
   SJMP  TM110_END		
	
   SET_TMR110_DONE:	
   
   MOV   DPTR,#TM110_ENABLE
   MOVX  A,@DPTR
   SETB	 TM110D
   MOVX  @DPTR,A

   SJMP	 TM110_END	
   
   TMR110_NOT_ENABLED:
	
   MOV   DPTR,#TM110_ENABLE
   MOVX  A,@DPTR
   CLR	 TM110D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC110H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM110_END:
;--------------------------------------

   TM111_HANDLER: 
  
   MOV   DPTR,#TM111_ENABLE
   MOVX  A,@DPTR
   JNB	 TM111E,TMR111_NOT_ENABLED
   JB	 TM111D,TM111_END
	   
   MOV   DPTR,#TMS111H
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_111
   INC   DPTR
   MOVX  A,@DPTR
   CJNE  A,#0,CHK_TM_111
   SJMP  SET_TMR111_DONE

   CHK_TM_111:
	
   JNB   HUND_MSEC_BIT,TM111_END

   MOV   DPTR,#TMC111L
   MOVX  A,@DPTR                                               
   CLR   C
   ADD	 A,#01
   MOVX	 @DPTR,A                           
   MOV   DPTR,#TMC111H
   MOVX  A,@DPTR
   ADDC  A,#0
   MOVX	 @DPTR,A       
	
   MOV   DPTR,#TMC111H
   MOVX  A,@DPTR              
   MOV   B,A
   MOV   DPTR,#TMS111H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC111H                    
   SJMP  CHK_TMC111L
			
   CHK_TMC111H:	
   
   JC	 SET_TMR111_DONE
   JNC   TMR111_NOT_DONE
   
   CHK_TMC111L:
   
   MOV   DPTR,#TMC111L
   MOVX	 A,@DPTR                              
   MOV   B,A
   MOV   DPTR,#TMS111L
   MOVX  A,@DPTR
   CJNE  A,B,CHECK_CARRY_TM111
   SJMP  SET_TMR111_DONE
	
   CHECK_CARRY_TM111:
	
   JC	 SET_TMR111_DONE	
  
   TMR111_NOT_DONE:
	
   MOV   DPTR,#TM111_ENABLE
   MOVX  A,@DPTR
   CLR	 TM111D
   MOVX  @DPTR,A
   SJMP  TM111_END		
	
   SET_TMR111_DONE:	
   
   MOV   DPTR,#TM111_ENABLE
   MOVX  A,@DPTR
   SETB	 TM111D
   MOVX  @DPTR,A

   SJMP	 TM111_END	
   
   TMR111_NOT_ENABLED:
	
   MOV   DPTR,#TM111_ENABLE
   MOVX  A,@DPTR
   CLR	 TM111D
   MOVX  @DPTR,A

   CLR   A
   MOV   DPTR,#TMC111H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A


   TM111_END:
;-------------------------------------------------------------
   TM112_HANDLER:
   
   MOV   DPTR,#TM112_ENABLE
   MOVX  A,@DPTR
   JNB	 TM112E,TMR112_NOT_ENABLED
   JB	 TM112D,TM112_END	
   JNB   HUND_MSEC_BIT,TM112_END
        
	MOV   DPTR,#TMC112L
   MOVX  A,@DPTR                                               
	CLR   C
	ADD	A,#01
	MOVX	@DPTR,A                           
   MOV   DPTR,#TMC112H
   MOVX  A,@DPTR
   ADDC 	A,#0
	MOVX	@DPTR,A       
	
	MOV   DPTR,#TMC112H
	MOVX  A,@DPTR              
	MOV   B,A
   MOV   DPTR,#TMS112H
   MOVX  A,@DPTR
   CJNE  A,B,CHK_TMC112H                    ;TMR00_NOT_DONE
	SJMP  CHK_TMC112L
			
   CHK_TMC112H:	
   
   JC	   SET_TMR112_DONE
   JNC   TMR112_NOT_DONE
   
   CHK_TMC112L:
   
   MOV   DPTR,#TMC112L
   MOVX	A,@DPTR                               ;A,TMC00L
	MOV   B,A
	MOV   DPTR,#TMS112L
	MOVX  A,@DPTR
	CJNE  A,B,CHECK_CARRY_TM112
	SJMP  SET_TMR112_DONE
	
	CHECK_CARRY_TM112:
	
	JC	   SET_TMR112_DONE	
  
   TMR112_NOT_DONE:
	
   MOV   DPTR,#TM112_ENABLE
   MOVX  A,@DPTR
   CLR	 TM112D
   MOVX  @DPTR,A
   SJMP	 TM112_END			
	
   SET_TMR112_DONE:	
   
   MOV   DPTR,#TM112_ENABLE
   MOVX  A,@DPTR
   SETB	 TM112D
   MOVX  @DPTR,A
   SJMP	 TM112_END
   
   TMR112_NOT_ENABLED:
	
   MOV   DPTR,#TM112_ENABLE
   MOVX  A,@DPTR
   CLR	 TM112D
   MOVX  @DPTR,A
   CLR   A
   MOV   DPTR,#TMC112H
   MOVX  @DPTR,A
   INC   DPTR
   MOVX  @DPTR,A   

   TM112_END:

   RET
;---------------------------------------------------------------
;----------------------------------------------------------------------
;****************************************************************************
;UPDATE COUNTERS
;****************************************************************************
RCLK00			EQU	01H	;RISING CLOCK SIGNAL FOR ALL
RCLK01			EQU	02H	;COUNTER WILL BE STORED IN
RCLK02			EQU	04H	;ONE BYTE LOCATION WE WILL
RCLK03			EQU	08H	;AND THAT LOCATION WITH RCLKxx
RCLK04			EQU	10H	;TO CHECK IF RISING EDGE IS 
RCLK05			EQU	20H	;DETECTED AT CLK INPUT OF
RCLK06			EQU	40H	;COUNTER xx
RCLK07			EQU	80H

   CTR_HANDLER:	
   
   MOV	A,CTR_PREV_CLK
	MOV	CTR_PREV_CLK,CTR_CLK
	CPL	A
	ANL	A,CTR_CLK
	MOV	R7,A	;STORE RISING CLOCK PULSES IN R7
;---------------------------------------------------------------  

  CT00_CHK:	
   
  MOV   A,CTR_RESET
   JNB	CT00R,CT00_UPDATE
	CLR   A
	MOV	DPTR,#CTC00H                                ;R0 ,#CTC00L
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE                       ;COUNTER0_1
	CLR	CT00D
	MOV   CTR_DONE,A
	SJMP	CT01_CHK
   
   CT00_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT00D,CT01_CHK
	MOV	A,R7
	ANL	A,#RCLK00
	JZ	   CT01_CHK
	MOV	DPTR,#CTC00L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC00H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT00_DONE:	
   
   
	MOV	DPTR,#CTS00L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC00L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS00H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC00H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT01_CHK
	MOV   A,CTR_DONE
	SETB	CT00D
	MOV   CTR_DONE,A


;*************************************************	
   CT01_CHK:	
   
   MOV   A,CTR_RESET
   JNB	CT01R,CT01_UPDATE
	CLR   A
	MOV	DPTR,#CTC01H                                ;R0 ,#CTC00L
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT01D
	MOV   CTR_DONE,A
	SJMP	CT02_CHK
   
   CT01_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT01D,CT02_CHK
	MOV	A,R7
	ANL	A,#RCLK01
	JZ	   CT02_CHK
	MOV	DPTR,#CTC01L
	MOVX	A,@DPTR
        ADD	A,NO_OF_CAVITY
	;ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC01H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT01_DONE:	
   
   
	MOV	DPTR,#CTS01L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC01L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS01H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC01H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT02_CHK
	MOV   A,CTR_DONE
	SETB	CT01D
	MOV   CTR_DONE,A
;******************************************************	
   CT02_CHK:	
   
   MOV   A,CTR_RESET
   JNB	CT02R,CT02_UPDATE
	CLR   A
	MOV	DPTR,#CTC02H                                ;R0 ,#CTC00L
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT02D
	MOV   CTR_DONE,A
	SJMP	CT03_CHK
   
   CT02_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT02D,CT03_CHK
	MOV	A,R7
	ANL	A,#RCLK02
	JZ	   CT03_CHK
	MOV	DPTR,#CTC02L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC02H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT02_DONE:	
   
   
	MOV	DPTR,#CTS02L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC02L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS02H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC02H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT03_CHK
	MOV   A,CTR_DONE
	SETB	CT02D
	MOV   CTR_DONE,A
;--------------------------------------------
   CT03_CHK:

   MOV   A,CTR_RESET
   JNB	CT03R,CT03_UPDATE
	CLR   A	
	MOV	DPTR,#CTC03H                                
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT03D
	MOV   CTR_DONE,A
	SJMP	CT04_CHK
   
   CT03_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT03D,CT04_CHK
	MOV	A,R7
	ANL	A,#RCLK03
	JZ	   CT04_CHK
	MOV	DPTR,#CTC03L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC03H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT03_DONE:	
   
   
	MOV	DPTR,#CTS03L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC03L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS03H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC03H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT04_CHK
	MOV   A,CTR_DONE
	SETB	CT03D
	MOV   CTR_DONE,A  
;---------------------------------------------------------------------------
   CT04_CHK:

   MOV   A,CTR_RESET
   JNB	CT04R,CT04_UPDATE
	CLR   A	
	MOV	DPTR,#CTC04H                                
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT04D
	MOV   CTR_DONE,A
	SJMP	CT05_CHK
   
   CT04_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT04D,CT05_CHK
	MOV	A,R7
	ANL	A,#RCLK04
	JZ	   CT05_CHK
	MOV	DPTR,#CTC04L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC04H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT04_DONE:	
   
   
	MOV	DPTR,#CTS04L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC04L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS04H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC04H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT05_CHK
	MOV   A,CTR_DONE
	SETB	CT04D
	MOV   CTR_DONE,A  
;-------------------------------------------------------------------
    
   CT05_CHK:
   
   MOV   A,CTR_RESET
   JNB	CT05R,CT05_UPDATE
	CLR   A	
	MOV	DPTR,#CTC05H                                
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT05D
	MOV   CTR_DONE,A
	SJMP	CT06_CHK
   
   CT05_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT05D,CT06_CHK
	MOV	A,R7
	ANL	A,#RCLK05
	JZ	   CT06_CHK
	MOV	DPTR,#CTC05L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC05H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT05_DONE:	
   
   
	MOV	DPTR,#CTS05L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC05L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS05H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC05H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT06_CHK
	MOV   A,CTR_DONE
	SETB	CT05D
	MOV   CTR_DONE,A  

;-----------------------------------------------------------------   
   CT06_CHK:	
   
   MOV   A,CTR_RESET
   JNB	CT06R,CT06_UPDATE
	CLR   A
	MOV	DPTR,#CTC06H                                ;R0 ,#CTC00L
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT06D
	MOV   CTR_DONE,A
	SJMP	CT07_CHK
   
   CT06_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT06D,CT07_CHK
	MOV	A,R7
	ANL	A,#RCLK06
	JZ	   CT07_CHK
	MOV	DPTR,#CTC06L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC06H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT06_DONE:	
   
   
	MOV	DPTR,#CTS06L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC06L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS06H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC06H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT07_CHK
	MOV   A,CTR_DONE
	SETB	CT06D
	MOV   CTR_DONE,A

;--------------------------------------------------------   
   
   CT07_CHK:
   
   MOV   A,CTR_RESET
   JNB	CT07R,CT07_UPDATE
	CLR   A	
	MOV	DPTR,#CTC07H                                
	MOVX	@DPTR,A                      
	INC	DPTR
	MOVX	@DPTR,A     
	MOV   A,CTR_DONE
	CLR	CT07D
	MOV   CTR_DONE,A
	SJMP	CT08_CHK
   
   CT07_UPDATE:	
   
   MOV   A,CTR_DONE
   JB	   CT07D,CT08_CHK
	MOV	A,R7
	ANL	A,#RCLK07
	JZ	   CT08_CHK
	MOV	DPTR,#CTC07L
	MOVX	A,@DPTR
	ADD	A,#01H
	MOVX	@DPTR,A
	MOV	DPTR,#CTC07H
	MOVX	A,@DPTR
	ADDC	A,#00H
	MOVX	@DPTR,A
   
   CT07_DONE:	
   
   
	MOV	DPTR,#CTS07L
   MOVX  A,@DPTR
   MOV   R1,A
   MOV   DPTR,#CTC07L
	MOVX	A,@DPTR
	CLR	C
	SUBB	A,R1
	MOV	DPTR,#CTS07H
   MOVX  A,@DPTR
   MOV   R1,A
	MOV   DPTR,#CTC07H
	MOVX	A,@DPTR
	SUBB	A,R1
	JC	   CT08_CHK
	MOV   A,CTR_DONE
	SETB	CT07D
	MOV   CTR_DONE,A  

   CT08_CHK:
   RET
;-------------------------------------------------------

   PROD_COUNTER:
;--------------------------------------------------
;COUNTER 02 CAN BE USED FOR HOURLY PRODUCTION COUNTER
;--------------------------------------------------
   MOV	 C,HIGHBLOW_OP
   ANL   C,AUTO_MAN_SEL
   
   MOV   A,CTR_CLK
   MOV	 CT02C,C
   MOV   CTR_CLK,A
;----------------------------------
   MOV	 C,HIGHBLOW_OP
   ANL   C,AUTO_MAN_SEL
  ; ORL   C,INP0
   
   MOV   A,CTR_CLK
   MOV	 CT01C,C
   MOV   CTR_CLK,A
;-----------------
   MOV   A,CTR_DONE
   MOV	 C,CT01D
   MOV   A,CTR_RESET
   MOV	 CT01R,C
   CLR   CT00R
   MOV   CTR_RESET,A
;-----------------
   MOV   A,CTR_DONE
   MOV	 C,CT01D
   MOV   A,CTR_CLK
   MOV	 CT00C,C
   MOV   CTR_CLK,A
   RET
;---------------------------------------------------

        DELAY_10MS:

        MOV    R7,#20
        
        DELAY_LOOP:
        
        NOP
        NOP
        DJNZ   R7,DELAY_LOOP
        RET
;---------------------------------------------------------------
        POWER_CONTROL:
  	
  	
  	LCALL  CONV_TO_POWER
  	
        MOV     DPTR,#TM100_ENABLE
        MOVX    A,@DPTR
        MOV     C,HEATER_SOFT_START_TM101D                 ;TM18D
        CPL     C
        MOV     HEATER_SOFT_START_TM101E,C

        MOVX    @DPTR,A
  	MOV    DPTR,#TM100_ENABLE
        MOVX   A,@DPTR
  	JB     HEATER_SOFT_START_TM101D,DO_SSTART

        SKIP_SSTART:

        RET	
;   
;
;   
        DO_SSTART:	
;;------------------------------------------------------------------------------------   
	JB    HEATER_ON_OFF,HEATER_NORMAL_0
        
        MOV   DPTR,#ZONE1_ACT_L     ;CH20L
        SJMP  DEC_POWER0
		
	HEATER_NORMAL_0:	
	
	JNB   ZONE1_POW_CHG,SS0_OVER          ; SSTART_1
        MOV   DPTR,#ZONE1_SET_L
	MOVX  A,@DPTR
	MOV   R5,A
	MOV   DPTR,#ZONE1_ACT_L
	MOVX  A,@DPTR   
	CLR   C
	SUBB  A,R5                            ;A,@R1
	JZ    SS0_OVER
	JC    INC_POWER0
   
        DEC_POWER0:
	
	MOVX  A,@DPTR
	JZ    DONT_DECREMENT
	DEC   A

	DONT_DECREMENT:
	
        MOVX  @DPTR,A
   
        LD_NEW_PWR0:	
	
	LCALL XLT_POWER
        MOV   DPTR,#POW_CNTL_ADD_Z1
        MOVX  @DPTR,A
	SJMP  SSTART_1
   
        INC_POWER0:
	
        MOVX  A,@DPTR

	INC   A
        MOVX  @DPTR,A
        SJMP  LD_NEW_PWR0
   
        SS0_OVER:	
   
        CLR   ZONE1_POW_CHG
        MOV   DPTR,#ZONE1_ACT_L
        MOVX  A,@DPTR
        SJMP  LD_NEW_PWR0

;-----------------------------------------------------------------------------------------------
        SSTART_1:	
   
        JB    HEATER_ON_OFF,HEATER_NORMAL_1
        MOV   DPTR,#ZONE2_ACT_L
        SJMP  DEC_POWER1
   
        HEATER_NORMAL_1:

        JNB   ZONE2_POW_CHG,SS1_OVER                           ;SSTART_2
        MOV   DPTR,#ZONE2_SET_L
        MOVX  A,@DPTR
        MOV   R5,A
        MOV   DPTR,#ZONE2_ACT_L
        MOVX  A,@DPTR                  
        CLR   C
        SUBB  A,R5                            
        JZ    SS1_OVER
        JC    INC_POWER1
   
        DEC_POWER1:
	
        MOVX  A,@DPTR
        JZ    DONT_DECREMENT_1
        DEC   A

        DONT_DECREMENT_1:
	
        MOVX  @DPTR,A

   
        LD_NEW_PWR1:

        LCALL  XLT_POWER
        MOV    DPTR,#POW_CNTL_ADD_Z2
        MOVX   @DPTR,A
        SJMP   SSTART_2
   
        INC_POWER1:

        MOVX  A,@DPTR
        INC   A
        MOVX  @DPTR,A
        SJMP  LD_NEW_PWR1	
   
        SS1_OVER:	
   
        CLR    ZONE2_POW_CHG
        MOV    DPTR,#ZONE2_ACT_L
        MOVX   A,@DPTR
        SJMP   LD_NEW_PWR1

;----------------------------------------------------------------------
        SSTART_2:	
  
        JB     HEATER_ON_OFF,HEATER_NORMAL_2
	MOV    DPTR,#ZONE3_ACT_L
        SJMP   DEC_POWER2
   
        HEATER_NORMAL_2:
   
        JNB    ZONE3_POW_CHG,SS2_OVER                        
        MOV    DPTR,#ZONE3_SET_L
	MOVX   A,@DPTR
	MOV    R5,A
	MOV    DPTR,#ZONE3_ACT_L
	MOVX   A,@DPTR                  
	CLR    C
	SUBB   A,R5               	
	JZ     SS2_OVER
	JC     INC_POWER2
   
        DEC_POWER2:	
   
 	MOVX   A,@DPTR
	JZ     DONT_DECREMENT_2
	DEC    A

	DONT_DECREMENT_2:
	
	MOVX	@DPTR,A
   
        LD_NEW_PWR2:
	
	LCALL	XLT_POWER
 
        MOV     DPTR,#POW_CNTL_ADD_Z3
        MOVX    @DPTR,A
	SJMP	SSTART_3
   
        INC_POWER2:	
   
        MOVX	A,@DPTR
	INC	A
	MOVX	@DPTR,A
	SJMP    LD_NEW_PWR2
  
        SS2_OVER:	 
   
        CLR	ZONE3_POW_CHG
        MOV	DPTR,#ZONE3_ACT_L
        MOVX    A,@DPTR
        SJMP    LD_NEW_PWR2
;---------------------------------------------------------------------------------
        SSTART_3:	
    
        JB     HEATER_ON_OFF,HEATER_NORMAL_3
	MOV    DPTR,#ZONE4_ACT_L
        SJMP   DEC_POWER3
   
        HEATER_NORMAL_3:
  
        JNB    ZONE4_POW_CHG,SS3_OVER                                                             
        MOV    DPTR,#ZONE4_SET_L
	MOVX   A,@DPTR
	MOV    R5,A
	MOV    DPTR,#ZONE4_ACT_L
	MOVX   A,@DPTR                  
	CLR    C
	SUBB   A,R5               	
	JZ     SS3_OVER
	JC     INC_POWER3
   
        DEC_POWER3:	
   
 	MOVX   A,@DPTR
	JZ     DONT_DECREMENT_3
	DEC    A

	DONT_DECREMENT_3:
	
	MOVX	@DPTR,A
   
        LD_NEW_PWR3:	
   
        LCALL	XLT_POWER
	MOV     DPTR,#POW_CNTL_ADD_Z4
	MOVX    @DPTR,A
	SJMP	SSTART_4                      
   
        INC_POWER3:	
   
        MOVX	A,@DPTR
	INC	A
	MOVX	@DPTR,A
	SJMP	LD_NEW_PWR3
   
        SS3_OVER:	
   
        CLR	ZONE4_POW_CHG
        MOV	DPTR,#ZONE4_ACT_L
        MOVX    A,@DPTR
        SJMP    LD_NEW_PWR3

;------------------------------------------------------------------------------
        SSTART_4:
   
        JB      HEATER_ON_OFF,HEATER_NORMAL_4
	MOV	DPTR,#ZONE5_ACT_L            ;CH24L
        SJMP    DEC_POWER4
   
        HEATER_NORMAL_4:

        JNB	ZONE5_POW_CHG,SS4_OVER                     
        MOV     DPTR,#ZONE5_SET_L
	MOVX    A,@DPTR
	MOV     R5,A
	MOV     DPTR,#ZONE5_ACT_L                          
	MOVX    A,@DPTR                  
	CLR	C
	SUBB	A,R5               
	JZ	SS4_OVER
	JC	INC_POWER4
   
        DEC_POWER4:	
   
  	MOVX	A,@DPTR
	JZ      DONT_DECREMENT_4
	DEC	A

	DONT_DECREMENT_4:
	
	MOVX	@DPTR,A
   
        LD_NEW_PWR4:	
   
        LCALL	XLT_POWER
        MOV     DPTR,#POW_CNTL_ADD_Z5
        MOVX    @DPTR,A

	SJMP	 SSTART_5                                              ;OUT_OPS
   
        INC_POWER4:	
   
        MOVX	A,@DPTR
	INC	A
	MOVX	@DPTR,A
	SJMP	LD_NEW_PWR4
   
        SS4_OVER:	
   
        CLR	ZONE5_POW_CHG
        MOV	DPTR,#ZONE5_ACT_L                              
        MOVX    A,@DPTR
        SJMP    LD_NEW_PWR4


;------------------------------------------------------------------------------------------
        SSTART_5:

        JB      HEATER_ON_OFF,HEATER_NORMAL_5
	MOV	DPTR,#ZONE6_ACT_L                      
        SJMP    DEC_POWER5
   
        HEATER_NORMAL_5:

        JNB	ZONE6_POW_CHG,SS5_OVER              
        MOV     DPTR,#ZONE6_SET_L
	MOVX    A,@DPTR
	MOV     R5,A
	MOV     DPTR,#ZONE6_ACT_L 
	MOVX    A,@DPTR                  
	CLR	C
	SUBB	A,R5               	
	JZ	SS5_OVER
	JC	INC_POWER5
   
        DEC_POWER5:	
   
 	MOVX	A,@DPTR
	JZ      DONT_DECREMENT_5
	DEC	A

	DONT_DECREMENT_5:
	
	MOVX	@DPTR,A
   
        LD_NEW_PWR5:	
   
        LCALL	XLT_POWER
        MOV     DPTR,#POW_CNTL_ADD_Z6
        MOVX    @DPTR,A

	SJMP	SSTART6                             
   
        INC_POWER5:	
   
        MOVX	A,@DPTR
	INC	A
	MOVX	@DPTR,A
	SJMP	LD_NEW_PWR5
   
        SS5_OVER:	
   
        CLR	ZONE6_POW_CHG  
        MOV	DPTR,#ZONE6_ACT_L 
        MOVX    A,@DPTR
        SJMP    LD_NEW_PWR5
;-----------------------------------------------------------------------------
        SSTART6:
    
        JB      HEATER_ON_OFF,HEATER_NORMAL_6
	MOV	DPTR,#ZONE7_ACT_L                          
        SJMP    DEC_POWER6
   
        HEATER_NORMAL_6:

        JNB	ZONE7_POW_CHG,SS6_OVER                  
        MOV     DPTR,#ZONE7_SET_L
	MOVX    A,@DPTR
	MOV     R5,A
	MOV     DPTR,#ZONE7_ACT_L                    ;CH26L
	MOVX    A,@DPTR                  
	CLR	C
	SUBB	A,R5               
	JZ	SS6_OVER
	JC	INC_POWER6
   
        DEC_POWER6:	
   
 	MOVX	A,@DPTR
	JZ      DONT_DECREMENT_6
	DEC	A

	DONT_DECREMENT_6:
	
	MOVX	@DPTR,A
   
        LD_NEW_PWR6:	
   
        LCALL	XLT_POWER
        MOV     DPTR,#POW_CNTL_ADD_Z7
        MOVX    @DPTR,A
	SJMP	SSTART7                 
   
        INC_POWER6:	
   
        MOVX	A,@DPTR
	INC	A
	MOVX	@DPTR,A
	SJMP	LD_NEW_PWR6
   
        SS6_OVER:	
   
        CLR	ZONE7_POW_CHG
        MOV	DPTR,#ZONE7_ACT_L                   ;CH26L
        MOVX    A,@DPTR
        SJMP    LD_NEW_PWR6
;-----------------------------------------------------------------------------------------
        SSTART7:
    
        JB      HEATER_ON_OFF,HEATER_NORMAL_7
	MOV     DPTR,#ZONE8_ACT_L                     
        SJMP    DEC_POWER7
   
        HEATER_NORMAL_7:

        JNB	ZONE8_POW_CHG,SS7_OVER       
        MOV     DPTR,#ZONE8_SET_L
	MOVX    A,@DPTR
	MOV     R5,A
	MOV     DPTR,#ZONE8_ACT_L                        
	MOVX    A,@DPTR                  
	CLR	C
	SUBB	A,R5               	
	JZ	SS7_OVER
	JC	INC_POWER7
   
        DEC_POWER7:	
   
 	MOVX	A,@DPTR
	JZ      DONT_DECREMENT_7
	DEC	A

	DONT_DECREMENT_7:
	
	MOVX	@DPTR,A
   
        LD_NEW_PWR7:	
   
        LCALL	XLT_POWER
        MOV     DPTR,#POW_CNTL_ADD_Z8
        MOVX    @DPTR,A
	SJMP	SSTART8
   
        INC_POWER7:	
   
        MOVX	A,@DPTR
	INC	A
	MOVX	@DPTR,A
	SJMP	LD_NEW_PWR7
   
        SS7_OVER:	
        
        CLR	ZONE8_POW_CHG
        MOV	DPTR,#ZONE8_ACT_L                            ;CH27L
        MOVX    A,@DPTR
        SJMP    LD_NEW_PWR7
  	
;--------------------------------------------------   
        SSTART8:

        RET

;---------------------------------------------------
;        OUT_OPS:
   
;        MOV     DPTR,#TM100_ENABLE
;        MOVX    A,@DPTR
;        MOV     C,HEATER_SOFT_START_TM101D                 ;TM18D
;        CPL     C
;        MOV     HEATER_SOFT_START_TM101E,C
;        MOVX    @DPTR,A
        RET

;-------------------------------------------------------------------------------
   DELAY_200MS:
   
   MOV   R7,#0FFH
   
   DLY2:
   
   MOV   R6,#0FFH
   
   DLY1:
   
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP   
   DJNZ  R6,DLY1
   DJNZ  R7,DLY2
   RET

;****************************************************************************
;CONVERT SETTINGS IN CH08, CH09, CH10, CH11 TO EQUIVALENT POWER IN CM0,CM1,CM2,TM0 
;& SETS OR RESETS BIT 32,33,34,35 DEPENDING UPON WHETHER THE POWER HAS BEEN CHANGED OR NOT
;*****************************************************************************
   
        CONV_TO_POWER:
   
        CLR   A
        MOV   DPTR,#ZONE1_SET_H
        MOVX  @DPTR,A
	MOV   DPTR,#ZONE2_SET_H
	MOVX  @DPTR,A
	MOV   DPTR,#ZONE3_SET_H
	MOVX  @DPTR,A
	MOV   DPTR,#ZONE4_SET_H
        MOVX  @DPTR,A
	MOV   DPTR,#ZONE5_SET_H
	MOVX  @DPTR,A
	MOV   DPTR,#ZONE6_SET_H
	MOVX  @DPTR,A
	MOV   DPTR,#ZONE7_SET_H
	MOVX  @DPTR,A
	MOV   DPTR,#ZONE8_SET_H
	MOVX  @DPTR,A


;--------------------------------------------	
;CHECKING OF POWER ZONE 1 STARTS HERE
;--------------------------------------------
        MOV	DPTR,#ZONE1_SET_L
	MOVX	A,@DPTR 
        MOV	DPTR,#ZONE1_ACT_L                        ;CH20L
	SETB	ZONE1_POW_CHG                  ;RLY25
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR0_CHANGED
	CLR	ZONE1_POW_CHG
   
        PWR0_CHANGED:
;----------------------------------------------------------------------------------	
;CHECKING OF POWER ZONE 2 STARTS HERE
;----------------------------------------------------------------------------------	
	MOV	DPTR,#ZONE2_SET_L	
	MOVX	A,@DPTR 
        MOV	DPTR,#ZONE2_ACT_L                ;CH21L
	SETB	ZONE2_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR1_CHANGED
	CLR	ZONE2_POW_CHG
   
        PWR1_CHANGED:
;-----------------------------------------------------------------------------------------	
;CHECKING OF POWER ZONE 3 STARTS HERE
;----------------------------------------------------------------------------------------	
	MOV     DPTR,#ZONE3_SET_L
	MOVX	A,@DPTR
        MOV	DPTR,#ZONE3_ACT_L                     ;CH22L
	SETB	ZONE3_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR2_CHANGED
	CLR	ZONE3_POW_CHG
   
        PWR2_CHANGED:	
;-------------------------------------------------------------------------------   
;POWER ZONE 4 STARTS HERE
;-------------------------------------------------------------------------------   
        MOV     DPTR,#ZONE4_SET_L	
	MOVX	A,@DPTR	
	MOV	DPTR,#ZONE4_ACT_L 
	SETB	ZONE4_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR3_CHANGED
	CLR	ZONE4_POW_CHG
   
        PWR3_CHANGED:	
;-------------------------------------------------------------------------
;POWER ZONE 5 STARTS HERE
;-------------------------------------------------------------------------
        MOV	DPTR,#ZONE5_SET_L
	MOVX	A,@DPTR  
        MOV	DPTR,#ZONE5_ACT_L                                        
	SETB	ZONE5_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR4_CHANGED
	CLR	ZONE5_POW_CHG
   
        PWR4_CHANGED:

;--------------------------------------------------------------------------   
;POWER ZONE 6 STARTS HERE
;--------------------------------------------------------------------------   
        MOV	DPTR,#ZONE6_SET_L
	MOVX	A,@DPTR
        MOV	DPTR,#ZONE6_ACT_L                     
	SETB	ZONE6_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR5_CHANGED
	CLR	ZONE6_POW_CHG
   
        PWR5_CHANGED:

;----------------------------------------------------------   
;POWER ZONE 7 STARTS HERE
;-----------------------------------------------------------   
        MOV	DPTR,#ZONE7_SET_L
	MOVX	A,@DPTR   
        MOV	DPTR,#ZONE7_ACT_L                     ;CH26L
	SETB	ZONE7_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR6_CHANGED
	CLR	ZONE7_POW_CHG
   
        PWR6_CHANGED:
;------------------------------------------------------------
;POWER ZONE 8 STARTS HERE
;------------------------------------------------------------   
   
        MOV	DPTR,#ZONE8_SET_L
	MOVX	A,@DPTR  
        MOV	DPTR,#ZONE8_ACT_L                        ;CH27L
	SETB	ZONE8_POW_CHG
	MOV	B,A
	MOVX	A,@DPTR
	CJNE	A,B,PWR7_CHANGED
	CLR	ZONE8_POW_CHG
   
        PWR7_CHANGED:
        
        RET


;*****************************************************************************************
;XLT_POWER ROUTINE WILL READ POWER DATA FROM  THE LOOK UP TABLE & STORE IN TEMP_0 & ACC   UTPAL
;-----------------------------------------------------------------------------------------   
       XLT_POWER:	

	RL      A
	INC	A
	INC	A
	MOVC	A,@A+PC
	RET

	
   POWER_TABLE:
        DW	255   ;0
	DW      245;242   ;1  1V
	DW  	243;234   ;2  3V
	DW  	241;228   ;3  9V
	DW 	239;223   ;4  11V
	DW 	237;218   ;5  12.5V
	DW 	235;214   ;6  15V
	DW 	233       ;7  17V
	DW 	231       ;8  19V
	DW 	229       ;9  22	
	DW 	227	  ;10 25
	DW 	225       ;11 27
	DW 	223       ;12 29
	DW 	221       ;13 33
	DW 	219       ;14 35
	DW 	217       ;15 38
	DW 	215       ;16 41
	DW 	213       ;17 44
	DW 	211       ;18 46.5
	DW 	209	  ;19 50	
	DW 	207	  ;20 52.7
	DW 	205       ;21 55.5
	DW 	203       ;22 58.5
	DW 	201       ;23 61.7
	DW 	199       ;24 65
	DW 	197       ;25 68
	DW 	195       ;26 71
	DW 	193       ;27 74
	DW 	191       ;28 77.5
	DW 	189	  ;29 81	
	DW 	187	  ;30 84.5
	DW 	185       ;31 87
	DW 	183       ;32 91
	DW 	181       ;33 94.5
	DW 	179       ;34 97
	DW 	177       ;35 100
	DW 	175       ;36 103.5
	DW 	173       ;37 107
	DW 	171       ;38 110
	DW 	169	  ;39 113.5	
	DW 	167	  ;40 116.5
	DW 	165       ;41 120
	DW 	163       ;42 123
	DW 	161       ;43 125
	DW 	159       ;44 126
	DW 	157       ;45 130
	DW 	155       ;46 131.5
	DW 	153       ;47 135
	DW 	151       ;48 136.5
	DW 	149	  ;49 138	
	DW 	147	  ;50 140
	DW 	145       ;51 141
	DW 	143       ;52 144
	DW 	141       ;53 148
	DW 	139	  ;54 149.5	
	DW 	137       ;55 151.5
	DW 	135       ;56 153
	DW 	133       ;57 155.5
	DW 	131       ;58 156.5
	DW 	129	  ;59 158	
	DW 	127	  ;60 161
	DW 	125       ;61 164
	DW 	123       ;62 166
	DW 	121       ;63 167
	DW 	119       ;64 168
	DW 	117       ;65 169
	DW 	115       ;66 172
	DW 	113       ;67 173.5
	DW 	111       ;68 174.5
	DW 	109	  ;69 178
	DW 	107	  ;70 180
	DW 	105        ;71 181
	DW 	103	  ;72 182	
	DW 	101       ;73 183
	DW 	99        ;74 185.6
	DW 	97        ;75 188
	DW 	95        ;76 190
	DW 	93        ;77 193
	DW 	91	  ;78 195	
	DW 	89	  ;79 197
	DW 	87	  ;80 197
	DW 	85	  ;81 198  	
	DW 	83	  ;82 200  ;199
	DW 	81        ;83 202  ;200
	DW 	79	  ;84 203  ;204
	DW 	77        ;85 206  
	DW 	75        ;86 208  
	DW 	73        ;87 211  210
	DW 	71        ;88 212  211
	DW 	69        ;89 215  213
	DW 	67	  ;90 216  215
	DW 	65        ;91 217  216
	DW  	63        ;92 218  217
	DW 	61	  ;93 219  218
	DW 	59	  ;94 220  220	
	DW 	57        ;95 223  221
	DW 	55        ;96 225  222
	DW 	53        ;97 225  223
	DW 	51        ;98      224
	DW 	49	  ;99      225
	DW 	47	  ;100	
	DW 	11
		
 ;----------------------------------------  
;        DW	255 ;0
;	DW	242 ;1
;	DW  	234 ;2
;	DW  	228 ;3
;	DW 	223 ;4
;	DW 	218 ;5
;	DW 	214 ;6
;	DW 	210 ;7
;	DW 	208 ;8
;	DW 	204 ;9		
;	DW 	201 ;10
;	DW 	198 ;11
;	DW 	195 ;12
;	DW 	193 ;13
;	DW 	191 ;14
;	DW 	189 ;15
;	DW 	186
;	DW 	185
;	DW 	182
;	DW 	181		
;	DW 	179		;20
;	DW 	175
;	DW 	174
;	DW 	173
;	DW 	171
;	DW 	169
;	DW 	168
;	DW 	166
;	DW 	164
;	DW 	162		
;	DW 	158		;30
;	DW 	157
;	DW 	156
;	DW 	154
;	DW 	153
;	DW 	150
;	DW 	149
;	DW 	147
;	DW 	146
;	DW 	144		
;	DW 	143;40
;	DW 	141
;	DW 	139
;	DW 	138
;	DW 	137
;	DW 	135
;	DW 	134
;	DW 	132
;	DW 	131
;	DW 	130		
;	DW 	129		;50
;	DW 	128
;	DW 	126
;	DW 	123
;	DW 	122		;ADDED	
;	DW 	121
;	DW 	120
;	DW 	118
;	DW 	117
;	DW 	116		
;	DW 	114		;60
;	DW 	112
;	DW 	110
;	DW 	109
;	DW 	108
;	DW 	107
;	DW 	105
;	DW 	104
;	DW 	103
;	DW 	100		
;	DW 	98		;70
;	DW 	97
;	DW 	96		;ADDED
;	DW 	95
;	DW 	93
;	DW 	91
;	DW 	89
;	DW 	86
;	DW 	84		
;	DW 	82		;ADDED 28/10/98
;	DW 	81		;80
;	DW 	80		
;	DW 	77		;ADDED
;	DW 	76
;	DW 	75		;ADDED 28/10/98
;	DW 	72
;	DW 	70
;	DW 	66
;	DW 	64
;	DW 	60
;	DW 	58		;90;ADDED
;	DW 	57
;	DW  	56
;	DW 	53		;ADDED
;	DW 	51		
;	DW 	45
;	DW 	43
;	DW 	43
;	DW 	43
;	DW 	43		;ADDED
;	DW 	43		;100
;	DW 	11
;-----------------------------------------------------------------

   
   RESET_WDT:
;            
;  ; RET
;  ; MOV    085H,#0F0H
;  ; MOV    0C0H,#1AH
;  ; MOV    0C0H,#1BH
;  
;   MOV               0A6H,#1EH
;   MOV               0A6H,#0E1H               ;0A6H IS A WATCH DOG REGISTER
   RET
;-------------------------------------------------------
   LADDER_INIT:

   MOV   DPTR,#NO_OF_CAVITY_L
   MOVX  A,@DPTR
   MOV   NO_OF_CAVITY,A

   SETB  EJECTOR_SEL_BIT

   MOV   A,#00
   MOV   DPTR,#TMS10H     ;PREFORMSHIFT BACK DLY
   MOVX  @DPTR,A
   MOV   A,#20           ;1SEC
   INC   DPTR
   MOVX  @DPTR,A

   MOV   A,#00
   MOV   DPTR,#TMS17H     ;PREFORMSHIFT BACK DLY
   MOVX  @DPTR,A
   MOV   A,#20           ;1SEC
   INC   DPTR
   MOVX  @DPTR,A

   MOV   A,#00
   MOV   DPTR,#TMS101H     ;HEATER SOFT START TIMER
   MOVX  @DPTR,A
   MOV   A,#5         ;100 MSEC
   INC   DPTR
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS07H     ; PRM GRIPPER ON TM
   MOVX  @DPTR,A
   MOV   DPTR,#TMS07L
   MOV   A,#20
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS103H     ; HOPPER FULL 
   MOVX  @DPTR,A
   MOV   DPTR,#TMS103L
   MOV   A,#80
   MOVX  @DPTR,A


   MOV   A,#0
   MOV   DPTR,#TMS106H     ;MOULD OPEN IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS106L
   MOV   A,#80
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS111H     ;PRM LIFT UP
   MOVX  @DPTR,A
   MOV   DPTR,#TMS111L
   MOV   A,#30
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS112H     ;BOTTLE_TRANSFER IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS112L
   MOV   A,#100
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS107H     ;PREFORM SHIFT FWD IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS107L
   MOV   A,#100
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS108H     ;PREFORM SHIFT BACK IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS108L
   MOV   A,#100
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS109H     ;PREFORM SHIFT LOCK IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS109L
   MOV   A,#50
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS110H     ;MOULD CLOSE IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS110L
   MOV   A,#100
   MOVX  @DPTR,A

   MOV   A,#0
   MOV   DPTR,#TMS110H     ;BOTTOM IP ERR
   MOVX  @DPTR,A
   MOV   DPTR,#TMS110L
   MOV   A,#100
   MOVX  @DPTR,A

   MOV   DPTR,#CTS02H
   MOV   A,#27H
   MOVX  @DPTR,A
   MOV   DPTR,#CTS02L
   MOV   A,#10H
   MOVX  @DPTR,A

   MOV   DPTR,#CTS00H
   MOV   A,#27H
   MOVX  @DPTR,A
   MOV   DPTR,#CTS00L
   MOV   A,#10H
   MOVX  @DPTR,A

   MOV   DPTR,#CTS01H
   MOV   A,#27H
   MOVX  @DPTR,A
   MOV   DPTR,#CTS01L
   MOV   A,#10H
   MOVX  @DPTR,A   

   RET

;---------------------------------------------
   LADDER:
;----------------------------------------------
    
    JNB    OUTPUT_TEST_51,EXECUTE_LADDER
    RET
       
    EXECUTE_LADDER:
;----------------------------------
   MOV   C,ALARM_OP
   MOV   RLY39,C

   MOV   A,ALARM_BITS_2
   MOV   C,HOPPER_ROLLER_JAM_ERR_97
   ORL   C,HOPPER_PRM_EMPTY_ERR_98
   ORL   C,RLY39
   MOV   RLY39,C

   MOV   C,MAN_SEL_LED   
   ANL   C,/EMERGENCY_IP
   ORL   C,RLY39

   MOV   BUZZER_OP,C
   MOV   ALARM_OP_BIT,C
   
;-----------------------------------------------
; PRM FEEDER LOADER
;-----------------------------------------------

   MOV   C,HOPPER_IN_SEL_48   ;HOPPER_OUT_SEL
  ; ANL   C,/HOPPER_OFF_BIT

   MOV   PREFORM_FEEDER_LOADER_OP00,C
;---------------------------------------------
; HOPPER IN MTR
;---------------------------------------------

 ;  MOV   C,HOPPER_IN_SEL
   MOV   C,HOPPER_OUT_SEL
   ANL   C,/HOPPER_OFF_BIT
   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   ANL   C,/HOPPER_ROLLER_JAM_TM104D

   MOV   HOPPER_IN_MOTOR_OP,C

;---------------------------------------
; HOPPER FUL DEBOUN DLY
;---------------------------------------
   MOV   C,HOPPER_IN_MOTOR_OP
   ANL   C,HOPPER_PHOTO_SENSOR_IP

   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   MOV   TM103E,C
   MOVX  @DPTR,A

;---------------------------------------
; HOPPER PRM EMPTY TIMER
;---------------------------------------
   MOV   C,HOPPER_IN_MOTOR_OP
   ANL   C,/HOPPER_PHOTO_SENSOR_IP

   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   MOV   HOPPER_PRM_EMPTY_TM105E,C
   MOVX  @DPTR,A

;---------------------------------------
; HOPPER ROLLER JAM DEBOUN DLY
;---------------------------------------
   MOV   C,HOPPER_OUT_SEL
   ANL   C,HOPPER_ROLLER_JAM_IP

   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   MOV   HOPPER_ROLLER_JAM_TM104E,C
   MOVX  @DPTR,A
   
;-----------------------------

   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   MOV   C,TM103D

   JNC   DONT_SET_HOPPER_OFF

   SETB  HOPPER_OFF_BIT
   
   DONT_SET_HOPPER_OFF:
   
;------------------------------------
   MOV   C,HOPPER_OFF_BIT
   ANL   C,/HOPPER_PHOTO_SENSOR_IP

   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   MOV   PREFORM_SENSR_DEBOUN_DLY_TM102E,C
   MOVX  @DPTR,A

;-------------------------------------------

   MOV   DPTR,#TM100_ENABLE
   MOVX  A,@DPTR
   MOV   C,PREFORM_SENSR_DEBOUN_DLY_TM102D
   ANL   C,HOPPER_OFF_BIT

   JNC   DONT_RESET_HOPPER_OFF

   CLR  HOPPER_OFF_BIT
   
   DONT_RESET_HOPPER_OFF:   
   
;-----------------------------------------------
   START_SEQUENCE:
;-----------------------------------------------
;LOAD EJECTOR_SELECTION
;-----------------------------------------------
;   MOV   C,PREFORM_TRANFER_OUT_IP
  ; MOV   C,PREFORM_TRANFER_IN_HOME_IP   
   MOV   C,MOULDOPEN_IP
   ANL   C,EMERGENCY_IP

   JNC   DONT_LOAD_EJECTOR_SEL

   MOV   C,EJECTOR_SEL_BIT
   MOV   EJECTOR_ENABLE,C

   MOV   C,PREFORM_SENS_BYPASS_SEL
   MOV   BLOWING_ENABLE,C
   
   DONT_LOAD_EJECTOR_SEL:
;-----------------------------------------------
; MANUAL LED BIT
;-----------------------------------------------
   MOV    C,AUTO_MAN_SEL_BIT
   CPL    C
   
   MOV    MAN_SEL_LED,C
;-----------------------------------------------
   MOV   C,ALARM_OP
   ORL   C,/EMERGENCY_IP

   JNC   DONT_RESET_AUTO_MAN_BIT

   CLR   AUTO_MAN_SEL_BIT

   DONT_RESET_AUTO_MAN_BIT:
;-----------------------------------------------
;  ; MOV   C,PREFORM_TRANFER_OUT_IP
;   MOV   C,PREFORM_TRANFER_IN_HOME_IP   
;   ANL   C,MOULDOPEN_IP
;   ANL   C,/MOULDCLOSE_IP
;   ANL   C,EMERGENCY_IP
;   ANL   C,/AUTO_MAN_SEL_BIT

   MOV   C,MAN_SEL_LED
   MOV   RLY39,C

   MOV   C,ALARM_OP
   ORL   C,/EMERGENCY_IP
 ;  ANL   C,MOULDOPEN_IP
   ORL   C,RLY39

   JNC   DONT_RESET_AUTO_MAN_SEL

   MOV   A,AUTO_CYCLE_BITS
   CLR   A
   MOV   AUTO_CYCLE_BITS,A

   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A

   CLR   AUTO_MAN_SEL

   CLR   CYCLE_START

   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   CLR   TM16E
   MOVX  @DPTR,A

   MOV   A,GENERAL_BITS
   CLR   CYCLE_TIME_LOADED
   MOV   GENERAL_BITS,A

   CLR    A
   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
   MOVX   @DPTR,A
   INC    DPTR   ;LEFT_PREFORM_STATUS_BIT_REG_1L
   MOVX   @DPTR,A
   INC    DPTR   ;LEFT_PREFORM_STATUS_BIT_REG_2H
   MOVX   @DPTR,A
   INC    DPTR   ;LEFT_PREFORM_STATUS_BIT_REG_2L
   MOVX   @DPTR,A
   
   CLR    A
   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
   MOVX   @DPTR,A
   MOVX   @DPTR,A
   INC    DPTR
   MOVX   @DPTR,A
   INC    DPTR
   MOVX   @DPTR,A
   INC    DPTR
   MOVX   @DPTR,A
   CLR    LEFT_PREFORM_STATUS_SHIFT_DONE
   CLR    L_PREFORM_SENSOR_STATUS_LOADED
   CLR    RIGHT_PREFORM_STATUS_SHIFT_DONE
   CLR    R_PREFORM_SENSOR_STATUS_LOADED
   
   DONT_RESET_AUTO_MAN_SEL:
;---------------------------------------------------
   MAIN_LADDER:
;---------------------------------------------------
;  MAIN_MACHINE_LOGIC_START:
;---------------------------------------------------
   MOV   C,AUTO_MAN_SEL_BIT
  ; ANL   C,PREFORM_TRANFER_OUT_IP
   ANL   C,PREFORM_TRANFER_IN_HOME_IP
   ANL   C,PREFORM_LIFT_DWN_IP
   ANL   C,MOULDOPEN_IP
  ; ANL   C,BOTTLE_DROPPER_OUT_IP
;   ANL   C,BOTTLE_TRANFER_IN_IP
   ANL   C,/MOULDCLOSE_IP
   ANL   C,EMERGENCY_IP
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,/PREFORMSHIFT_FWD_OVER
   
   JNC   DONT_SET_AUTO
   SETB  AUTO_MAN_SEL
   DONT_SET_AUTO:
   
;------------------------------------------
; PREFORM GRIPPER START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL_BIT
  ; ANL   C,PREFORM_TRANFER_OUT_IP
   ANL   C,PREFORM_TRANFER_IN_HOME_IP   
;   ANL   C,MOULD_OPEN_IP
   ANL   C,PREFORM_PHOTO_SENSOR_IP
   ANL   C,EMERGENCY_IP
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,/PREFORM_GRIPPER_START

   JNC   DONT_SET_PRM_GRIP_START
   
   MOV   A,AUTO_CYCLE_BITS
   SETB  PREFORM_GRIPPER_START
   MOV   AUTO_CYCLE_BITS,A
   
   DONT_SET_PRM_GRIP_START:
;-----------------------------------------

   MOV   C,PRM_GRIPP_PB_43   
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,PREFORM_GRIPPER_START
   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   ANL   C,/PREFORM_GRIP_OFF_DLY_TM14D
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP

   MOV   PREFORM_GRIPPER_OP,C
;---------------

   MOV   C,PREFORM_GRIPPER_OP

   MOV   DPTR,#TM07_ENABLE
   MOVX  A,@DPTR
   MOV   PRM_GRIPP_ON_TM07E,C
   MOVX  @DPTR,A
  
;--------------------------------------------------
 ; PREFORM TRANSFER START HERE     
;---------------------------------------------------
   MOV   C,AUTO_MAN_SEL_BIT
 ;  ANL   C,PREFORM_TRANFER_OUT_IP
   ANL   C,PREFORM_TRANFER_IN_HOME_IP   
   MOV   DPTR,#TM07_ENABLE
   MOVX  A,@DPTR
   ANL   C,PRM_GRIPP_ON_TM07D
   ANL   C,EMERGENCY_IP
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,/PREFORMSHIFT_FWD_OVER
   
   JNC   DONT_START_PREFORM_SHIFT_FWD
   
   MOV   A,AUTO_CYCLE_BITS
   SETB  START_PREFORMSHIFT_FWD
   MOV   AUTO_CYCLE_BITS,A
     
   DONT_START_PREFORM_SHIFT_FWD:
;---------------------------------------
;     PREFORM_SHIFTER_LOGIC_START_HERE:
;---------------------------------------
   MOV   C,PRM_SHIFTER_PB_45
;   ANL   C,PREFORMSHIFT_BACK_IP
;   ANL   C,PREFORMLOCK_IP
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,START_PREFORMSHIFT_FWD
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   ANL   C,/PREFORM_SHIFT_BACK_DLY_TM17D
   ANL   C,PREFORM_LIFT_DWN_IP
   ORL   C,RLY39
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,START_PREFORMSHIFT_FWD
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   ANL   C,/PREFORM_SHIFT_BACK_DLY_TM17D
   ANL   C,PREFORM_TRANSFER_OP
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP

   MOV   PREFORM_TRANSFER_OP,C
   
;----------------------------------------
   MOV   A,AUTO_CYCLE_BITS
   MOV   C,START_PREFORMSHIFT_FWD
   ANL   C,PREFORM_TRANSFER_OP
 ;  ANL   C,PREFORM_TRANFER_IN_IP
   ANL   C,PREFORM_TRANFER_OUT_FWD_IP

   JNC   DONT_SET_PREFORM_SHIFT_FWD_OVER
   
   MOV   A,AUTO_CYCLE_BITS
   SETB  PREFORMSHIFT_FWD_OVER
   MOV   AUTO_CYCLE_BITS,A
   
   DONT_SET_PREFORM_SHIFT_FWD_OVER:
;----------------------------------------
; PRM LIFTTER START
;--------------------------------------
   MOV   C,PRM_LOCK_PB_46
;   ANL   C,PREFORMSHIFT_BACK_IP
;   ANL   C,PREFORMLOCK_IP
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   A,AUTO_CYCLE_BITS
   MOV   C,PREFORMSHIFT_FWD_OVER
   ANL   C,AUTO_MAN_SEL
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   ANL   C,/PREFORM_SHIFT_BACK_DLY_TM17D 
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP

   MOV   PREFORM_LIFTER_OP,C
   
;------------------------------------------
; PRM LIFTER UP AFTER THAT PRM GRIPP OFF DLY START
;---------------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,PREFORM_LIFTER_OP
   ANL   C,PREFORM_LIFT_UP_IP
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,PREFORMSHIFT_FWD_OVER

   JNC   DONT_SET_PRM_GRIPP_OFF_DLY

   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   SETB  PREFORM_GRIP_OFF_DLY_TM14E
   MOVX  @DPTR,A

   DONT_SET_PRM_GRIPP_OFF_DLY:
   
;---------------------------------------
; PRM SHIFTR BACK & LIFTER DOWN START DLY
;---------------------------------------
   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   MOV   C,PREFORM_GRIP_OFF_DLY_TM14D
   ANL   C,MOULDOPEN_IP

   JNC   DONT_RESET_PRM_LIFTR_DOWN_DLY

   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   SETB  PREFORM_SHIFT_BACK_DLY_TM17E
   MOVX  @DPTR,A

   DONT_RESET_PRM_LIFTR_DOWN_DLY:
   
;----------------------------------------------
; MOULD CLOSE START
;----------------------------------------------
   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   ANL   C,PREFORM_SHIFT_BACK_DLY_TM17D
   ANL   C,PREFORM_LIFT_DWN_IP   
   ANL   C,BOTTLE_TRANSFER_IN_IP
   
   JNC   DONT_SET_MOULD_CLOSE_START
   
   MOV   A,AUTO_CYCLE_BITS
   SETB  MOULD_CLOSE_START
   MOV   AUTO_CYCLE_BITS,A

   DONT_SET_MOULD_CLOSE_START:   
;---------------------------------------------

   MOV   A,AUTO_CYCLE_BITS
   MOV   C,MOULD_CLOSE_START
   ANL   C,MOULDCLOSE_OP
   ANL   C,AUTO_MAN_SEL   
;   MOV   DPTR,#TM10_ENABLE
;   MOVX  A,@DPTR
;   ANL   C,PREFORM_SHIFT_BACK_DLY_TM10D
   ANL   C,PREFORM_LIFT_DWN_IP
   ANL   C,MOULDCLOSE_IP
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,PREFORMSHIFT_FWD_OVER
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,/PRM_LOAD_ON_CYCLE_BIT


   JNC   DONT_RESET_PREFORM_LADER_SEQUNCE

   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   CLR   PREFORM_GRIP_OFF_DLY_TM14E
   MOVX  @DPTR,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   PREFORMSHIFT_FWD_OVER
   MOV   AUTO_CYCLE_BITS,A

;   MOV   DPTR,#TM10_ENABLE
;   MOVX  A,@DPTR
;   CLR   PREFORM_SHIFT_BACK_DLY_TM10E
;   MOVX  @DPTR,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   START_PREFORMSHIFT_FWD
   MOV   AUTO_CYCLE_BITS,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   PREFORM_GRIPPER_START
   MOV   AUTO_CYCLE_BITS,A

   MOV   A,AUTO_CYCLE_BITS
   SETB  PRM_LOAD_ON_CYCLE_BIT
   MOV   AUTO_CYCLE_BITS,A

   
   DONT_RESET_PREFORM_LADER_SEQUNCE:
   
;----------------------------------------------
; MOULD BOTTOM OP
;---------------------------------------------
   MOV   C,MOULD_BOTTOM_PB_42
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,MOULD_CLOSE_START
   ANL   C,/MOULDOPEN_OVER   
   ORL   C,RLY39

   MOV   DPTR,#TM13_ENABLE
   MOVX  A,@DPTR
   ANL   C,/BOTTOM_MOULD_OFF_TM13D
   ANL   C,/TWO_PC_MLD_SEL

 ;  ANL   C,EMERGENCY_IP

   MOV   BOTTOM_MOULD_OP,C
;-----

   MOV   DPTR,#TM13_ENABLE
   MOVX  A,@DPTR
   MOV   C,BOTTOM_MOULD_OFF_TM13D
   
   JNC   DONT_RESET_BTM_MLD_KEY
   
   CLR   MOULD_BOTTOM_PB_42
   
        DONT_RESET_BTM_MLD_KEY:
        
;-----------------------------------
 ; MOULD CLOSE OP
;-----------------------------------
   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,MOULD_CLOSE_START

   MOV   DPTR,#TM15_ENABLE
   MOVX  A,@DPTR
   MOV   MOULD_CLOSE_DLY_TM15E,C
   MOVX  @DPTR,A
   
;-----------------------------------------

   MOV   C,BOTTOM_MOULD_IN_IP09
   ORL   C,TWO_PC_MLD_SEL
   
   MOV   BOTTOM_MOULD_IN_IP,C
;----

   MOV   C,MOULDCLOSE_PB_33
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,MOULD_CLOSE_START
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,/EXHAUST_TIME_TM04D
;   MOV   DPTR,#TM03_ENABLE
;   MOVX  A,@DPTR
;   ANL   C,/BLOWING_TIME_TM03D  
   MOV   DPTR,#TM15_ENABLE
   MOVX  A,@DPTR
   ANL   C,MOULD_CLOSE_DLY_TM15D
   ORL   C,RLY39

   ANL   C,BOTTOM_MOULD_IN_IP

   ANL   C,EMERGENCY_IP

   MOV   MOULDCLOSE_OP,C
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,MOULDCLOSE_OP
   ANL   C,MOULDCLOSE_IP

   JNC   DONT_SET_MOULD_CLOSE_OVER
   
   MOV   A,AUTO_CYCLE_BITS
   SETB  MOULD_CLOSE_OVER
   MOV   AUTO_CYCLE_BITS,A
   
   SETB  CYCLE_START
   
   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   CLR   PREFORM_SHIFT_BACK_DLY_TM17E
   MOVX  @DPTR,A

   
   DONT_SET_MOULD_CLOSE_OVER:
;-----------------------------------------
; MOULD LOCK START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   ANL   C,MOULDCLOSE_OP
   
   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   MOV   MOULD_LOCK_DLY_TM00E,C
   MOVX  @DPTR,A
;-----------------------------------------

   MOV   C,MOULDLOCK_PB_41
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   ANL   C,MOULD_LOCK_DLY_TM00D
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,/EXHAUST_TIME_TM04D
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP

   MOV   MOULDLOCK_OP,C
;------------------------------------------
; BPIN IN START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START

   MOV   DPTR,#TM05_ENABLE
   MOVX  A,@DPTR
   MOV   BLOWPIN_DLY_TM05E,C
   MOVX  @DPTR,A
;-----------------------------------------
   MOV   C,PINDN_PB_35
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM05_ENABLE
   MOVX  A,@DPTR
   ANL   C,BLOWPIN_DLY_TM05D
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,/EXHAUST_TIME_TM04D
   ANL   C,BLOWING_ENABLE
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP
   ANL   C,BOTTLE_DROPPER_OUT_IP

   MOV   PINDN_OP,C
;------------------------------------------
; STRETCH IN START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START

   MOV   DPTR,#TM06_ENABLE
   MOVX  A,@DPTR
   MOV   STRETCH_IN_DLY_TM06E,C
   MOVX  @DPTR,A
;-----------------------------------------
   MOV   C,STRETCHIN_PB_36
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM06_ENABLE
   MOVX  A,@DPTR
   ANL   C,STRETCH_IN_DLY_TM06D
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,/EXHAUST_TIME_TM04D
   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR   
   ANL   C,/BLOWING_TIME_TM03D
;   MOV   DPTR,#TM03_ENABLE
;   MOVX  A,@DPTR
;   ANL   C,/BLOWING_TIME_TM03D   
   ANL   C,BLOWING_ENABLE
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP
   ANL   C,BOTTLE_DROPPER_OUT_IP

   MOV   STRETCHIN_OP,C
;------------------------------------------
; LOW BLOW START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM06_ENABLE
   MOVX  A,@DPTR
   ANL   C,STRETCH_IN_DLY_TM06D

   MOV   DPTR,#TM01_ENABLE
   MOVX  A,@DPTR
   MOV   LOW_BLOW_DLY_TM01E,C
   MOVX  @DPTR,A
;-----------------------------------------
   MOV   C,LOWBLOW_PB_37
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

;   MOV   C,DIAPHRAM_VAVLE_SEL
;   ANL   C,HIGHBLOW_OP
;   ORL   C,RLY39
;   MOV   RLY39,C   
   
   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM01_ENABLE
   MOVX  A,@DPTR
   ANL   C,LOW_BLOW_DLY_TM01D
   MOV   DPTR,#TM02_ENABLE
   MOVX  A,@DPTR
   ANL   C,/HIGH_BLOW_DLY_TM02D
   ANL   C,BLOWING_ENABLE
   ANL   C,BOTTLE_DROPPER_OUT_IP   
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP

   MOV   LOWBLOW_OP,C
;------------------------------------------
; HIGH BLOW START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM01_ENABLE
   MOVX  A,@DPTR
   ANL   C,LOW_BLOW_DLY_TM01D

   MOV   DPTR,#TM02_ENABLE
   MOVX  A,@DPTR
   MOV   HIGH_BLOW_DLY_TM02E,C
   MOVX  @DPTR,A
;-----------------------------------------
   MOV   C,HIGHBLOW_PB_38
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR
   ANL   C,BLOWING_TIME_TM03E
   ANL   C,/BLOWING_TIME_TM03D
   ANL   C,BLOWING_ENABLE
   ANL   C,BOTTLE_DROPPER_OUT_IP   
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP

   MOV   HIGHBLOW_OP,C
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM02_ENABLE
   MOVX  A,@DPTR
   ANL   C,HIGH_BLOW_DLY_TM02D

   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR
   MOV   BLOWING_TIME_TM03E,C
   MOVX  @DPTR,A
;------------------------------------------
; EXHAUST START HERE
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM03_ENABLE
   MOVX  A,@DPTR
   ANL   C,BLOWING_TIME_TM03D
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR   
   ANL   C,AIR_RECOVERY_TM08D

   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   MOV   EXHAUST_TIME_TM04E,C
   MOVX  @DPTR,A
;-----------------------------------------

   MOV   C,EXHAUST_PB_39
   ANL   C,/AUTO_MAN_SEL
   MOV   RLY39,C

;   MOV   C,HIGHBLOW_OP
;   ORL   C,LOWBLOW_OP
;   ANL   C,DIAPHRAM_VAVLE_SEL   
;   ORL   C,RLY39
;   MOV   RLY39,C   

   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,EXHAUST_TIME_TM04E
   ANL   C,/EXHAUST_TIME_TM04D
   ANL   C,BLOWING_ENABLE
   ORL   C,RLY39

   ANL   C,EMERGENCY_IP
   ANL   C,BOTTLE_DROPPER_OUT_IP

   MOV   EXHAUST_OP,C
;------------------------------------------
; AIR RECOVERY START HERE
;-----------------------------------------
       MOV   C,AUTO_MAN_SEL
       ANL   C,CYCLE_START
       MOV   DPTR,#TM03_ENABLE
       MOVX  A,@DPTR
       ANL   C,BLOWING_TIME_TM03D

       MOV   DPTR,#TM08_ENABLE
       MOVX  A,@DPTR
       MOV   AIR_RECOVERY_TM08E,C
       MOVX  @DPTR,A
;------------

        MOV   DPTR,#TM08_ENABLE
        MOVX  A,@DPTR
        MOV   C,AIR_RECOVERY_TM08E
        ANL   C,/AIR_RECOVERY_TM08D
        MOV   RLY39,C
           
        MOV   C,AIR_RECOVERY_PB_40
        ANL   C,/AUTO_MAN_SEL
        ORL   C,RLY39

        MOV   AIR_RECOVERY_OP,C   

;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,EXHAUST_TIME_TM04D
  ; ANL   C,/STRETCHIN_OP 
 
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   MOV   BLOWPIN_OUT_DLY_TM09E,C
   MOVX  @DPTR,A
;-----------------------------------------
; BOTTLE GRIP OP
;---------------------------------------

   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   MOV   C,BLOWPIN_OUT_DLY_TM09D
 ;  MOV   A,AUTO_CYCLE_BITS
;   ANL   C,/MOULDOPEN_OVER
;   ANL   C,/MOULDOPEN_IP 
   ANL   C,EJECTOR_ENABLE     
   MOV   RLY39,C

   MOV   C,BOTTLE_GRIP_PB_49
   ANL   C,/AUTO_MAN_SEL
   ORL   C,RLY39

   MOV   BOTTLE_GRIPPER_OP,C
;--------------------------
   MOV   C,BOTTLE_GRIPPER_OP
   ANL   C,AUTO_MAN_SEL
   
   MOV   DPTR,#TM12_ENABLE
   MOVX  A,@DPTR
   MOV   MOULD_OPEN_DLY_TM12E,C
   MOVX  @DPTR,A

;-----------------------------------------
; BOTTLE DROPPER OP
;---------------------------------------
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   MOV   C,BLOWPIN_OUT_DLY_TM09D
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,MOULDOPEN_OVER
   ANL   C,EJECTOR_ENABLE

   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   MOV   BOT_DROP_TM11E,C
   MOVX  @DPTR,A
;---------------------------------
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   MOV   C,BOT_DROP_TM11D
   MOV   RLY39,C

   MOV   C,BOTTLE_DROP_PB_50
   ANL   C,/AUTO_MAN_SEL
   ORL   C,RLY39

   ANL   C,BOTTLE_TRANSFER_SEL_53

   MOV   BOTTLE_DROPPER_OP,C
;---------------------------------
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   MOV   C,BOT_DROP_TM11D
   ANL   C,BOTTLE_DROPPER_IN_IP
   MOV   RLY39,C

   MOV   C,BOTTLE_TRANSFER_PB_54
   ANL   C,/AUTO_MAN_SEL
   ORL   C,RLY39

   ANL   C,BOTTLE_TRANSFER_SEL_53

   MOV   BOTTLE_TRANSFER_OP,C
;-----------------------------------------

   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   ANL   C,BLOWPIN_OUT_DLY_TM09D
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,/MOULDOPEN_OVER
   ANL   C,/EJECTOR_ENABLE   
   MOV   RLY39,C
;------------------------------   
;THIS WAS ENABLED ON 30.3.24
;------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,CYCLE_START
   MOV   DPTR,#TM09_ENABLE
   MOVX  A,@DPTR
   ANL   C,BLOWPIN_OUT_DLY_TM09D
 ;  ANL   C,BOTTLE_DROPPER_IN_IP
   MOV   DPTR,#TM12_ENABLE
   MOVX  A,@DPTR
   ANL   C,MOULD_OPEN_DLY_TM12D
   ANL   C,EJECTOR_ENABLE   
   ORL   C,RLY39   
   MOV   RLY39,C

   MOV   C,MOULDOPEN_PB_34
   ANL   C,/MOULDOPEN_IP
   ANL   C,/AUTO_MAN_SEL
   ORL   C,RLY39
;   MOV   RLY39,C
;
;   MOV   C,EMERGENCY_IP
;   CPL   C
;   ORL   C,ALARM_OP
;   ANL   C,/MOULDOPEN_IP   
;   ORL   C,RLY39

   MOV   MOULDOPEN_OP,C
;---------------------------------------

   MOV   C,MOULDOPEN_OP  

   MOV   DPTR,#TM13_ENABLE
   MOVX  A,@DPTR
   MOV   BOTTOM_MOULD_OFF_TM13E,C
   MOVX  @DPTR,A
   
;-----------------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,MOULDOPEN_OP
   ANL   C,MOULDOPEN_IP

   JNC   DONT_SET_MOULD_OPEN_OVER
   
   MOV   A,AUTO_CYCLE_BITS
   SETB  MOULDOPEN_OVER
   MOV   AUTO_CYCLE_BITS,A
   
   DONT_SET_MOULD_OPEN_OVER:
   
;--------  AUTO CYCLE RESET  ----------------

   MOV   A,AUTO_CYCLE_BITS
   MOV   C,MOULDOPEN_OVER
;   ANL   C,BOTTLE_DROPPER_OUT_IP
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   ANL   C,BOT_DROP_TM11D
   ANL   C,/BOTTOM_MOULD_OP
   ANL   C,/BOTTLE_TRANSFER_SEL_53
   MOV   RLY39,C

   MOV   A,AUTO_CYCLE_BITS
   MOV   C,MOULDOPEN_OVER
   ANL   C,BOTTLE_TRANSFER_OUT_IP
   MOV   DPTR,#TM11_ENABLE
   MOVX  A,@DPTR
   ANL   C,BOT_DROP_TM11D
   ANL   C,/BOTTOM_MOULD_OP
   ANL   C,BOTTLE_TRANSFER_SEL_53
   ORL   C,RLY39
   
   JNC   DONT_RESET_AUTO_FLAGS

   MOV   A,AUTO_CYCLE_BITS
   CLR   MOULD_CLOSE_START
   CLR   MOULDOPEN_OVER 
   CLR   PRM_LOAD_ON_CYCLE_BIT    
   MOV   AUTO_CYCLE_BITS,A


   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   CLR   CYCLE_START

   DONT_RESET_AUTO_FLAGS:
;---------------------------------------------

   MOV   C,MAN_SEL_LED

   JNC   DONT_RESET_MANAUAL_MODE

   MOV   DPTR,#TM14_ENABLE
   MOVX  A,@DPTR
   CLR   PREFORM_GRIP_OFF_DLY_TM14E
   MOVX  @DPTR,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   PREFORMSHIFT_FWD_OVER
   MOV   AUTO_CYCLE_BITS,A

   MOV   DPTR,#TM17_ENABLE
   MOVX  A,@DPTR
   CLR   PREFORM_SHIFT_BACK_DLY_TM17E
   MOVX  @DPTR,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   START_PREFORMSHIFT_FWD
   MOV   AUTO_CYCLE_BITS,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   PREFORM_GRIPPER_START
   MOV   AUTO_CYCLE_BITS,A

   MOV   A,AUTO_CYCLE_BITS
   CLR   A
   MOV   AUTO_CYCLE_BITS,A

   MOV   DPTR,#TM00_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   MOV   DPTR,#TM08_ENABLE
   MOVX  A,@DPTR
   CLR   A
   MOVX  @DPTR,A
   CLR   CYCLE_START
   
   DONT_RESET_MANAUAL_MODE:
;-------------------------------------------
;CYCLE TIME PROG START FROM HERE
;-------------------------------------------
   MOV   C,AUTO_MAN_SEL
   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   ANL   C,/TM16E
   
   JNC   DONT_SET_CYCLE_TM
   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   SETB  TM16E
   MOVX  @DPTR,A
   DONT_SET_CYCLE_TM:
;-------------------------------------------
   MOV   C,MOULDOPEN_OP
   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   ANL   C,TM16E
   MOV   A,GENERAL_BITS
   ANL   C,/CYCLE_TIME_LOADED
   
   JNC   DONT_TERMINATE_CYCLE_TIME

   MOV   DPTR,#TMC16H
   MOVX  A,@DPTR
   MOV   DPTR,#CYCLE_TIME_H
   MOVX  @DPTR,A
   MOV   DPTR,#TMC16L
   MOVX  A,@DPTR
   MOV   DPTR,#CYCLE_TIME_L
   MOVX  @DPTR,A
   
   MOV   DPTR,#TM16_ENABLE
   MOVX  A,@DPTR
   CLR   TM16E
   MOVX  @DPTR,A
   
   MOV   A,GENERAL_BITS
   SETB  CYCLE_TIME_LOADED
   MOV   GENERAL_BITS,A
   
   DONT_TERMINATE_CYCLE_TIME:
;-------------------------------
   MOV   C,AUTO_MAN_SEL
   ANL   C,MOULDCLOSE_OP
   ANL   C,/CYCLE_START

   JNC   DONT_RESET_CYCLE_TIME_LOAD
   
   MOV   A,GENERAL_BITS
   CLR   CYCLE_TIME_LOADED
   MOV   GENERAL_BITS,A
   
   DONT_RESET_CYCLE_TIME_LOAD:
;--------------------------------------------
;LOAD PREFORM STATUS REG INTO BLOWING ENABLE
;--------------------------------------------
;   MOV   C,MOULDCLOSE_OP00
;   MOV   A,AUTO_CYCLE_BITS
;   ANL   C,/MOULD_CLOSE_OVER
;   ANL   C,AUTO_MAN_SEL
;   ANL   C,/DRYCYCLE_SEL
;
;   ANL   C,/LEFT_PREFORM_STATUS_SHIFT_DONE
;
;   JNC   LEFT_DONT_LOAD_PREFORM_STATUS
;
;   SETB  LEFT_PREFORM_STATUS_SHIFT_DONE
;   CLR   C
;   MOV   DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX  A,@DPTR
;   RRC   A
;   MOVX  @DPTR,A
;   MOV   L_TEMP_BIT2,C
;   MOV   DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX  A,@DPTR
;   RRC   A
;   MOV   L_TEMP_BIT,C
;   MOV   C,L_TEMP_BIT2
;   MOV   ACC.7,C
;   MOVX  @DPTR,A
;   MOV   DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX  A,@DPTR
;   RRC   A
;   MOVX  @DPTR,A
;
;   ORL   C,PREFORM_SENS_BYPASS_SEL
;
;   MOV   BLOWING_ENABLE,C
;   
;   CLR   L_PREFORM_SENSOR_STATUS_LOADED
;   MOV   DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX  A,@DPTR
;   MOV   C,L_TEMP_BIT
;   MOV   ACC.7,C
;   MOVX  @DPTR,A
;
;   LEFT_DONT_LOAD_PREFORM_STATUS:
;------------------------------------------------
;   MOV   C,MOULDCLOSE_OP00
;   MOV   A,AUTO_CYCLE_BITS
;   ANL   C,/MOULD_CLOSE_OVER
;   ANL   C,AUTO_MAN_SEL
;   ANL   C,/DRYCYCLE_SEL
;
;   ANL   C,/RIGHT_PREFORM_STATUS_SHIFT_DONE
;
;   JNC   RIGHT_DONT_LOAD_PREFORM_STATUS
;
;   SETB  RIGHT_PREFORM_STATUS_SHIFT_DONE
;   CLR   C
;   MOV   DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX  A,@DPTR
;   RRC   A
;   MOVX  @DPTR,A
;   MOV   R_TEMP_BIT2,C
;   
;   MOV   DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX  A,@DPTR
;   RRC   A
;   MOV   R_TEMP_BIT,C
;   MOV   C,R_TEMP_BIT2
;   MOV   ACC.7,C
;   MOVX  @DPTR,A
;   
;   MOV   DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX  A,@DPTR
;   RRC   A
;   MOVX  @DPTR,A
;
;   ORL   C,PREFORM_SENS_BYPASS_SEL
;   
;   MOV   A,GENERAL_BIT17_TO_24
;   MOV   RIGHT_BLOWING_ENABLE_BIT18,C
;   MOV   GENERAL_BIT17_TO_24,A
;   
;   CLR   R_PREFORM_SENSOR_STATUS_LOADED
;   MOV   DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX  A,@DPTR
;   MOV   C,R_TEMP_BIT
;   MOV   ACC.7,C
;   MOVX  @DPTR,A
;
;   RIGHT_DONT_LOAD_PREFORM_STATUS:
;;-----------------------------------------------------
;   MOV    C,AUTO_MAN_SEL
;   ANL    C,PREFORM_SENSOR_IP
;   ANL    C,PREFORM_SHIFTER_OP
;   ANL    C,/CYCLE_START
;   ANL    C,/L_PREFORM_SENSOR_STATUS_LOADED   ;CYCLE_START   
;
;   JC     L_SHIFT_PREFORM_SENSOR_DATA
;   LJMP   LEFT_PREFORM_SENSE_CONDITION_NOT_ENABLE
;
;   L_SHIFT_PREFORM_SENSOR_DATA:
;   
;   CLR    LEFT_PREFORM_STATUS_SHIFT_DONE
;   
;   MOV    DPTR,#PREFORM_COUNTER_L
;   MOVX   A,@DPTR
;   CJNE   A,#0,L_CHECK_0NE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.0
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;  
;   L_CHECK_0NE:
;
;   CJNE   A,#1,L_CHECK_TWO
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.1
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_TWO:
;
;   CJNE   A,#2,L_CHECK_THREE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.2
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_THREE:
;   
;   CJNE   A,#3,L_CHECK_FOUR
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.3
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_FOUR:
;
;   CJNE   A,#4,L_CHECK_FIVE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.4
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_FIVE:
;
;   CJNE   A,#5,L_CHECK_SIX
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.5
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_SIX:
;   
;   CJNE   A,#6,L_CHECK_SEVEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.6
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_SEVEN:
;
;   CJNE   A,#7,L_CHECK_EIGHT
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.7
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_EIGHT:
;   
;   CJNE   A,#8,L_CHECK_NINE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.0
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP 
;
;   L_CHECK_NINE:
;   
;   CJNE   A,#9,L_CHECK_TEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.1
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP 
;
;   L_CHECK_TEN:
;   
;   CJNE   A,#10,L_CHECK_ELEVEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.2
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_ELEVEN:
;   
;   CJNE   A,#11,L_CHECK_TWELVE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.3
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_TWELVE:
;   
;   CJNE   A,#12,L_CHECK_THIRTEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.4
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_THIRTEEN:
;   
;   CJNE   A,#13,L_CHECK_FOURTEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.5
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_FOURTEEN:
;   
;   CJNE   A,#14,L_CHECK_FIFTEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.6
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;
;   L_CHECK_FIFTEEN:
;
;   CJNE   A,#15,L_CHECK_SIXTEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.7
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_SIXTEEN:
;
;   CJNE   A,#16,L_CHECK_SEVENTEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.0
;   MOVX   @DPTR,A
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_SEVENTEEN:
;
;   CJNE   A,#17,L_CHECK_EIGHTTEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.1
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_EIGHTTEEN:
;
;   CJNE   A,#18,L_CHECK_NINETEEN
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.2
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_NINETEEN:
;
;   CJNE   A,#19,L_CHECK_TWENTY
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.3
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_TWENTY:
;
;   CJNE   A,#20,L_CHECK_TWENTY_ONE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.4
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_TWENTY_ONE:
;
;   CJNE   A,#21,L_CHECK_TWENTY_TWO
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.5
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_TWENTY_TWO:
;   
;   CJNE   A,#22,L_CHECK_TWENTY_THREE
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.6
;   MOVX   @DPTR,A 
;   LJMP   L_OUT_OF_SENSOR_LOOP
;   
;   L_CHECK_TWENTY_THREE:
;
;   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.7
;   MOVX   @DPTR,A 
;   
;   L_OUT_OF_SENSOR_LOOP:
;   
;   SETB   L_PREFORM_SENSOR_STATUS_LOADED
;
;   LEFT_PREFORM_SENSE_CONDITION_NOT_ENABLE:
;--------------------------------------------------------------
;   MOV    C,AUTO_MAN_SEL
;   ANL    C,PREFORM_SENSOR_IP
;   ANL    C,PREFORM_SHIFTER_OP
;   ANL    C,/CYCLE_START
;   ANL    C,/R_PREFORM_SENSOR_STATUS_LOADED
;
;   JC     RIGHT_SHIFT_PREFORM_SENSOR_DATA
;   LJMP   RIGHT_PREFORM_SENSE_CONDITION_NOT_ENABLE
;
;   RIGHT_SHIFT_PREFORM_SENSOR_DATA:
;   
;   CLR    RIGHT_PREFORM_STATUS_SHIFT_DONE
;   
;   MOV    DPTR,#PREFORM_COUNTER_L
;   MOVX   A,@DPTR
;   CJNE   A,#0,R_CHECK_0NE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.0
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;  
;   R_CHECK_0NE:
;
;   CJNE   A,#1,R_CHECK_TWO
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.1
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_TWO:
;
;   CJNE   A,#2,R_CHECK_THREE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.2
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_THREE:
;   
;   CJNE   A,#3,R_CHECK_FOUR
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.3
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_FOUR:
;
;   CJNE   A,#4,R_CHECK_FIVE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.4
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_FIVE:
;
;   CJNE   A,#5,R_CHECK_SIX
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.5
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_SIX:
;   
;   CJNE   A,#6,R_CHECK_SEVEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.6
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_SEVEN:
;
;   CJNE   A,#7,R_CHECK_EIGHT
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1L
;   MOVX   A,@DPTR
;   SETB   ACC.7
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_EIGHT:
;   
;   CJNE   A,#8,R_CHECK_NINE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.0
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP 
;
;   R_CHECK_NINE:
;   
;   CJNE   A,#9,R_CHECK_TEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.1
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP 
;
;   R_CHECK_TEN:
;   
;   CJNE   A,#10,R_CHECK_ELEVEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.2
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_ELEVEN:
;   
;   CJNE   A,#11,R_CHECK_TWELVE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.3
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_TWELVE:
;   
;   CJNE   A,#12,R_CHECK_THIRTEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.4
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_THIRTEEN:
;   
;   CJNE   A,#13,R_CHECK_FOURTEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.5
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_FOURTEEN:
;   
;   CJNE   A,#14,R_CHECK_FIFTEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.6
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;
;   R_CHECK_FIFTEEN:
;
;   CJNE   A,#15,R_CHECK_SIXTEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
;   MOVX   A,@DPTR
;   SETB   ACC.7
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_SIXTEEN:
;
;   CJNE   A,#16,R_CHECK_SEVENTEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.0
;   MOVX   @DPTR,A
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_SEVENTEEN:
;
;   CJNE   A,#17,R_CHECK_EIGHTTEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.1
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_EIGHTTEEN:
;
;   CJNE   A,#18,R_CHECK_NINETEEN
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.2
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_NINETEEN:
;
;   CJNE   A,#19,R_CHECK_TWENTY
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.3
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_TWENTY:
;
;   CJNE   A,#20,R_CHECK_TWENTY_ONE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.4
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_TWENTY_ONE:
;
;   CJNE   A,#21,R_CHECK_TWENTY_TWO
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.5
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_TWENTY_TWO:
;   
;   CJNE   A,#22,R_CHECK_TWENTY_THREE
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.6
;   MOVX   @DPTR,A 
;   LJMP   R_OUT_OF_SENSOR_LOOP
;   
;   R_CHECK_TWENTY_THREE:
;
;   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_2L
;   MOVX   A,@DPTR
;   SETB   ACC.7
;   MOVX   @DPTR,A 
; ;  LJMP   R_OUT_OF_SENSOR_LOOP
;      
;   R_OUT_OF_SENSOR_LOOP:
;   
;   SETB   R_PREFORM_SENSOR_STATUS_LOADED
;
;   RIGHT_PREFORM_SENSE_CONDITION_NOT_ENABLE:
;---------------------------------------------------------

   JB     HEATER_ON_OFF,DONT_RESET_PREFORM_STATUS_BIT_REG
   CLR    A
   MOV    DPTR,#LEFT_PREFORM_STATUS_BIT_REG_1H
   MOVX   @DPTR,A
   INC    DPTR   ;LEFT_PREFORM_STATUS_BIT_REG_1L
   MOVX   @DPTR,A
   INC    DPTR   ;LEFT_PREFORM_STATUS_BIT_REG_2H
   MOVX   @DPTR,A
   INC    DPTR   ;LEFT_PREFORM_STATUS_BIT_REG_2L
   MOVX   @DPTR,A
   
   CLR    A
   MOV    DPTR,#RIGHT_PREFORM_STATUS_BIT_REG_1H
   MOVX   @DPTR,A
   MOVX   @DPTR,A
   INC    DPTR
   MOVX   @DPTR,A
   INC    DPTR
   MOVX   @DPTR,A
   INC    DPTR
   MOVX   @DPTR,A
   CLR    LEFT_PREFORM_STATUS_SHIFT_DONE
   CLR    L_PREFORM_SENSOR_STATUS_LOADED
   CLR    RIGHT_PREFORM_STATUS_SHIFT_DONE
   CLR    R_PREFORM_SENSOR_STATUS_LOADED
   
   DONT_RESET_PREFORM_STATUS_BIT_REG:
   
   RET
;;-----------------------------------------
;   BOTTLE_EJECTOR_AIR_THROW:
;;-----------------------------------------
;;  BOTTLE EJECTOR LIFT START HERE
;;-----------------------------------------
;   MOV   C,AUTO_MAN_SEL
;   ANL   C,EJECTOR_ENABLE
;   ANL   C,CYCLE_START
;   MOV   DPTR,#TM01_ENABLE
;   MOVX  A,@DPTR
;   ANL   C,/LOW_BLOW_DLY_TM01D
;
;   JNC   DONT_SET_BOT_LIFT_DLY
;   MOV   DPTR,#TM11_ENABLE
;   MOVX  A,@DPTR
;   SETB  BOT_LIFT_UP_DLY_TM11E
;   MOVX  @DPTR,A
;   DONT_SET_BOT_LIFT_DLY:
;
;;------------------------------------------
;; BOTTLE AIR THROW START HERE
;;-----------------------------------------
;   MOV   C,AUTO_MAN_SEL
;   MOV   DPTR,#TM11_ENABLE
;   MOVX  A,@DPTR
;   ANL   C,BOT_LIFT_UP_DLY_TM11D
;
;   MOV   DPTR,#TM12_ENABLE
;   MOVX  A,@DPTR
;   MOV   BOT_AIR_THROW_DLY_TM12E,C
;   MOVX  @DPTR,A
;;-----------------------------------------
;   MOV   C,AUTO_MAN_SEL
;   MOV   DPTR,#TM12_ENABLE
;   MOVX  A,@DPTR
;   ANL   C,BOT_AIR_THROW_DLY_TM12D
;
;   MOV   DPTR,#TM13_ENABLE
;   MOVX  A,@DPTR
;   MOV   BOT_AIR_THROW_TM13E,C
;   MOVX  @DPTR,A
;;;-----------------------------------------
;;   MOV   C,AIR_THROW_PB_44
;;   ANL   C,/AUTO_MAN_SEL
;;   MOV   RLY39,C
;;
;;   MOV   DPTR,#TM13_ENABLE
;;   MOVX  A,@DPTR
;;   MOV   C,BOT_AIR_THROW_TM13E
;;   ANL   C,/BOT_AIR_THROW_TM13D
;;   ORL   C,RLY39
;;
;;   MOV   AIR_THROW_OP,C
;;-----------------------------------------
;;  EJECTOR CYCLE RESET HERE
;;-----------------------------------------
;   MOV   DPTR,#TM13_ENABLE
;   MOVX  A,@DPTR
;   MOV   C,BOT_AIR_THROW_TM13D
;   MOV   A,AUTO_CYCLE_BITS
;   ORL   C,MOULDOPEN_OVER
;   ANL   C,AUTO_MAN_SEL
;
;   JNC   DONT_RESET_EJECTOR_FLAG
;   MOV   DPTR,#TM11_ENABLE
;   MOVX  A,@DPTR
;   CLR   BOT_LIFT_UP_DLY_TM11E
;   MOVX  @DPTR,A
;   DONT_RESET_EJECTOR_FLAG:
;
;   RET
;------------------------------
   CHECK_ALARM:

   JNB    OUTPUT_TEST_51,BYPASS_ALARM

   RET 
   
   BYPASS_ALARM:
  
;--------------------------------------------------------
;  ALARM START HERE
;--------------------------------------------------------
;    MOV   C,EMERGENCY_IP
;    CPL   C
;
;    MOV   A,ALARM_BITS_1
;    MOV   EMERGENCY_IP_ERR_95,C
;    MOV   ALARM_BITS_1,A
;--------------------------------------------------------

    MOV   C,MOULDCLOSE_OP
    ANL   C,AUTO_MAN_SEL
    ANL   C,/MOULDCLOSE_IP
    ANL   C,/ALARM_OP

    MOV   DPTR,#TM110_ENABLE
    MOVX  A,@DPTR
    MOV   MOULD_CLOSE_IP_ERR_TM110E,C    
    MOVX  @DPTR,A

    MOV   DPTR,#TM110_ENABLE
    MOVX  A,@DPTR
    MOV   C,MOULD_CLOSE_IP_ERR_TM110D

    JNC   DONT_SET_MOULD_CLOSE_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  MOULD_CLOSE_IP_ERR_89
    MOV   ALARM_BITS_1,A

    DONT_SET_MOULD_CLOSE_IP_ERR:
;-----------------------------
;  BOTTLE GRIPPER OUT IP
;--------------------------------

    MOV   C,AUTO_MAN_SEL
    ANL   C,MOULDCLOSE_IP
    ANL   C,/BOTTLE_DROPPER_OUT_IP
    MOV   DPTR,#TM03_ENABLE
    MOVX  A,@DPTR    
    ANL   C,/BLOWING_TIME_TM03D
    ANL   C,/ALARM_OP

    JNC   DONT_SET_BOTTLE_DROP_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  BOTTLE_DROP_OUT_IP_ERR_96
    MOV   ALARM_BITS_1,A

    DONT_SET_BOTTLE_DROP_IP_ERR:
;--------------------------------
;  BOTTLE TRANSFER IP ERROR TIME
;--------------------------------
    MOV   C,AUTO_MAN_SEL
    ANL   C,/BOTTLE_TRANSFER_OP
    ANL   C,/BOTTLE_TRANSFER_IN_IP
    ANL   C,/ALARM_OP
    MOV   RLY39,C

    MOV   C,AUTO_MAN_SEL
    ANL   C,BOTTLE_TRANSFER_OP
    ANL   C,/BOTTLE_TRANSFER_OUT_IP
    ANL   C,/ALARM_OP
    ORL   C,RLY39
    
    MOV   DPTR,#TM112_ENABLE
    MOVX  A,@DPTR
    MOV   BOTTLE_TRANSFER_IP_ERR_TM112E,C
    MOVX  @DPTR,A
;-----------------------------
;  BOTTLE TRANSFER IN IP
;--------------------------------
    MOV   C,AUTO_MAN_SEL
    ANL   C,/BOTTLE_TRANSFER_OP
    ANL   C,/BOTTLE_TRANSFER_IN_IP
    MOV   DPTR,#TM112_ENABLE
    MOVX  A,@DPTR
    ANL   C,BOTTLE_TRANSFER_IP_ERR_TM112D
    ANL   C,/ALARM_OP

    JNC   DONT_SET_BOTTLE_TRANSFER_IN_IP_ERR

    MOV   A,ALARM_BITS_3
    SETB  BOTTLE_TRANSFER_IN_IP_ERR_105
    MOV   ALARM_BITS_3,A

    DONT_SET_BOTTLE_TRANSFER_IN_IP_ERR:
;-----------------------------
;  BOTTLE TRANSFER IN IP
;--------------------------------
    MOV   C,AUTO_MAN_SEL
    ANL   C,BOTTLE_TRANSFER_OP
    ANL   C,/BOTTLE_TRANSFER_OUT_IP
    MOV   DPTR,#TM112_ENABLE
    MOVX  A,@DPTR
    ANL   C,BOTTLE_TRANSFER_IP_ERR_TM112D
    ANL   C,/ALARM_OP

    JNC   DONT_SET_BOTTLE_TRANSFER_OUT_IP_ERR

    MOV   A,ALARM_BITS_3
    SETB  BOTTLE_TRANSFER_OUT_IP_ERR_106
    MOV   ALARM_BITS_3,A

    DONT_SET_BOTTLE_TRANSFER_OUT_IP_ERR:
;------------------------------------------------------------
    MOV   C,MOULDOPEN_OP
   ; CPL   C
    MOV   DPTR,#TM04_ENABLE
    MOVX  A,@DPTR
    ANL   C,EXHAUST_TIME_TM04D
    ANL   C,AUTO_MAN_SEL
    ANL   C,/MOULDOPEN_IP
    ANL   C,/ALARM_OP
;    MOV   RLY39,C
;
;    MOV   C,AUTO_MAN_SEL
;    MOV   A,AUTO_CYCLE_BITS
;    ANL   C,MOULD_CLOSE_START
;    MOV   DPTR,#TM04_ENABLE
;    MOVX  A,@DPTR
;    ANL   C,/EXHAUST_TIME_TM04D
;    ANL   C,/BOTTOM_MOULD_IN_IP   
;    ORL   C,RLY39   

    MOV   DPTR,#TM106_ENABLE
    MOVX  A,@DPTR
    MOV   MOULD_OPEN_IP_ERR_TM106E,C
    MOVX  @DPTR,A
;--

    MOV   C,AUTO_MAN_SEL_BIT
    ANL   C,/AUTO_MAN_SEL
    ANL   C,/MOULDOPEN_IP
    ANL   C,/ALARM_OP
    MOV   DPTR,#TM106_ENABLE
    MOVX  A,@DPTR
    ORL   C,MOULD_OPEN_IP_ERR_TM106D

    JNC   DONT_SET_MOULD_OPEN_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  MOULD_OPEN_IP_ERR_91
    MOV   ALARM_BITS_1,A

    DONT_SET_MOULD_OPEN_IP_ERR:

;----------------------------------------
; MOUB BOTTOM IP ERR
;-------------------------------------
   MOV   C,AUTO_MAN_SEL
   MOV   A,AUTO_CYCLE_BITS
   ANL   C,MOULD_CLOSE_START
   MOV   DPTR,#TM04_ENABLE
   MOVX  A,@DPTR
   ANL   C,/EXHAUST_TIME_TM04D
   ANL   C,/BOTTOM_MOULD_IN_IP
   MOV   DPTR,#TM111_ENABLE
   MOVX  A,@DPTR
   ANL   C,MOULD_BOTTOM_IP_ERR_TM111D
   MOV   RLY39,C

   MOV   C,MOULDCLOSE_PB_33
   ANL   C,/AUTO_MAN_SEL
   ORL   C,RLY39
   ANL   C,/BOTTOM_MOULD_IN_IP

   ANL   C,/ALARM_OP

   JNC   DONT_SET_MOULD_BOTTOM_IP_ERR

   MOV   A,ALARM_BITS_1
   SETB  BOTTOM_MOULD_IN_IP_ERR_95
   MOV   ALARM_BITS_1,A

   DONT_SET_MOULD_BOTTOM_IP_ERR:

;------------------

   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   MOV   C,HOPPER_ROLLER_JAM_TM104D

   MOV   A,ALARM_BITS_2
   MOV   HOPPER_ROLLER_JAM_ERR_97,C
   MOV   ALARM_BITS_2,A
;------------------------------------

   MOV   DPTR,#TM104_ENABLE
   MOVX  A,@DPTR
   MOV   C,HOPPER_PRM_EMPTY_TM105D

   MOV   A,ALARM_BITS_2
   MOV   HOPPER_PRM_EMPTY_ERR_98,C
   MOV   ALARM_BITS_2,A

;------------------------------------------------------------
; PREFORM LIFTER DOWN IP ERR
;-----------------------------------------------------------
    MOV   C,PREFORM_LIFTER_OP
    CPL   C
    ANL   C,AUTO_MAN_SEL
    ANL   C,/PREFORM_LIFT_DWN_IP
    ANL   C,/ALARM_OP

    MOV   DPTR,#TM109_ENABLE
    MOVX  A,@DPTR
    MOV   PREFORMSHIFT_LOCK_IP_ERR_TM109E,C
    MOVX  @DPTR,A

    MOV   C,AUTO_MAN_SEL_BIT
    ANL   C,/AUTO_MAN_SEL
    ANL   C,/PREFORM_LIFT_DWN_IP
    ANL   C,/ALARM_OP
    MOV   DPTR,#TM109_ENABLE
    MOVX  A,@DPTR
    ORL   C,PREFORMSHIFT_LOCK_IP_ERR_TM109D

    JNC   DONT_SET_PREFORM_LOCK_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  PREFORM_LIFT_DWN_IP_ERR_94
    MOV   ALARM_BITS_1,A

    DONT_SET_PREFORM_LOCK_IP_ERR:

;------------------------------------------------------------
; PREFORM LIFTER UP IP ERR
;-----------------------------------------------------------
    MOV   C,PREFORM_LIFTER_OP
    ANL   C,AUTO_MAN_SEL
    ANL   C,/PREFORM_LIFT_UP_IP
    ANL   C,/ALARM_OP
    MOV   RLY39,C

    MOV   C,AUTO_MAN_SEL
    MOV   A,AUTO_CYCLE_BITS
    ANL   C,MOULD_CLOSE_START
    MOV   DPTR,#TM04_ENABLE
    MOVX  A,@DPTR
    ANL   C,/EXHAUST_TIME_TM04D
    ANL   C,/BOTTOM_MOULD_IN_IP   
    ORL   C,RLY39 


    MOV   DPTR,#TM111_ENABLE
    MOVX  A,@DPTR
    MOV   MOULD_BOTTOM_IP_ERR_TM111E,C
    MOVX  @DPTR,A

    MOV   DPTR,#TM111_ENABLE
    MOVX  A,@DPTR
    MOV   C,MOULD_BOTTOM_IP_ERR_TM111D
    ANL   C,PREFORM_LIFTER_OP
    ANL   C,AUTO_MAN_SEL
    ANL   C,/PREFORM_LIFT_UP_IP
    ANL   C,/ALARM_OP

    JNC   DONT_SET_BOTTOM_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  PREFORM_LIFT_UP_ERR_90
    MOV   ALARM_BITS_1,A

    DONT_SET_BOTTOM_IP_ERR:
;------------------------------------------------------------
    MOV   C,PREFORM_TRANSFER_OP
    ANL   C,AUTO_MAN_SEL
  ;  ANL   C,/PREFORM_TRANFER_IN_IP
    ANL   C,/PREFORM_TRANFER_OUT_FWD_IP
    ANL   C,/ALARM_OP

    MOV   DPTR,#TM107_ENABLE
    MOVX  A,@DPTR
    MOV   PREFORMSHIFT_FWD_IP_ERR_TM107E,C
    MOVX  @DPTR,A

    MOV   DPTR,#TM107_ENABLE
    MOVX  A,@DPTR
    MOV   C,PREFORMSHIFT_FWD_IP_ERR_TM107D

    JNC   DONT_SET_PREFORM_SHIFT_FWD_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  PREFORMSHIFT_FWD_IP_ERR_92
    MOV   ALARM_BITS_1,A

    DONT_SET_PREFORM_SHIFT_FWD_IP_ERR:
    
;------------------------------------------------------------
    MOV   C,PREFORM_TRANSFER_OP
    CPL   C
    ANL   C,AUTO_MAN_SEL
 ;   ANL   C,/PREFORM_TRANFER_OUT_IP
    ANL   C,/PREFORM_TRANFER_IN_HOME_IP    
    ANL   C,/ALARM_OP

    MOV   DPTR,#TM108_ENABLE
    MOVX  A,@DPTR
    MOV   PREFORMSHIFT_BACK_IP_ERR_TM108E,C
    MOVX  @DPTR,A

    MOV   C,AUTO_MAN_SEL_BIT
    ANL   C,/AUTO_MAN_SEL
   ; ANL   C,/PREFORM_TRANFER_OUT_IP
    ANL   C,/PREFORM_TRANFER_IN_HOME_IP
    ANL   C,/ALARM_OP
    MOV   DPTR,#TM108_ENABLE
    MOVX  A,@DPTR
    ORL   C,PREFORMSHIFT_BACK_IP_ERR_TM108D

    JNC   DONT_SET_PREFORM_SHIFT_BACK_IP_ERR

    MOV   A,ALARM_BITS_1
    SETB  PREFORMSHIFT_BACK_IP_ERR_93
    MOV   ALARM_BITS_1,A

    DONT_SET_PREFORM_SHIFT_BACK_IP_ERR:


;-----------------------------------------------
  JNB   ALARM_RESET_PB_47,DONT_RESET_ALARM_BITS
  
  MOV   A,#0
  MOV   ALARM_BITS_1,A
  MOV   ALARM_BITS_2,A
  MOV   ALARM_BITS_3,A
  
  DONT_RESET_ALARM_BITS:
;---------------------------------------------------------
    ALARM_OP_STATUS:

  MOV   A,ALARM_BITS_1
  JNZ   ALARM_ON
  MOV   A,ALARM_BITS_3
  JNZ   ALARM_ON  
  SJMP  ALARM_OFF
  
  ALARM_ON:
  
  SETB  C
  MOV	ALARM_OP,C
  SJMP  END_ALARM_CHECK

  ALARM_OFF:

  CLR   C
  MOV	ALARM_OP,C

  END_ALARM_CHECK:
  
;---------------------------------------------------------
    RET
;   LADDER_END:

        END

 

