.MODEL Small
.STACK 100h
.DATA
    MenuMessage DB 10,13, 'Chuong trinh Assembly Menu$'
    Choose DB 10,13,'Vui long chon chuc nang : $'
    Function1Message DB 10,13, '1. Chuyen doi he 10 sang he 2$'
    Function2Message DB 10,13, '2. Chuyen doi he 10 sang he 16$'
    Function3Message DB 10,13, '3. Tinh tong,hieu,tich 2 so nho hon 10$'
    Function4Message DB 10,13, '4. Hien thi day so Fibonacci n phan tu dau tien$'
    Function5Message DB 10,13, '5. Thoat$'
    
    KyTu DB ? ; khoi tao bien ky tu khong co gia tri ban dau
    
    ; khoi tao cac bien de chuyen tu he 10 sang he 2
    InputPrompt1	DB 10, 13, 'Nhap : $'
    Resultf1 DB 10, 13, 'So da nhap dang nhi phan: $'
    str1 DB 5 dup ('$'); nhap vao 1 chuoi toi da 5 ky tu
        
    ; khoi tao cac bien de chuyen tu he 10 sang he 16
    InputPrompt2 DB 10,13, 'Nhap : $'
    crlf db 13, 10, '$'
    C dw 0
    base_dec dw 10
    base_bin dw 2 
    base_hex dw 16 
    str2 db '0123456789ABCDEF'
    
    ; khoi tao cac bien de tinh tong,hieu,tich 2 so nho hon 10
    a db ?
    b db ?
    tong db ?   
    hieu db ?          
    tich db ?
    tb1 db 10,13, 'Nhap a: $'
    tb2 db 'Nhap b: $'
    tb3 db 10,13, 'Tong: $'     
    tb4 db 10,13, 'Hieu: $'     
    tb5 db 10,13, 'Tich: $'
    xdvdd db 13,10,'$'
    
    ; Cac bien tinh so Fibonacci
    InputPrompt4 DB 10,13, 'Nhap n: $'
    RESULT DB 13,10,13,10, 'Chuoi so Fibonacci$'
    First DB 0
    Second DB 1
    SUM DB ?
    N DW ?     
    
.CODE
MAIN Proc
    MOV AX, @DATA
    MOV DS, AX
    ; Dat lai cac gia tri cho phan chuc nang fibonacci
    
    ; Hien thi dong thong bao Menu
    LEA DX, MenuMessage
    MOV AH, 9
    INT 21H

    
    ; Hien thi cac dong thong bao chuc nang
    LEA DX, Function1Message
    MOV AH, 9
    INT 21H
    
    LEA DX, Function2Message
    MOV AH, 9
    INT 21H
       
    LEA DX, Function3Message
    MOV AH, 9
    INT 21H
    
    LEA DX, Function4Message
    MOV AH, 9
    INT 21H
    
    LEA DX, Function5Message
    MOV AH, 9
    INT 21H
    
    ; Hien thi dong chon chuc nang
    LEA DX, Choose
    MOV AH, 9
    INT 21H
    
    ; Dung ngat loai 1 de chon chuc nang
    MOV AH, 1
    INT 21H
    MOV KyTu, AL ; Gan gia tri vua nhap ( Duoc luu o AL ) vao bien KyTu
    
    ; Chuyen doi ki tu so sang so nguyen
    SUB AL, '0'
    
    ; Xu ly chon lua
    CMP AL, 1
    JE Function1
    CMP AL, 2
    JE Function2
    CMP AL, 3
    JE Function3
    CMP AL, 4
    JE Function4
    CMP AL, 5
    JE Function5

    ; Neu khong chon tu 1 den 5 se quay lai
    JMP MAIN

Function1:
    LEA DX, Function1Message
    MOV AH, 9
    INT 21H
    ; Goi ham xu ly chuc nang 1
    CALL f1
    JMP MAIN

Function2:
    LEA DX, Function2Message
    MOV AH, 9
    INT 21H
    ; Goi ham xu ly chuc nang 2
    CALL f2
    JMP MAIN

Function3:
    LEA DX, Function3Message
    MOV AH, 9
    INT 21H
    ; Goi ham xu ly chuc nang 3
    CALL f3
    JMP MAIN

Function4:
    LEA DX, Function4Message
    MOV AH, 9
    INT 21H
    ; Goi ham xu ly chuc nang 4
    CALL f4
    JMP MAIN

Function5:
    LEA DX, Function5Message
    MOV AH, 9
    INT 21H
    ; Goi ham xu ly chuc nang 5
    CALL f5
MAIN Endp

; Cac ham chuc nang
f1 Proc
    ; Xu ly chuc nang 1
    ; ...
	LEA DX,	InputPrompt1
	MOV AH, 9
	INT 21H
	
	MOV AH, 10
    LEA DX, str1 ; nhap chuoi str  
    INT 21h 
    
   ;Chuyen chuoi thanh so:
    MOV CL, [str1+1] ; lay so ky tu cua chuoi ( vd :cl=2 )
    LEA SI, str1+2 ; tro den dia chi cua ky tu dau tien cua chuoi str
    MOV AX, 0 ; ax=0 123
    MOV BX, 10 ;bx=10 ;he so nhan
     
    thapphan:; chuyen chuoi thanh so     123;0*10+1 1*10+2; 12*10+3
        MUL BX  ;nhan 10
        MOV DL, [SI] ; dl='1'
        SUB DL, '0'; dl=1
        ADD AX, DX  ;ax=ax+dx
        INC SI ;increase tang si 1 down vi
        LOOP thapphan   

   ;Chuyen thanh so nhi phan: 10- 1010
    MOV CL, 2 ; he so chia  
    
    nhiphan: ;chuyen so thap phan sang nhi phan va day cac so vao ngan xep
        MOV AH, 0  ;phan du =0
        DIV CL ; chia ax cho 2
        PUSH AX ; day ax vao ngan xep (al+ah)
        CMP AL, 0 ;so sanh thuong#0 tiep tuc chia
        JNE nhiphan  ;jump not eual
   
    MOV AH, 9
    LEA DX, Resultf1;in ra thb1  
    INT 21h 
    
    MOV AH, 2
    Inra:
        POP DX  ;lay tung phan tu trong ngan xep
        CMP DX, '#'
        JE Done  ;jump equal
        MOV DL, DH  ;lay duoc so tu ngan xep   :1 0 1 0
        ADD DL, '0' ; convert tu 1 so sang ky tu '1' '0' '1' '0'
        INT 21h
        JMP Inra
    Done:
        MOV AH, 4Ch
        INT 21h 

    RET
    
    JMP Main
f1 Endp

f2 Proc
    ; Xu ly chuc nang 2
    ; Hien ra thong bao nhap
    LEA DX, InputPrompt2
    MOV AH,9
    INT 21H
    
loop_input: 
    mov AH, 1
    int 21H
    
    ; Kiem tra co phai la ki tu enter hay khong
    cmp AL, 13
    je end_input ; Jump end
    
    sub AL, '0' ; Chuyen doi ky tu so tu ASCII sang gia tri nguyen
    xor AH, AH ; Xoa thanh ghi AH
    push ax ; Day gia tri AX vao ngan xep
    mov ax, C ; Gan gia tri A vao thanh ghi AX
    mul base_dec ;Nhan gia tri cua AX voi gia tri cua bien base_dec. Ket qua duoc luu trong thanh ghi DX:AX
    mov C, AX
    pop AX 
    add C, AX
    jmp loop_input
    
end_input:
    mov ah, 9
    lea dx, crlf
    int 21h
    
    mov ax, C   
    
     mov cx, 0
Loop_output:
    mov dx, 0
    div base_hex
    push dx
    inc cx
    cmp ax, 0
    jg Loop_output 
    
    mov ah, 2
Show:
   
    pop si
    add si, (str2)
    mov dl, [si]
    int 21h
    Loop Show
    
    RET
    
    JMP Main
f2 Endp

f3 Proc
    ; Xu ly chuc nang 3
    mov ah,9
    lea dx,tb1
    int 21h         
              
    ;Nhap a
    mov ah,1
    int 21h
    sub al,30h
    mov a,al
       
    ; Xuong dong
    mov ah,9
    lea dx,xdvdd
    int 21h
    
    ; In ra tb2
    mov ah,9
    lea dx,tb2
    int 21h   

    ; Nhap b            
    mov ah,1
    int 21h
    sub al,30h
    mov b,al             
    
    ; tinh tong
    mov al,a
    add al,b
    mov tong,al  
    
    ; tinh hieu
    mov al,a
    sub al,b
    mov hieu,al  
    
    ; tinh tich
    mov al,a    
    mov bl,b
    imul bl
    mov tich,al 
    
    ; Xuong dong
    mov ah,9
    lea dx,xdvdd
    int 21h    
    
    ; in ra tb3
    mov ah,9
    lea dx,tb3
    int 21h     
    
    ; in ra ket qua        
    mov ah,2       
    mov dl,tong       
    
    ; inc dl - tang dl 1 don vi
    add dl,30h
    int 21h  
    
    ; in ra tb4
    mov ah,9
    lea dx,tb4
    int 21h
    
    ; in ra ket qua        
    mov ah,2       
    mov dl,hieu  
    ; inc dl - tang dl 1 don vi
    add dl,30h
    int 21h      
    
    ; in ra tb5
    mov ah,9
    lea dx,tb5
    int 21h
    
    ; in ra ket qua        
    mov ah,2       
    mov dl,tich  
    ; inc dl - tang dl 1 don vi
    add dl,30h
    int 21h
    RET
    
    JMP Main
f3 Endp

f4 Proc
    ; Xu ly chuc nang 4 - Tinh day so Fibonacci trong vung nhap
    ; Bien luan
    ; 0 = 0 ,1 = 1,0 + 1 = 1,1 + 1 = 2,2 + 1 = 3,3 + 2 = 5
    ; FIRST = 0, SECOND = 1, SUM = FIRST + SECOND, FIRST = SECOND, SECOND = SUM
    ; Hien thong bao nhap
    ; Gan lai gia tri de luu gia tri vao lan bam tiep theo
    MOV First, 0
    MOV Second, 1
    MOV SUM, 0
    MOV N, 0
    
    MOV DX, OFFSET InputPrompt4
    MOV AH, 9
    INT 21H

    ; Xu ly Code tu day
    MOV N, 0    ; N = 0
    MOV BL, 10  ; BL = 10

INPUT:
    MOV AH, 1 ; Lay Input
    INT 21H
    CMP AL, 13 ; Neu Input == Enter
    JE NEXT    ; Jump Equal to Next
    SUB AL, '0'
    MOV AH, 0
    MOV CX, AX ; CX = AX
    MOV AX, N  ; AX = N
    MUL BL     ; AX = AX * BL
    ADD AX, CX ; AX = AX + CX
    MOV N, AX  ; N = AX
    JMP INPUT
    ; Nhap Code ket thuc

NEXT:
    LEA DX, RESULT
    MOV AH, 9
    INT 21H

    MOV CX, N ; CX = N
L:
    PUSH CX

    MOV DL, 10
    MOV AH, 2
    INT 21H

    MOV DL, 13
    MOV AH, 2
    INT 21H

    MOV BL, First  ; F = 0
    ADD BL, Second  ; BL = BL + S
    MOV SUM, BL; SUM = BL

    ; Code ket qua
    MOV AH, 0   ; AH = 0
    MOV AL, SUM ; AL = SUM

    ; Hien ra man hinh
    MOV DX, 0
    MOV BX, 10
    MOV CX, 0
L1:
    DIV BX
    PUSH DX
    MOV DX, 0   ; DX = 0
    MOV AH, 0   ; AX AH 000000 AL = Thuong so
    INC CX      ; Tang CX len 1
    CMP AX, 0
    JNE L1
    MOV AH, 2
L2:
    POP DX
    ADD DX, 48
    INT 21H
    LOOP L2
    ; Dong code Ouput ket thuc

    MOV BL, Second ; BL = Second
    MOV First, BL ; First = BL

    MOV BL, SUM; BL = SUM
    MOV Second, BL ; S = BL

    POP CX
    LOOP L

RET
    
    JMP MAIN
f4 Endp

f5 Proc
    ; Thoat chuong trinh
    MOV AH, 4CH
    INT 21H

f5 Endp
end