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
	, "..--": "Ü"		; U with diaeresis
	, ".--.-": "á"
  	, "·−−·−": "à"		; shared by à, å
  	, "·−·−": "ä"		; shared by ä, æ, ą
  	, "·−−·−": "å"		; shared by à, å
  	, "·−·−": "ą"		; shared by ä, æ, ą
  	, "·−·−": "æ"		; shared by ä, æ, ą
  	, "−·−··": "ć"		; shared by ć, ĉ, ç
  	, "−·−··": "ĉ"		; shared by ć, ĉ, ç
  	, "−·−··": "ç"		; shared by ć, ĉ, ç
  	, "··−··": "đ"		; shared by đ, é, ę
  	, "··−−·": "ð"
  	, "··−··": "é"		; shared by đ, é, ę
  	, "·−··−": "è"		; shared by è, ł
  	, "··−··": "ę"		; shared by đ, é, ę
  	, "−−·−·": "ĝ"
  	, "−−−−" : "ĥ"		; shared by ĥ, š
  	, "·−−−·": "ĵ"
  	, "·−··−": "ł"		; shared by è, ł
  	, "−−·−−": "ń"		; shared by ń, ñ
  	, "−−·−−": "ñ"		; shared by ń, ñ
  	, "−−−·": "ó"		; shared by ó, ö, ø
  	, "−−−·": "ö"		; shared by ó, ö, ø
  	, "−−−·": "ø"		; shared by ó, ö, ø
  	, "···−···": "ś"
  	, "···−·": "ŝ"
  	, "−−−−" : "š"		; shared by ĥ, š
  	, "·−−··": "þ"
  	, "··−−": "ü"		; shared by ü, ŭ
  	, "··−−": "ŭ"		; shared by ü, ŭ
  	, "−−··−·": "ź"
  	, "−−··−": "ż"}

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
			; feed each array element into own method for encoding
			for _, value in param_value {
				outputArr.push(this.encode(value))
			}
			return outputArr
		}
		this._checkInstance()
		
		; convert string input into array
		valueArray := strSplit(param_value)
		outputStr := ""
		for _, character in valueArray {
			; find morse index/key of character pair
			index := this._indexOf(this.dict, character)
			if (index != -1) {
				outputStr .= index " "
			}
		}
		; trim last character as " " is always exists on end and return
		return subStr(outputStr, 1, strLen(outputStr) - 1)
	}

	decode(param_value) {
		if (isObject(param_value)) {
			outputArr := []
			; feed each array element into own method for decoding
			for _, value in param_value {
				outputArr.push(this.decode(value))
			}
			return outputArr
		}
		this._checkInstance()

		outputStr := ""
		example := strSplit(param_value, " ")
		for _, code in strSplit(param_value, " ") {
			outputStr .= this.dict[code]
		}
		return outputStr
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

	_checkInstance() {
		; initialize instance if not already done
		if (this.dict.count() == 0) {
			this.__New()
		}
	}
}
