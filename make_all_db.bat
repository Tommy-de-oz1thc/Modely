@echo off
setlocal enabledelayedexpansion

set INPUT=txt\callsigns.txt
set OUTPUT=db\callsigns-db.asm


if not exist txt mkdir txt
if not exist db mkdir db
set PTRFILE=db\temp_ptrs.txt

rem Nulstil outputfiler
> "%OUTPUT%" echo ; Autogenereret NASM db-liste
> "%PTRFILE%" echo ; Midlertidig liste af word_ptrs

set count=1
set ptr_line=
set ptr_block=1

for /f "usebackq delims=" %%A in ("%INPUT%") do (
    for /f "tokens=* delims= " %%B in ("%%A") do set "line=%%B"

    echo ord!count! db "!line!",0 >> "%OUTPUT%"

    set ptr_line=!ptr_line!ord!count!,
    set /a mod=count%%10
    if !mod! equ 0 (
        echo word_ptrs!ptr_block! dd !ptr_line:~0,-1! >> "%PTRFILE%"
        set /a ptr_block+=1
        set ptr_line=
    )

    set /a count+=1
)



rem Tilføj pointer-linjerne til sidst i outputfilen
type "%PTRFILE%" >> "%OUTPUT%"
del "%PTRFILE%"

set /a count-=1
echo Done: !count! lines written to %OUTPUT%
pause
