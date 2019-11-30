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
✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶

In this code, I used

◆ PORTB 3, 4, 5 pins for Line following sensors Left, Middle, Right respectively.

◆ PORTB 0, 1 pins used for 2 enablers in the L298 motor drive. Left and Right respectively.

◆ PORTD 2, 3, 4, 5 pins used for inputs of the motor drive (Input 1,2,3,4 respectively)

◆ PORTD 0 (RX) pin used to recieve IR inputs for Serial Communication

Following code is only explaining the code that I wrote. For the full code use the Self_Parking_Robot_Car.asm file.
✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶✶
