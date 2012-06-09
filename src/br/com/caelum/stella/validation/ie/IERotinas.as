package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.DigitoVerificadorInfo;
	import br.com.caelum.stella.validation.RotinaParameters;

	public class IERotinas {
		
		public static function E(parameter:RotinaParameters):int {
			var info:DigitoVerificadorInfo = parameter.digitoVerificadorInfo;
			var x:int = parameter.result;
			var result:int = info.mod - (x % info.mod);
			return result;
		}
		
		public static function POS_IE(parameter:RotinaParameters):int {
			var info:DigitoVerificadorInfo = parameter.digitoVerificadorInfo;
			var x:int = parameter.result;
			
			if (x === 10) {
				x = 0;
			} else if (x === 11) {
				x = info.fator;
			}
			return x;
		}
	}
}