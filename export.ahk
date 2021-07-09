class morse
{
	; --- Static Variables ---

	static dict := {".......": " ", "--..--": ",", "---...": ":", "--..--": ","
					, ".-": "A", "-...": "B", "-.-.": "C", "-..": "D", ".": "E"
					, "..-.": "F", "--.": "G", "....": "H", "..": "I", ".---": "J"
					, "-.-": "K", ".-..": "L", "--": "M", "-.": "N", "---": "O"
					, ".--.": "P", "--.-": "Q", ".-.": "R", "...": "S", "-": "T"
					, "..-": "U", "...-": "V", ".--": "W", "-..-": "X", "-.--": "Y"
					, "--..": "Z"
					,"-----": "0", ".----": "1", "..---": "2", "...--": "3"
					, "....-": "4", ".....": "5", "-....": "6", "--...": "7"
					, "---..": "8", "----.": "9"}
	
	; --- Static Methods ---

	encode(param_value, param_separator:=" ") {
		if (isObject(param_value)) {
			outputArr := []
			for _, value in param_value {
				outputArr.push(this.encode(value, param_separator))
			}
			return outputArr
		}
		; replace non-word characters such as ,!?<>{}[]
		; param_value := regexReplace(param_value, "i)(?![\w\s]).", "")
		for code, character in this.dict {
			param_value := regexReplace(param_value, "i)" character, "//" code "//")
		}
		param_value := strReplace(param_value, "//", param_separator)
		; replace multiple spaces witha single space
		param_value := regexReplace(param_value, "i)(\s+)", " ")
		return trim(param_value)
	}

	decode(param_value, param_separator:=" ") {
		if (isObject(param_value)) {
			outputArr := []
			for _, value in param_value {
				outputArr.push(this.decode(value, param_separator))
			}
			return outputArr
		}
		string := ""
		for _, code in strSplit(param_value, param_separator)
			string .= this.dict[code]
		return string
	}
}
