.model small
.stack 100h


.data
	user_name db 0
	inputstr db "Enter your name: ", "$"
	input_row db 11
	input_col db 25
	input_bx_cor dw 190
	input_by_cor dw 150
	input_bcolour db 15
	main_str db "BRICK BREAKER", "$"
	new_game_str db "New Game", "$"
	resume_str db "Resume", "$"
	instructions_str db "Instructions", "$"
	high_score_str db "High Score", "$"
	exit_str db "Exit", "$"
	main_menu_str db "Main Menu", "$"
	welcome_bx_cor dw 190
	welcome_by_cor dw 50
	welcome_bcolour db 15
	welcome_select_colour db 2
	welcome_select db 1
	welcome_box dw 5
	instruction_str2 db "INSTRUCTIONS", "$"
	instruct_string1 db "1. Use the left key, <-, and the right key, ->, to move the paddle.", "$"
	instruct_string2 db "2. The ball will bounce off the boundries and the paddle.", "$"
	instruct_string3 db "3. DO NOT LET IT FALL BELOW!", "$"
	instruct_string4 db "4. When the ball hits a brick, that brick will take damage.", "$"
	instruct_string5 db "5. Your task is to destroy all bricks and make sure the ball doesn't fall.", "$"
	instruct_string6 db "HAVE FUN!!!", "$"
	press_any_key db "Press any key to continue", "$"
	back_space_exit db "Press backspace to exit to main menu", "$"
	l_col db 2
	r_col db 12
	bx_cor dw 0
	by_cor dw 35
	lp dw 0
	border_colour db 15
	border_pixels db 5
	brick_row db 6
	brick_color db 0
	paddle_colour db 15
	paddle_right_col db 42
	paddle_left_col db 32
	scores db "Score: ", "$"
	score_count dw 0
	win_str db "YOU WIN!!!", "$"
	win_str_colour db 15
	win_str_time db 30
	lose_str db "YOU LOSE!!!", "$"
	lose_str_colour db 15
	lose_str_time dw 1500

	
	file_name db "scores.txt", 0
	file_handler dw ?
	buffer db 5000 dup("$")
	temp_buffer db 5000 dup("$")
	buffer_count dw 0

	hs1_str db 50 dup("$")
	hs2_str db 50 dup("$")
	hs3_str db 50 dup("$")
	hs4_str db 50 dup("$")
	hs5_str db 50 dup("$")

	hs1 dw 0
	hs2 dw 0
	hs3 dw 0
	hs4 dw 0
	hs5 dw 0

.code
	mov ax, @data
	mov ds, ax
	mov ax, 0
	
	;video mode (graphic) 
	mov ah, 0
	mov al, 10h    ;640 x 350 resolution
	int 10h
	

;	///////////// NAME INPUT START /////////////
;upper border side
	mov cx, 240
	input_border1:
		mov lp, cx
		MOV CX, input_bx_cor    ;x-cordinate (column)
		MOV DX, input_by_cor    ;y-cordinate (row)
		MOV AL, input_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		inc input_bx_cor
		mov cx, lp
	loop input_border1

;right border side
	mov cx, 20
	input_border2:
		mov lp, cx
		MOV CX, input_bx_cor    ;x-cordinate (column)
		MOV DX, input_by_cor    ;y-cordinate (row)
		MOV AL, input_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		inc input_by_cor
		mov cx, lp
	loop input_border2
	
;bottom border side
	mov cx, 240
	input_border3:
		mov lp, cx
		MOV CX, input_bx_cor    ;x-cordinate (column)
		MOV DX, input_by_cor    ;y-cordinate (row)
		MOV AL, input_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		dec input_bx_cor
		mov cx, lp
	loop input_border3
	
