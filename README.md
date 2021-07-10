#morse

A simple Morse code library for AutoHotkey

## Installation

In a terminal or command line:
```bash
npm install morse.ahk
```
In your code only export.ahk needs to be included:
```autohotkey
#Include %A_ScriptDir%\node_modules
#Include morse.ahk\export.ahk

morse := new morse()
result := morse.decode("..-. --- --- ....... -... .- .-.")
; => "foo bar"
```


## API

### .encode(value)

Encodes and returns a given string or array

````autohotkey
encoded := morse.encode("Hello, world.")
; => ".... . .-.. .-.. --- --..-- ....... .-- --- .-. .-.. -.. .-.-.-"

encoded := morse.encode(["hello", "world"])
; => [".... . .-.. .-.. ---", ".-- --- .-. .-.. -.."]

````


### .decode(value)

Decodes and returns a string or array

````autohotkey
morse.decode(".... . .-.. .-.. --- --..-- ....... .-- --- .-. .-.. -.. .-.-.-");
; => HELLO, WORLD.

morse.decode([".... . .-.. .-.. ---", ".-- --- .-. .-.. -.."]);
; => [ "HELLO", "WORLD" ]
````


## attributes

### morse.dict

An object containing `morse: character` translations
