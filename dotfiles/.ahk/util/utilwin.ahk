#SingleInstance Force
#Persistent

; script built for regular ahk

Capslock::Send {Esc} ; capslock becomes esc because I don't use it anyways
+Capslock::Send {Capslock} ; shift caps lock sends caps lock
RAlt::Send {F5} ; right alt presses f5 because I use a 65% and 2 keypresses is 2 too many