;left border side
	mov cx, 20
	input_border4:
		mov lp, cx
		MOV CX, input_bx_cor    ;x-cordinate (column)
		MOV DX, input_by_cor    ;y-cordinate (row)
		MOV AL, input_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		dec input_by_cor
		mov cx, lp
	loop input_border4

	
	mov si, offset inputstr
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, input_row     ;row
	mov dl, input_col     ;column
	int 10h

	mov si, offset user_name

	mov dx, offset inputstr
	mov ah, 9
	int 21h  
            
	again:
		mov ah,1
		int 16h
	jz again
                
	mov ah,0
	int 16h
	cmp al, 13
	je end_input
	mov dl, al
	mov ah, 2
	int 21h
	mov byte ptr[si], dl
	inc si
	jmp again
 
end_input:
	mov byte ptr[si], '$'
 
	mov ah, 2
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	
	mov ah, 0
	mov al, 10h
	int 10h
;	///////////// NAME INPUT END /////////////

;	///////////// WELCOME PAGE START /////////////

welcome_page:
	

	mov ah, 0
	mov al, 10h
	int 10h
	
;	///////////// Printing Name /////////////		
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 65     ;column
		int 10h

		mov ah,9
		mov dx,OFFSET [user_name]
		int 21h
;	///////////// Printing Ends /////////////

	mov ah, 2
	mov dh, 3     ;row
	mov dl, 30    ;column
	int 10h

	mov dx, offset main_str
	mov ah, 9
	int 21h
	
	mov welcome_bx_cor, 190
	mov welcome_by_cor, 50
	mov welcome_bcolour, 15
	mov welcome_select_colour, 2
	mov welcome_select, 1
	mov welcome_box, 5

welcome_repeat:
	add welcome_by_cor, 20
;upper border side
	mov cx, 200
	welcome_border1:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		inc welcome_bx_cor
		mov cx, lp
	loop welcome_border1

;right border side
	mov cx, 40
	welcome_border2:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		inc welcome_by_cor
		mov cx, lp
	loop welcome_border2
	
;bottom border side
	mov cx, 200
	welcome_border3:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		dec welcome_bx_cor
		mov cx, lp
	loop welcome_border3
	
;left border side
	mov cx, 40
	welcome_border4:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_bcolour     ; color
		MOV AH, 0CH 
		INT 10H
		dec welcome_by_cor
		mov cx, lp
	loop welcome_border4

	add welcome_by_cor, 35
	
	dec welcome_box
	cmp welcome_box, 0
	jl welcome_cursor
	jg welcome_repeat
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 6    ;row
	mov dl, 32    ;column
	int 10h

	mov ah, 9
	mov dx, offset new_game_str
	int 21h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 10     ;row
	mov dl, 33    ;column
	int 10h

	mov ah, 9
	mov dx, offset resume_str
	int 21h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 14     ;row
	mov dl, 30    ;column
	int 10h

	mov ah, 9
	mov dx, offset instructions_str
	int 21h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 18     ;row
	mov dl, 31    ;column
	int 10h

	mov ah, 9
	mov dx, offset high_score_str
	int 21h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 22     ;row
	mov dl, 34    ;column
	int 10h

	mov ah, 9
	mov dx, offset exit_str
	int 21h

welcome_cursor:

	extra_key_pressed1:
		mov ah,1
		int 16h
	jz extra_key_pressed1
	
	
	mov welcome_bx_cor, 190
	mov welcome_by_cor, 50
	mov welcome_bcolour, 15

	add welcome_by_cor, 20
;upper border side
	mov cx, 200
	welcome_border11:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_select_colour     ; color
		MOV AH, 0CH 
		INT 10H
		inc welcome_bx_cor
		mov cx, lp
	loop welcome_border11

;right border side
	mov cx, 40
	welcome_border21:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_select_colour     ; color
		MOV AH, 0CH 
		INT 10H
		inc welcome_by_cor
		mov cx, lp
	loop welcome_border21
	
;bottom border side
	mov cx, 200
	welcome_border31:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_select_colour     ; color
		MOV AH, 0CH 
		INT 10H
		dec welcome_bx_cor
		mov cx, lp
	loop welcome_border31
	
