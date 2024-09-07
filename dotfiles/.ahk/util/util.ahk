#SingleInstance Force
#Persistent

; script built for ahk_x11 instead of stock ahk

Capslock::Send {Esc} ; capslock becomes esc because I don't use it anyways
RAlt::Send {F5} ; right alt presses f5 because I use a 65% and 2 keypresses is 2 too many

; ---------------------------------
;             RK68 part
; ---------------------------------
; (remove if not using rk68 or other 65% keyboard)

PgUp::Send {Home} ; pgup becomes home
PgDn::Send {End} ; aaand pgdown becomes end

+PgUp::Send +{Home}
+PgDn::Send +{End}

^PgUp::Send ^{Home}
^PgDn::Send ^{End}

Home::Send, {PgUp} ; and the reverse of the above code
End::Send, {PgDn}