;
; AssemblerApplication22.asm
;
; Created: 11/1/2019 5:08:25 AM
; Author : Kolitha Kasun
;
;


; Replace with your application code
 
.ORG 0x0 ;location for reset 
  JMP MAIN

   .ORG 0x0E ;ISR location for Timer2 compare match A
  JMP TIMER2_A
  .ORG 0x10 ;ISR location for Timer2 compare match B
  JMP TIMER2_B
  .ORG 0x1C ;ISR location for Timer0 compare match A
  JMP TIMER0_A
  .ORG 0x1E ;ISR location for Timer0 compare match B
  JMP TIMER0_B


;main program
MAIN:
  LDI R20,HIGH(RAMEND)
  OUT SPH,R20
  LDI R20,LOW(RAMEND)
  OUT SPL,R20;set up stack 

  ;SETTING PINS AS OUTPUT FOR MOTOR DRIVE

  SBI DDRB,0;PB5 as an output
  SBI DDRB,1;PB5 as an output
  SBI DDRD,4
  SBI DDRD,5
  SBI DDRD,2
  SBI DDRD,3
  sbi DDRD,7

  ;SETTING PINS AS INPUT FOR SENSORS

  CBI DDRB,3	;Sensors LEFT
  CBI DDRB,4	;sENSOR MIDDLE
  CBI DDRB,5	;SENSOR RIGHT
  
  ;Initializing TImer0
  LDI R20,255
  OUT OCR0A,R20 ;load Timer0 with 239
  LDI R20,5 
  out OCR0B,R20

  ;Initializing TImer2
  LDI R20,255
  STS OCR2A,R20
  LDI R21,5
  STS OCR2B,R21

  LDI R20,0x02
  OUT TCCR0A,R20
  LDI R20,0x01
  OUT TCCR0B,R20 ;start Timer0, CTC mode, no scaler

  LDI R20,0x02
  STS TCCR2A,R20
  LDI R20,0x01
  STS TCCR2B,R20 ;start Timer0, CTC mode, no scaler

  LDI R20,0x06
  STS TIMSK0,R20

  LDI R20,0x06
  STS TIMSK2,R20


  cBI PORTD,4
  cBI PORTD,5

  SBI PORTD,2
  SBI PORTD,3
  
  LDI R20, 0X10
  STS UCSR0B, R20

  LDI R20, 0X00
  STS UCSR0C, R20
  SEI ;set I (enable interrupts globally)
  JMP FAST
 
;;Line Following While looking for Parking Zone

	FAST:
		SBIC PINB,4
		JMP CHECK5
		JMP Check_PIN3

	CHECK5:
		SBIC PINB,5
		JMP CHECK3
		JMP Forward_FAST

	CHECK3:
		SBIC PINB,3
		JMP SLOW

	Check_PIN3:
		SBIC PINB,3
		JMP TurnLeft_FAST
		SBIC PINB,5
		JMP TurnRight_FAST
		JMP FAST


;Jump When PARKING ZONE is DETECTED
;Used  UCSR0A to detect IR
	SLOW:	
		LDS R20,UCSR0A
		SBRC R20,7
		RJMP Reverse
		SBI PORTD,7

		SBIC PINB,4
		JMP Forward_SLOW
		SBIC PINB,3
		JMP TurnLeft_SLOW
		SBIC PINB,5
		JMP TurnRight_SLOW
		JMP SLOW

	TurnLeft_FAST:
		LDI R20,124
		OUT OCR0B,R20   ;left MOTOR
		LDI R20,89 
		STS OCR2B,R20  ;right motor
		JMP FAST

	Forward_FAST:
		LDI R20,95 
		OUT OCR0B,R20
		LDI R20,95
		STS OCR2B,R20
		JMP FAST

	TurnRight_FAST:
		LDI R21,120 
		STS OCR2B,R21
		LDI R20,89 
		OUT OCR0B,R20
		JMP FAST

	TurnLeft_SLOW:	
		LDI R20,120 
		OUT OCR0B,R20
		LDI R20,78 
		STS OCR2B,R20
		JMP SLOW

	Forward_SLOW:
		LDI R20,105 
		OUT OCR0B,R20
		LDI R20,105
		STS OCR2B,R20
		JMP SLOW

	TurnRight_SLOW:
		LDI R21,120 
		STS OCR2B,R21
		LDI R20,78 
		OUT OCR0B,R20
		JMP SLOW

;--ISR for Timer0
	TIMER0_A:
  		CBI PORTB,0
  		RETI ;return from interrupt

	TIMER0_B:
  		SBI PORTB,0
  		RETI ;return from interrupt

	TIMER2_A:
  		CBI PORTB,1
  		RETI ;return from interrupt

	TIMER2_B:
  		SBI PORTB,1
  		RETI ;return from interrupt


	Reverse:
		LDI R20,200 
		OUT OCR0B,R20
		LDI R20,200
		STS OCR2B,R20
		CALL Delay1s

		LDI R20,80
		STS OCR2B,R20
		CALL DELAY400ms

		LDI R20,200 
		OUT OCR0B,R20
		LDI R20,200
		STS OCR2B,R20
		CALL Delay1s

	;SWITCHING TO REVERSE
		SBI PORTD,4
		SBI PORTD,5
		CBI PORTD,2
		CBI PORTD,3

		LDI R20,5 
		OUT OCR0B,R20
		LDI R20,5
		STS OCR2B,R20

		LDI R20,87 
		OUT OCR0B,R20
		LDI R20,98
		STS OCR2B,R20
		CALL DELAY500ms
		CALL DELAY500ms
		CALL DELAY500ms
		LDI R20,200 
		OUT OCR0B,R20
		LDI R20,200
		STS OCR2B,R20
	END:JMP END

	Delay1s:	
    	ldi  r18, 82
    	ldi  r19, 43
    	ldi  r20, 0
		L8: dec  r20
	    brne L8
	    dec  r19
	    brne L8
	    dec  r18
	    brne L8
	    lpm
	    nop
		RET

	DELAY500ms:
	    ldi  r18, 41
    	ldi  r19, 150
    	ldi  r20, 128
	L9: dec  r20
    	brne L9
    	dec  r19
    	brne L9
    	dec  r18
    	brne L9
		RET

	DELAY750ms:
    	ldi  r18, 61
    	ldi  r19, 225
    	ldi  r20, 64
	L10: dec  r20
    	brne L10
    	dec  r19
    	brne L10
    	dec  r18
    	brne L10
    	rjmp PC+1
		RET

	DELAY400ms:
        ldi  r18, 31
    	ldi  r19, 113
    	ldi  r20, 31
	L1: dec  r20
    	brne L1
    	dec  r19
    	brne L1
    	dec  r18
    	brne L1
    	nop
		RET