;left border side
	mov cx, 40
	welcome_border41:
		mov lp, cx
		MOV CX, welcome_bx_cor    ;x-cordinate (column)
		MOV DX, welcome_by_cor    ;y-cordinate (row)
		MOV AL, welcome_select_colour     ; color
		MOV AH, 0CH 
		INT 10H
		dec welcome_by_cor
		mov cx, lp
	loop welcome_border41
	add welcome_by_cor, 35

	
	key1:
		mov ah,1
		int 16h
	jz key1

	mov ah,0
	int 16h
	cmp ah, 48h
	je welcome_up
	cmp ah, 50h
	je welcome_down
	cmp al, 13
	je welcome_end

	jmp key1



welcome_up:
	cmp welcome_by_cor, 110
	jle key1
	sub welcome_by_cor, 55		
	mov welcome_bcolour, 15
	add welcome_by_cor, 20
	;upper border side
		mov cx, 200
		welcome_border121:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_bx_cor
			mov cx, lp
		loop welcome_border121

	;right border side
		mov cx, 40
		welcome_border221:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_by_cor
			mov cx, lp
		loop welcome_border221
	
	;bottom border side
		mov cx, 200
		welcome_border321:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_bx_cor
			mov cx, lp
		loop welcome_border321
	
	;left border side
		mov cx, 40
		welcome_border421:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_by_cor
			mov cx, lp
		loop welcome_border421
		sub welcome_by_cor, 35

	mov al, welcome_select_colour
	mov welcome_bcolour, al
		sub welcome_by_cor, 20
		;upper border side
		mov cx, 200
		welcome_border122:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_bx_cor
			mov cx, lp
		loop welcome_border122

	;right border side
		mov cx, 40
		welcome_border222:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_by_cor
			mov cx, lp
		loop welcome_border222
	
	;bottom border side
		mov cx, 200
		welcome_border322:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_bx_cor
			mov cx, lp
		loop welcome_border322
	
	;left border side
		mov cx, 40
		welcome_border422:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_by_cor
			mov cx, lp
		loop welcome_border422
		add welcome_by_cor, 35
		dec welcome_select
	jmp key1

welcome_down:
	cmp welcome_by_cor, 325
	jge key1
	sub welcome_by_cor, 55
	mov welcome_bcolour, 15
		add welcome_by_cor, 20
		;upper border side
		mov cx, 200
		welcome_border131:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_bx_cor
			mov cx, lp
		loop welcome_border131

	;right border side
		mov cx, 40
		welcome_border231:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_by_cor
			mov cx, lp
		loop welcome_border231
	
	;bottom border side
		mov cx, 200
		welcome_border331:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_bx_cor
			mov cx, lp
		loop welcome_border331
	
	;left border side
		mov cx, 40
		welcome_border431:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_by_cor
			mov cx, lp
		loop welcome_border431
		add welcome_by_cor, 35

	
	mov al, welcome_select_colour
	mov welcome_bcolour, al
			add welcome_by_cor, 20
		;upper border side
		mov cx, 200
		welcome_border132:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_bx_cor
			mov cx, lp
		loop welcome_border132

	;right border side
		mov cx, 40
		welcome_border232:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			inc welcome_by_cor
			mov cx, lp
		loop welcome_border232
	
	;bottom border side
		mov cx, 200
		welcome_border332:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_bx_cor
			mov cx, lp
		loop welcome_border332
	
	;left border side
		mov cx, 40
		welcome_border432:
			mov lp, cx
			MOV CX, welcome_bx_cor    ;x-cordinate (column)
			MOV DX, welcome_by_cor    ;y-cordinate (row)
			MOV AL, welcome_bcolour     ; color
			MOV AH, 0CH 
			INT 10H
			dec welcome_by_cor
			mov cx, lp
		loop welcome_border432
		add welcome_by_cor, 35
		inc welcome_select
		
	jmp key1

