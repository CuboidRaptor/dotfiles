#SingleInstance Force
#Persistent

; script built for ahk_x11 instead of stock ahk

Capslock::Send, {Esc} ; capslock becomes esc because I don't use it anyways
RAlt::Send, {F5} ; right alt presses f5 because I use a 65% and 2 keypresses is 2 too many

; commented as AHK's bugginess and lag gives me great pain
; shift enter kills me because I keep misinputting it and this fixes it (I guess)
; +Enter::
; IfWinActive, Firefox
; {
;     Send, {Blind}{SHIFT up}{Enter}
; }
; else
; {
    ; could potentially trigger the keyup/blind bug but fixing it would cuz some weirdass behaviour
    ; so uh don't do that
;     Send, {Blind}+{Enter}
; }
; return

; ---------------------------------
;             RK68 part
; ---------------------------------
; (remove if not using rk68 or other 65% keyboard)

PgUp::Send, {Home} ; pgup becomes home
PgDn::Send, {End} ; aaand pgdown becomes end

+PgUp::Send, {Blind}{PgUp up}{SHIFT up}+{Home}
+PgDn::Send, {Blind}{PgDn up}{SHIFT up}+{End}

^PgUp::Send, {Blind}{PgUp up}{CTRL up}^{Home}
^PgDn::Send, {Blind}{PgDn up}{CTRL up}^{End}

Home::Send, {PgUp} ; and the reverse of the above code
End::Send, {PgDn}