
#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include unit-testing.ahk\export.ahk

#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1

; morseObj := new morse()
assert := new unittesting()

assert.group("encode")
assert.label("string")
assert.test(morse.encode("hello world"), ".... . .-.. .-.. --- ....... .-- --- .-. .-.. -..")

assert.label("string with punctuation")
assert.test(morse.encode("hello, world."), ".... . .-.. .-.. --- --..-- ....... .-- --- .-. .-.. -.. .-.-.-")

assert.label("array")
assert.test(morse.encode(["hello", "world"]), [".... . .-.. .-.. ---", ".-- --- .-. .-.. -.."])

assert.group("decode")
assert.label("array")
assert.test(morse.decode([".... . .-.. .-.. ---", ".-- --- .-. .-.. -.."]), ["HELLO", "WORLD"])


assert.fullreport()

ExitApp