;	///////////// WELCOME PAGE END /////////////

welcome_end:
	cmp welcome_select, 2
	jle game
	cmp welcome_select, 3
	je instruct
	cmp welcome_select, 4
	je high_score
	cmp welcome_select, 5
	je exit

game:
	mov ah, 0
	mov al, 10h
	int 10h
	mov ax, 0

;	///////////// BORDER START /////////////
	mov Border_pixels,5
	mov l_col, 2
	mov r_col, 12
	mov bx_cor, 0
	mov by_cor, 35
	mov lp, 0
	mov border_colour, 15
	mov border_pixels, 5
	mov brick_row, 6
	mov brick_color, 0
	mov Border_pixels,5
;upper border side
	mov cx, 639
	border_loop1:
		mov lp, cx
		MOV CX, bx_cor    ;x-cordinate (column)
		MOV DX, by_cor    ;y-cordinate (row)
		MOV AL, border_colour     ; color
		MOV AH, 0CH 
		INT 10H
		Border_pixels_loop1:
		inc dx
		INT 10H
		dec Border_pixels
		cmp Border_pixels,0
		JNE Border_pixels_loop1
		mov Border_pixels,5
		inc bx_cor
		mov cx, lp
	loop border_loop1
	mov by_cor,0
	;upper border side also
	mov cx, 639
	border_loop12:
		mov lp, cx
		MOV CX, bx_cor    ;x-cordinate (column)
		MOV DX, by_cor    ;y-cordinate (row)
		MOV AL, border_colour     ; color
		MOV AH, 0CH 
		INT 10H
		Border_pixels_loop11:
		inc dx
		INT 10H
		dec Border_pixels
		cmp Border_pixels,0
		JNE Border_pixels_loop11
		mov Border_pixels,5
		inc bx_cor
		mov cx, lp
	loop border_loop12
	mov Border_pixels,5
	mov by_cor,0
;	///////////// Dilbar START /////////////
		
		;///Pehla Pyaar////
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 3     ;column
		int 10h

		mov al,3    ;ASCII code of Character 
		mov bx,0
		mov bl,0100b   ;Red color
		mov cx,1       ;repetition count
		mov ah,09h
		int 10h
		
		;///Dosra Pyaar////
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 5     ;column
		int 10h

		mov al,3    ;ASCII code of Character 
		mov bx,0
		mov bl,0100b   ;Red color
		mov cx,1       ;repetition count
		mov ah,09h
		int 10h
		;///Koi sa Pyaar////
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 7     ;column
		int 10h

		mov al,3    ;ASCII code of Character 
		mov bx,0
		mov bl,0100b   ;Red color
		mov cx,1       ;repetition count
		mov ah,09h
		int 10h
;	///////////// Dilbar Never Stops /////////////
		
;	///////////// Printing Name /////////////		
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 65     ;column
		int 10h

		mov ah,9
		mov dx,OFFSET [user_name]
		int 21h
;	///////////// Printing Ends /////////////

;	///////////// Printing Score /////////////		
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 35     ;column
		int 10h

		mov ah,9
		mov dx,OFFSET [scores]
		int 21h
;	///////////// Printing Ends /////////////


;right border side
	mov cx, 349
	border_loop2:
		mov lp, cx
		MOV CX, bx_cor    ;x-cordinate (column)
		MOV DX, by_cor    ;y-cordinate (row)
		MOV AL, border_colour     ; color
		MOV AH, 0CH 
		INT 10H
		Border_pixels_loop2:
		dec cx
		INT 10H
		dec Border_pixels
		cmp Border_pixels,0
		JNE Border_pixels_loop2
		mov Border_pixels,5
		inc by_cor
		mov cx, lp
	loop border_loop2
	mov Border_pixels,5
