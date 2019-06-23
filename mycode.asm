                             #make_bin#

#LOAD_SEGMENT=FFFFh#
#LOAD_OFFSET=0000h#

#CS=0000h#
#IP=0000h#

#DS=0000h#
#ES=0000h#

#SS=0000h#
#SP=FFFEh#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#
; this header has to remain
; add your code here
         jmp     st1 
;proteus allows you to change the reset address - hence changing it to 00000H - so every time 
;system is reset it will go and execute the instruction at address 00000H - which is jmp st1
         db     509 dup(0)
;jmp st1 will take up 3 bytes in memory - another 509 bytes are filled with '0s'
;509 + 3 bytes = 512 bytes
;first 1 k of memory is IVT - 00000 -00002H will now have the jmp instruction. 00003H - 001FFH will
;have 00000 - as vector number 0 to 79H are unused
;IVT entry for 80H - address for entry is 80H x 4 is 00200H       
         dw     t_isr
; Inst Pointer Value 2 bytes
         dw     0000
;CS is 2 bytes
         db     508 dup(0)
;508 bytes filled with zeros for interrupt vectors 81H to FFH - that are not used.
;main program
;code segment will be in ROM         
st1:      cli 
; intialize ds, es,ss to start of RAM - that is 020000H - as you need r/w capability for DS,ES & SS
; pl note you cannot use db to store data in the RAM you have to use a MOV instruction. 
; so if you want to do dat1 db 78H - you have to say something like
; dat1 equ 0002h
; mov	al,78h
; mov dat1,al
;0002H is the offset in data segmnet where you are storing the data.
;db can be used only to store data in code segment
          mov       ax,0200h
          mov       ds,ax
          mov       es,ax
          mov       ss,ax
          mov       sp,0FFFEH
          
;intialise portA as input portb,portc as output for the first 8255
          mov       al,90h
		  out 		06h,al        

;Keep polling port A until you get 1 from the switch
poll:     in        al,00h
          mov       bl,01h
          cmp       bl,al 
          jnz poll   
                                    
fpoll:

;Initialize portA,B as output and port C isnt connected
          mov       al,10000000b        
          out       0Eh,al        

                     
          mov dx,00h
 ; !!     ;Repeating Code Starts from here!!        -- 1               
 
          
          
star:     mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,11111110b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,11111110b 
          cmp al,bl
          jnz nwow                                  
                                                  
;  !!    Repeating code ends here !!            
  
      
   ; !!     ;Repeating Code Starts from here!!   --  2      
   
   
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,11111101b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,11111101b 
          cmp al,bl
          jnz nwow       
;  !!    Repeating code ends here !!    
  
  
  
  
  
   ; !!     ;Repeating Code Starts from here!!      -- 3            
   
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,11111011b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,11111011b 
          cmp al,bl
          jnz nwow       
;  !!    Repeating code ends here !!   
  
  
; !!     ;Repeating Code Starts from here!!      -- 4    
     
     
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,11110111b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,11110111b 
          cmp al,bl
          jnz nwow       
  ;  !!    Repeating code ends here !!  
  
  
  
  
  
     ; !!     ;Repeating Code Starts from here!!      -- 5 
     
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,11101111b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,11101111b 
          cmp al,bl
          jnz nwow       
  ;  !!    Repeating code ends here !!        
  
  
       ; !!     ;Repeating Code Starts from here!!      -- 6 
       
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,11011111b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,11011111b 
          cmp al,bl
          jnz nwow       
  ;  !!    Repeating code ends here !!          
  
  
  
       ; !!     ;Repeating Code Starts from here!!      -- 7     
       
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
         
         
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,10111111b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,10111111b 
          cmp al,bl
          jnz nwow       
  ;  !!    Repeating code ends here !!  
 
  

 ; !!     ;Repeating Code Starts from here!!      -- 8
 
          mov       al,10010010b    ;Initialize 3rd 8255 to write data ;So port C in output mode
          out       16h,al 
          
          mov al,dl
          out 08h,al
          
          mov al,dh
          and al,10111111b      ;Turn on write enable dash!
          or  al,00100000b      ;Turn off read enable!
          and  al,01111111b     ;Turn on CE!
          
          out 0Ah,al
                                      
                                      
          mov al,01111111b     ; Write from Port C of 3rd 8255
          out 14h,al    
                                            
          
          mov al,dh
          and al,11011111b      ;Turn on read enable!
          or  al,01000000b      ;Turn off write enable dash!  
          and  al,01111111b     ;Turn on CE!              
          out 0Ah,al
                  
    

          mov       al,10011011b    ;Initialize 3rd 8255 to read data : So port C in input mode  
          out       16h,al         
          
          in al,14h
          
          mov bl,01111111b 
          cmp al,bl
          jnz nwow       
  ;  !!    Repeating code ends here !! For all!! 


