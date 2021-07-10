class morse
{
	; --- Static Variables ---

	static lettersDict := {".-": "A", "-...": "B", "-.-.": "C", "-..": "D", ".": "E"
					, "..-.": "F", "--.": "G", "....": "H", "..": "I", ".---": "J"
					, "-.-": "K", ".-..": "L", "--": "M", "-.": "N", "---": "O"
					, ".--.": "P", "--.-": "Q", ".-.": "R", "...": "S", "-": "T"
					, "..-": "U", "...-": "V", ".--": "W", "-..-": "X", "-.--": "Y"
					, "--..": "Z"}

	static numbersDict := {"-----": "0", ".----": "1", "..---": "2", "...--": "3"
					, "....-": "4", ".....": "5", "-....": "6", "--...": "7"
					, "---..": "8", "----.": "9"}

	static nonEnglishDict := {".--.-": "Á"	; A with acute accent
	, ".-.-": "Ä"		; A with diaeresis
	, "..-..": "É"		; E with acute accent
	, "--.--": "Ñ"		; N with tilde
	, "---.": "Ö"		; O with diaeresis
	, "..--": "Ü"		; U with diaeresis
	, "--..--": ","		; comma
	, ".-.-.-": "."		; period
	, "..--..": "?"		; question mark
	, "-.-.-": ";"		; semicolon
	, "---...": ":"		; colon
	, "-..-.": "/"		; slash
	; , "-....-": "-"	; dash
	, ".----.": """"	; apostrophe
	, "-.--.-": "()"	; parenthesis
	, "..--.-": "_"		; underline
	, ".--.-.": "@"		; at symbol from http://www.learnmorsecode.com/
	, ".......": "\ "}	; space

	static punctuationDict := {".......": "` ", "---...": "\:", "--..--": "\,"}

	static extraDict := {".-.-.-": "\."}
	
	; --- Static Methods ---

	encode(param_value) {
		if (isObject(param_value)) {
			outputArr := []
			for _, value in param_value {
				outputArr.push(this.encode(value))
			}
			return outputArr
		}
		; replace dashes
		param_value := regexReplace(param_value, "(\-)", "")
		for code, character in this.extraDict {
			param_value := regexReplace(param_value, "i)" character, code "//")
		}
		for code, character in this.lettersDict {
			param_value := regexReplace(param_value, "i)" character, code "//")
		}
		for code, character in this.numbersDict {
			param_value := regexReplace(param_value, "i)" character, code "//")
		}
		for code, character in this.punctuationDict {
			param_value := regexReplace(param_value, "i)" character, code "//")
		}
		param_value := strReplace(param_value, "//", " ")
		; trim last character as " " is always exists on end
		return subStr(param_value, 1, strLen(param_value) - 1)
	}


	decode(param_value) {
		if (isObject(param_value)) {
			outputArr := []
			for _, value in param_value {
				outputArr.push(this.decode(value))
			}
			return outputArr
		}
		string := ""
		example := strSplit(param_value, " ")
		for _, code in strSplit(param_value, " ") {
			string .= this.lettersDict[code]
			string .= this.numbersDict[code]
			string .= this.punctuationDict[code]
			string .= this.nonEnglishDict[code]
			string .= this.extrasDict[code]
		}
		return string
	}
}
