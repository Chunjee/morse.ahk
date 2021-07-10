class morse
{
	; --- Static Variables ---
	static dict := {}

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
	, "..--": "Ü"}		; U with diaeresis

	static punctuationDict := {"--..--": ","	; comma
	, ".-.-.-": "."		; period
	, "..--..": "?"		; question mark
	, "-.-.-": ";"		; semicolon
	, "---...": ":"		; colon
	, "-..-.": "/"		; slash
	, "-....-": "-"		; dash
	, ".----.": """"	; apostrophe
	, "-.--.-": "()"	; parenthesis
	, "..--.-": "_"		; underline
	, ".--.-.": "@"		; at symbol
	, ".......": " "}	; space
	
	__New() {
		for key, value in this.lettersDict {
			this.dict[key] := value
		}
		for key, value in this.numbersDict {
			this.dict[key] := value
		}
		for key, value in this.nonEnglishDict {
			this.dict[key] := value
		}
		for key, value in this.punctuationDict {
			this.dict[key] := value
		}
	}
	; --- Static Methods ---

	encode(param_value) {
		if (isObject(param_value)) {
			outputArr := []
			for _, value in param_value {
				outputArr.push(this.encode(value))
			}
			return outputArr
		}
		
		valueArray := strSplit(param_value)
		outputStr := ""
		for _, value in valueArray {
			index := this._indexOf(this.dict, value)
			if (index != -1) {
				outputStr .= index " "
			}
		}
		; trim last character as " " is always exists on end
		return subStr(outputStr, 1, strLen(outputStr) - 1)
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
			string .= this.dict[code]
		}
		return string
	}

	_indexOf(param_array, param_search) {
		param_search := format("{:U}", param_search)
		for key, value in param_array {
			if (value == param_search) {
				return key
			}
		}
		return -1
	}
}
