#Requires AutoHotkey v2.0
#SingleInstance Force

; script built for regular ahk

Capslock::Send("{Esc}") ; capslock becomes esc because I don't use it anyways
Esc & Capslock::SetCapsLockState !GetKeyState("CapsLock", "T")
Esc & 1::Send("{F5}")
Esc & 2::Send("{Up}^a{Delete}{Enter}{Enter}") ; delete last discord message