#Requires AutoHotkey v2.0
#SingleInstance Force

; script built for regular ahk

Capslock::return
Capslock & c::SetCapsLockState !GetKeyState("CapsLock", "T")
Capslock & e::Send("{Esc}")
Capslock & r::Send("{F5}")
Capslock & d::Send("{Up}^a{Delete}{Enter}{Enter}") ; delete last discord message
