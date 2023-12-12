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
    ; Cac bien tinh so Fibonacci
    InputPrompt DB 10,13, 'Nhap n: $'
    RESULT DB 13,10,13,10, 'Chuoi so Fibonacci$'
    F DB 0
    S DB 1
    SUM DB ?
    N DW ?     
    
.CODE
MAIN Proc
    MOV AX, @DATA
    MOV DS, AX
    ; Dat lai cac gia tri cho phan chuc nang fibonacci
    MOV F, 0
    MOV S, 1
    MOV SUM, 0
    MOV N, 0
    
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

    RET
f1 Endp

f2 Proc
    ; Xu ly chuc nang 2
    ; ...
    RET
f2 Endp

f3 Proc
    ; Xu ly chuc nang 3
    ; ...
    RET
f3 Endp

f4 Proc
    ; Xu ly chuc nang 4 - Tinh day so Fibonacci trong vung nhap
    ; Bien luan
    ; 0 = 0 ,1 = 1,0 + 1 = 1,1 + 1 = 2,2 + 1 = 3,3 + 2 = 5
    ; FIRST = 0, SECOND = 1, SUM = FIRST + SECOND, FIRST = SECOND, SECOND = SUM
    ; Hien thong bao nhap
    MOV DX, OFFSET InputPrompt
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
    SUB AL, 30H
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

    MOV BL, F  ; F = 0
    ADD BL, S  ; BL = BL + S
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
    MOV AH, 0   ; AX AH 000000 AL = QUOTIENT
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

    MOV BL, S ; BL = S
    MOV F, BL ; F = BL

    MOV BL, SUM; BL = SUM
    MOV S, BL ; S = BL

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