inc dx
cmp dx,8192d
jz wow

jmp  star
                                                           
          
   
;Fail on LED               
           

nwow:     mov al,0FFh
          out 04,al 
          
          
          mov al,01h
          out 02h,al 
          
          mov al,8eh ;For F
       ;   mov al,0FFh
          out 04h,al 
          
          mov al,02h
          out 02h,al 
          
          mov al,88h        ;For a
      ;   mov al,0FFh
          out 04h,al
          
          
          mov al,00
          out 02h,al
          
          mov al,0ffh
          out 04h,al 
          
           mov al,04h
          out 02h,al
          
          
          mov al,0F9h        ;For I
        ;  mov al,0FFh
          out 04h,al         
          
          
          mov al,08h
          out 02h,al 
          
          mov al,0c7h        ;For L
       ;   mov al,0FFh
          out 04h,al 
          
          mov al,00
          out 02h,al
          
          mov al,0ffh
          out 04h,al     
          
          in        al,00h
          mov       bl,01h
          cmp       bl,al 
          jz fpoll  
                            
          
          jmp nwow
                         
;Pass on LED       

           
                    
wow:       mov al,0FFh
          out 04,al 
          
          
          mov al,01h
          out 02h,al 
          
          mov al,8ch ;For P
       ;   mov al,0FFh
          out 04,al 
          
          mov al,02h
          out 02h,al 
          
          mov al,88h        ;For a
      ;   mov al,0FFh
          out 04,al
          
          mov al,04h
          out 02h,al 
          
          mov al,92h
        ;  mov al,0FFh
          out 04,al         
          
          
          mov al,08h
          out 02h,al 
          
          mov al,92h
       ;   mov al,0FFh
          out 04,al 
          
          mov al,00
          out 02h,al
          
          mov al,0ffh
          out 04h,al      
          
          in        al,00h
          mov       bl,01h
          cmp       bl,al 
          jz fpoll  
                            
          
          jmp wow
          
;sub1 :
;        mov cx,22726d
 ;       
  ;      x1: nop
   ;         dec cx
    ;        jnz x1
     ;   ret


;timer - 1 second - 8253 clock is 10 KHz-divide by 10,000d
;		  mov       al,00110110b
	;	  out       0Eh,al
	;	  mov       al,10h
	;	  out       08h,al
	;	  mov       al,27h
	;	  out       08h,al
;8259 intialize - vector no. 80h, edge triggered
;8259 -	enable IRO alone use AEOI	  
	;	  mov       al,00010011b
	;	  out       10h,al
	;	  mov       al,80h
	;	  out       12h,al
	;	  mov       al,03h
	;	  out       12h,al
	;	  mov       al,0FEh
	;	  out       12h,al
	;	  sti
;check swich input and display switch no.		  		    
;		  in        al,02h
;          cmp       al,0
;          mov       bh,0
;          jz        x3
;          mov       cx,08   
;          mov       bh,01
;          mov       bl,01
;x2:       cmp       al,bl
;          jz        x3
;          inc       bh
;          rol       bl,1
;          loop      x2  
;x3:       mov       al,bh
;          out       04h,al
;loop till isr
;x1:       jmp       x1
;isr for 1 sec
;check switch input and display switch no.
t_isr:    in        al,02h
;          cmp       al,0
;          mov       bh,0
;          jz        x5
;          mov       cx,08   
;          mov       bh,01
;          mov       bl,01
;x4:       cmp       al,bl
;          jz        x5
;          inc       bh
;          rol       bl,1
;          loop      x4  
;x5:       mov       al,bh
;          out       04h,al 
          iret
          
          