;bottom border side
	mov cx, 639
	border_loop3:
		mov lp, cx
		MOV CX, bx_cor    ;x-cordinate (column)
		MOV DX, by_cor    ;y-cordinate (row)
		MOV AL, border_colour     ; color
		MOV AH, 0CH 
		;INT 10H
		Border_pixels_loop3:
		dec dx
		;INT 10H
		dec Border_pixels
		cmp Border_pixels,0
		JNE Border_pixels_loop3
		mov Border_pixels,5
		dec bx_cor
		mov cx, lp
	loop border_loop3
	mov Border_pixels,5
;left border side
	mov cx, 349
	border_loop4:
		mov lp, cx
		MOV CX, bx_cor    ;x-cordinate (column)
		MOV DX, by_cor    ;y-cordinate (row)
		MOV AL, border_colour     ; color
		MOV AH, 0CH 
		INT 10H
		Border_pixels_loop4:
		inc cx
		INT 10H
		dec Border_pixels
		cmp Border_pixels,0
		JNE Border_pixels_loop4
		mov Border_pixels,5
		dec by_cor
		mov cx, lp
	loop border_loop4
;	///////////// BORDER END /////////////


;	///////////// BRICKS START /////////////
	mov ah, 6
	mov al, 0
	mov bh, 13				;color
	mov ch, 5		;top row of window
	mov cl, 1		;left most column of window
	mov dh, 6		;Bottom row of window
	mov dl, 9		;Right most column of window
	mov brick_color,1

	brick_row1:
		Add cl,10
		Add dl,10
		int 10h
		dec brick_row
		cmp brick_color,1
		JE change
		JNE nochange
	
	change:
		mov brick_color,0
		mov bh, 17	;color
		jmp cont

	nochange:
		mov brick_color,1
		mov bh, 13	;color
	
	cont:
		cmp brick_row,0
		JNE brick_row1

	mov ah, 6
	mov al, 0
	mov bh, 9				;color
	mov ch, 8		;top row of window
	mov cl, -5		;left most column of window
	mov dh, 9		;Bottom row of window
	mov dl, 3		;Right most column of window
	mov brick_color,1
	mov brick_row,7
	
	brick_row2:
		Add cl,10
		Add dl,10
		int 10h
		dec brick_row
		cmp brick_color,1
		JE colour_change1
		JNE no_colour_change1
	
	colour_change1:
		mov brick_color,0
		mov bh, 11	;color
		jmp brick_cont1
	
	no_colour_change1:
		mov brick_color,1
		mov bh, 9	;color
	
	brick_cont1:
		cmp brick_row,0
		JNE brick_row2

	mov ah, 6
	mov al, 0
	mov bh, 20				;color
	mov ch, 11		;top row of window
	mov cl, 1		;left most column of window
	mov dh, 12		;Bottom row of window
	mov dl, 9		;Right most column of window
	mov brick_color,1
	mov brick_row,6

	brick_row3:
		Add cl,10
		Add dl,10
		int 10h
		dec brick_row
		cmp brick_color,1
		JE colour_change2
		JNE no_colour_change2
	
	colour_change2:
		mov brick_color,0
		mov bh, 30	;color
		jmp brick_cont2
	
	no_colour_change2:
		mov brick_color,1
		mov bh, 20	;color
		brick_cont2:
		cmp brick_row,0
	JNE brick_row3
;	///////////// BRICKS END /////////////





