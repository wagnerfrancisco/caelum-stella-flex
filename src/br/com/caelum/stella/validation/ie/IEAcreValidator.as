package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;
	
	public class IEAcreValidator extends IEAbstractValidator {
		
		public static const FORMATTED:RegExp = /^(01)[.](\d{3})[.](\d{3})[\/](\d{3})[-](\d{2})$/;
		public static const UNFORMATTED:RegExp = /^(01)(\d{3})(\d{3})(\d{3})(\d{2})$/;
		
		public function IEAcreValidator(isFormatted:Boolean = true) {
			super(isFormatted);
		}
		
		override protected function getFormattedPattern():RegExp {
			return FORMATTED;
		}
		
		override protected function getUnformattedPattern():RegExp {
			return UNFORMATTED;
		}
		
		override protected function hasValidCheckDigits(value:String):Boolean {
			return false;
		}
	}
}