# Self-Parking-Robot-Car
Self Parking and Parking Slot Auto Identifying Line Following Robot Car (Assembly Program)

✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶ 
Assembly Line Followig Car

Coded using: AVR Assembly Language | Atmel Studio 7.0
Technologies used: UART | Serial Communication


✦ Line following two wheeler robot car build using a Arduino uno 
  (ATMega328p).
  
✦ This Robot can identify the parking zone which marked by a  straight line across the line that following and the end of  the parking is identified by the double lines across the following line.
  
✦ Using IR receiver and UART serial communication It identifies the correct parking slot.

✦ After identifying the parking slot, it reverse into the parking slot and parked inside it.

✦ This robot is created used two wheel robot car, Created using,

    ✧ Arduino UNO board ( Atmega328p )
    ✧ Two wheel (2W) chassis
    ✧ L298 motor drive
    ✧ 3x TCRT 5000 Line following sensor
    ✧ IR reciever
    ✧ IR LED
✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶

In this code, I used

◆ PORTB 3, 4, 5 pins for Line following sensors Left, Middle, Right respectively.

◆ PORTB 0, 1 pins used for 2 enablers in the L298 motor drive. Left and Right respectively.

◆ PORTD 2, 3, 4, 5 pins used for inputs of the motor drive (Input 1,2,3,4 respectively)

◆ PORTD 0 (RX) pin used to recieve IR inputs for Serial Communication

Following code is only explaining the code that I wrote. For the full code use the Self_Parking_Robot_Car.asm file.
✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶
              C O D E
              
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

;Starting Reverse Process

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