;	///////////// PADDLE CONTROLS START /////////////
	
	mov paddle_left_col, 32
	mov paddle_right_col, 42

	mov ah, 6
	mov al, 0
	mov bh, paddle_colour         ;color
	mov ch, 22        ;top row of window  
	mov cl, paddle_left_col     ;left most column of window
	mov dh, 22        ;Bottom row of window
	mov dl, paddle_right_col     ;Right most column of window
	int 10h

	key_pressed:
		mov ah,1
		int 16h
	jz key_pressed

	mov ah,0
	int 16h
	cmp ah, 4bh
	je left_paddle
	cmp ah, 4dh
	je right_paddle
	cmp al, 27
	je paused
	cmp al, 13
	je paddle_not_moved

	jmp key_pressed

	left_paddle:
		cmp paddle_left_col, 1
		INT 10H
		je key_pressed
		mov ah, 6
		mov al, 0
		mov bh, 0         ;color
		mov ch, 22        ;top row of window
		mov cl, paddle_left_col     ;left most column of window
		mov dh, 22        ;Bottom row of window
		mov dl, paddle_right_col     ;Right most column of window
		int 10h
		
		sub paddle_left_col, 1
		sub paddle_right_col, 1
		mov ah, 6
		mov al, 0
		mov bh, paddle_colour         ;color
		mov ch, 22        ;top row of window
		mov cl, paddle_left_col     ;left most column of window
		mov dh, 22        ;Bottom row of window
		mov dl, paddle_right_col     ;Right most column of window
		int 10h
	jmp key_pressed
	
	right_paddle:
		cmp paddle_right_col, 78
		je key_pressed
		mov ah, 6
		mov al, 0
		mov bh, 0         ;color
		mov ch, 22        ;top row of window
		mov cl, paddle_left_col     ;left most column of window
		mov dh, 22        ;Bottom row of window
		mov dl, paddle_right_col     ;Right most column of window
		int 10h

		add paddle_left_col, 1
		add paddle_right_col, 1
		mov ah, 6
		mov al, 0
		mov bh, paddle_colour         ;color
		mov ch, 22        ;top row of window  
		mov cl, paddle_left_col     ;left most column of window
		mov dh, 22        ;Bottom row of window
		mov dl, paddle_right_col     ;Right most column of window
		int 10h
	jmp key_pressed
;	///////////// PADDLE CONTROLS END /////////////



;	///////////// PAUSED START /////////////
paused:
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 15     ;row
	mov dl, 35    ;column
	int 10h

	mov al,'P'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 15     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl     ;column
	int 10h

	mov al,'A'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 15     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'U'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 15     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'S'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 15     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'E'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 15     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'D'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 15     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h

	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 17     ;row
	mov dl, 20    ;column
	int 10h

	mov dx, offset back_space_exit
	mov ah, 9
	int 21h

	mov ah,1
	int 16h
	jz paused
	mov ah, 0
	int 16h
	cmp al, 27
	je not_paused
	cmp al, 8
	je welcome_page
	jne paused

not_paused:

	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 17     ;row
	mov dl, 20    ;column
	int 10h	
		
	mov al,'P'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 40      ;repetition count
	mov ah, 09h
	int 10h
	mov cx, lp

	;setting cursor position
	mov ah, 2
	mov bh, 0
	mov dh, 15     ;row
	mov dl, 35    ;column
	int 10h

	mov al,'P'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl     ;column
	int 10h

	mov al,'A'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'U'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'S'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'E'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	
	;setting cursor position
	mov ah, 2
	mov bh, 0
	inc dl
	int 10h

	mov al,'D'    ;ASCII code of Character 
	mov bx, 0
	mov bl, 0     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h

	


	jmp key_pressed
;	///////////// PAUSED END /////////////


;	///////////// INSTRUCTIONS START /////////////
instruct:
	
	mov ah, 0
	mov al, 10h
	int 10h
	
;	///////////// Printing Name /////////////		
		;setting cursor position
		mov ah, 2
		mov dh, 1     ;row
		mov dl, 65     ;column
		int 10h

		mov ah,9
		mov dx,OFFSET [user_name]
		int 21h
