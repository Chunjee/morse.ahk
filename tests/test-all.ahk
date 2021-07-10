
#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include unit-testing.ahk\export.ahk

#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1

morse := new morse()
assert := new unittesting()

assert.group("encode")
assert.label("string")
assert.test(morse.encode("hello world"), ".... . .-.. .-.. --- ....... .-- --- .-. .-.. -..")

assert.label("string with punctuation")
assert.test(morse.encode("hello, world."), ".... . .-.. .-.. --- --..-- ....... .-- --- .-. .-.. -.. .-.-.-")

assert.label("array")
assert.test(morse.encode(["hello", "world"]), [".... . .-.. .-.. ---", ".-- --- .-. .-.. -.."])

assert.label("non-English")
assert.test(morse.encode("ÄÄÄ"), ".-.- .-.- .-.-")

assert.label("unhandled character")
assert.test(morse.encode("#"), "")



assert.group("decode")
assert.label("string")
assert.test(morse.decode(".... . .-.. .-.. --- ....... .-- --- .-. .-.. -.."), "HELLO WORLD")

assert.label("string with punctuation")
assert.test(morse.decode(".... . .-.. .-.. --- --..-- ....... .-- --- .-. .-.. -.. .-.-.-"), "HELLO, WORLD.")

assert.label("array")
assert.test(morse.decode([".... . .-.. .-.. ---", ".-- --- .-. .-.. -.."]), ["HELLO", "WORLD"])

assert.label("non-English")
assert.test(morse.decode(".-.- .-.- .-.-"), "ÄÄÄ")

assert.label("unhandled character")
assert.test(morse.decode("··−−·−"), "")



assert.fullreport()

ExitApp
