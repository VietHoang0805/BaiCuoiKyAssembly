.MODEL Small
.STACK 100
.DATA
    MenuMessage DB 10,13, 'Chuong trinh Assembly Menu$'
    Choose DB 10,13,'Vui long chon chuc nang : $'
    Function1Message DB 10,13, '1. Chuyen doi he 10 sang he 2$'
    Function2Message DB 10,13, '2. Chuyen doi he 10 sang he 16$'
    Function3Message DB 10,13, '3. Tinh tong,hieu 2 so nho hon 10$'
    Function4Message DB 10,13, '4. Hien thi day so Fibonacci n phan tu dau tien$'
    Function5Message DB 10,13, '5. Thoat$'
    
    KyTu DB ? ; khoi tao bien ky tu khong co gia tri ban dau
    
    ; khoi tao cac bien de chuyen tu he 10 sang he 2
    InputPrompt1	DB 10, 13, 'Nhap : $'
    Resultf1 DB 10, 13, 'So da nhap dang nhi phan: $'
    hai dw 2
        
    ; khoi tao cac bien de chuyen tu he 10 sang he 16
    InputPrompt2 DB 10,13, 'Nhap : $'
    enter db 13, 10, '$'
    C dw 0
    muoi dw 10 
    muoisau dw 16
    ; Bang ma chua ki tu Hex tuong ung 
    str2 db '0123456789ABCDEF'
    
    ; khoi tao cac bien cho viec tinh tong cac so nhap vao
    a db ?
    b db ?
    tong db ?   
    hieu db ?          
    tb1 db 10,13, 'Nhap a: $'
    tb2 db 'Nhap b: $'
    tb3 db 10,13, 'Tong: $'     
    tb4 db 10,13, 'Hieu: $'     
    xdvdd db 13,10,'$'
    
    
    ; Cac bien tinh so Fibonacci
    InputPrompt4 DB 10,13, 'Nhap n: $'
    Resultf4 DB 13,10,13,10, 'Chuoi so Fibonacci$'
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
        	
        	; Nhap ki tu
        	MOV AH,0
            INT 21H
            ; CHuyen Al ve dang ASCII
            SUB AL,'0'  ; chuyen ki tu nhap vao la 1 so
            MOV AH,0  
            MOV DX,0 ; Cho DX = 0 tuc la dua so du = 0
            MOV CX,0 ; Cho CX = 0 de dem so luong chu so
            
       NhiPhan:
            DIV hai  ; Day la phep chia 16 bit nen AX = AX : 2 du o DX
            PUSH DX ; Day so du vao ngan xep
            MOV AH,0 ; Gan AH = 0
            INC CX   ; Tang CX len 1 don vi
            CMP AX,0  ; So sanh AX = 0 thi se dung vong lap
            JNE NhiPhan
            
            MOV AH,9
            LEA DX,Resultf1
            INT 21H
       Hienthi_1:    
            POP DX   ; Lay so du ra khoi ngan xep
            ADD DX,'0'; Chuyen doi so du chua o DX tu dang so nguyen sang ki tu ASCII tuong ung vi du 0 co gia tri la 48
            MOV AH,2 ; Hien thi ki tu ra man hinh
            INT 21H
            
            LOOP Hienthi_1
            

    RET
    
    JMP Main
f1 Endp

f2 Proc
    ; Xu ly chuc nang 2
    ; Gan lai cac gia tri tu dau
    MOV C,0
    MOV muoi, 10 
    MOV muoisau, 16
    ; Hien ra thong bao nhap
    LEA DX, InputPrompt2
    MOV AH,9
    INT 21H
    
Vonglap_dauvao: 
    ; Nhap ki tu
    MOV AH, 1
    INT 21H
    
    ; Kiem tra co phai la ki tu enter hay khong
    CMP AL, 13
    JE ketthuc_dauvao ; Jump end
    ; Chuyen doi ky tu so sang so va tich luy so vao bien C
    SUB AL, '0' ; Chuyen doi ky tu so tu ASCII sang gia tri nguyen
    MOV AH,0 ; Xoa thanh ghi AH
    PUSH AX ; Day gia tri AX vao ngan xep
    MOV AX, C ; Gan gia tri C vao thanh ghi AX, AX = 0
    MUL muoi ;AX = AX * 10; ket qua duoc luu vao o AX,DX cao o DX, thap o AX
    MOV C, AX
    POP AX  ; Lay gia tri tu so nguyen ban dau tu ngan xep de tiep tuc vong lap
    ADD C, AX ; C = C + AX
    JMP Vonglap_dauvao
    
ketthuc_dauvao:
    MOV AH, 9
    LEA DX, enter
    INT 21h
    
    MOV AX, C   
    
    MOV CX, 0
Vonglap_daura:
    MOV DX, 0
    DIV muoisau ; AX = C / 16 du o DX
    PUSH DX ; Day phan du vao trong ngan xep
    INC CX ; Tang bien dem CX
    CMP AX, 0
    JNE Vonglap_daura ; Jump Not Equal Tiep tuc vong lap neu AX # 0
    
    MOV AH, 2
Hienthi_2:
    ; Thanh ghi SI duoc su dung viec xu ly voi cac chuoi ki tu trong str 2
    POP SI ; Gan gia tri trong ngan xep vao thanh ghi SI
    ADD SI, <str2>; giup SI truy cap vao chuoi cua str2 boi vi co dau <>
    MOV DL, [SI]
    INT 21h
    Loop Hienthi_2
    
    RET
    
    JMP Main
f2 Endp

f3 Proc
    ; Xu ly chuc nang 3
    ;In ra tb1
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
    mov AH,2       
    mov DL,hieu  
    ; inc dl - tang dl 1 don vi
    ADD DL,30h
    INT 21H
    

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
    LEA DX, Resultf4
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
    ADD DX, '0'
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