;	///////////// Printing Ends /////////////

	mov ah, 2
	mov dh, 3     ;row
	mov dl, 30    ;column
	int 10h

	mov dx, offset instruction_str2
	mov ah, 9
	int 21h

	
	mov ah, 2
	mov dh, 6     ;row
	mov dl, 4    ;column
	int 10h

	mov dx, offset instruct_string1
	mov ah, 9
	int 21h

	mov ah, 2
	mov dh, 8     ;row
	mov dl, 4    ;column
	int 10h

	mov dx, offset instruct_string2
	mov ah, 9
	int 21h
	
	mov ah, 2
	mov dh, 10     ;row
	mov dl, 4    ;column
	int 10h

	mov dx, offset instruct_string3
	mov ah, 9
	int 21h
	
	mov ah, 2
	mov dh, 12     ;row
	mov dl, 4    ;column
	int 10h

	mov dx, offset instruct_string4
	mov ah, 9
	int 21h
	
	mov ah, 2
	mov dh, 14     ;row
	mov dl, 4    ;column
	int 10h

	mov dx, offset instruct_string5
	mov ah, 9
	int 21h

	mov ah, 2
	mov dh, 17     ;row
	mov dl, 30    ;column
	int 10h

	mov dx, offset instruct_string6
	mov ah, 9
	int 21h

	
	mov ah, 2
	mov dh, 20     ;row
	mov dl, 25    ;column
	int 10h

	mov dx, offset press_any_key
	mov ah, 9
	int 21h

	extra_key_pressed2:
		mov ah,1
		int 16h
	jz extra_key_pressed2

	mov ah, 0
	mov al, 10h
	int 10h

	jmp welcome_page
;	///////////// INSTRUCTIONS END /////////////


won:
;	///////////// WIN SCREEN START /////////////

	mov ah, 2
	mov dh, 7     ;row
	mov dl, 30    ;column
	int 10h

	
keep_printing_win:
	cmp win_str_colour, 0 
	jne continue_print_win_str
	mov win_str_colour, 15
continue_print_win_str:
	
	mov lp, 10
win_str_delay:
	mov ah, 2
	mov dh, 7     ;row
	mov dl, 30    ;column
	int 10h
	mov si, offset win_str
print_win_str:
	mov ah, 2
	int 10h
	mov al, byte ptr[si]    ;ASCII code of Character 
	mov bx, 0
	mov bl, win_str_colour     ; color
	mov cx, 1      ;repetition count
	mov ah, 09h
	int 10h
	inc si
	inc dl
	cmp byte ptr[si], '$'
	jne print_win_str
	dec lp
	cmp lp, 0
	jne win_str_delay

	dec win_str_colour
	dec win_str_time
	cmp win_str_time, 0
	jne keep_printing_win
end_print_win_str:

	
	mov ah, 2
	mov dh, 15     ;row
	mov dl, 23   ;column
	int 10h
	
	mov dx, offset press_any_key
	mov ah, 9
	int 21h

	key_pressed_win:
		mov ah,1
		int 16h
	jz key_pressed_win
	
	jmp welcome_page

;	///////////// WIN SCREEN END /////////////



lost:
;	///////////// LOSE SCREEN START /////////////


	
keep_printing_lose:
	mov ah, 2
	mov dh, 7     ;row
	mov dl, 30    ;column
	int 10h
	mov ah, 9
	mov dx, offset lose_str
	int 21h

	;	///////////// Printing Score /////////////		
		;setting cursor position
		mov ah, 2
		mov dh, 9     ;row
		mov dl, 31     ;column
		int 10h

		mov ah,9
		mov dx,OFFSET [scores]
		int 21h
;	///////////// Printing Ends /////////////

	dec lose_str_time
	cmp lose_str_time, 0
	jg keep_printing_lose

	mov ah, 2
	mov dh, 15     ;row
	mov dl, 23   ;column
	int 10h
	
	mov dx, offset press_any_key
	mov ah, 9
	int 21h

	key_pressed_lose:
		mov ah,1
		int 16h
	jz key_pressed_lose

	jmp welcome_page

;	///////////// LOSE SCREEN END /////////////



paddle_not_moved:
high_score:


exit:

mov ah,4ch
int 21h
end