#SingleInstance Force
#Persistent

; script built for ahk_x11 instead of stock ahk

PgUp::Send {Home} ; pgup becomes home
PgDn::Send {End} ; aaand pgdown becomes end

Home::Send, {PgUp} ; and the reverse of the above code
End::Send, {PgDn}