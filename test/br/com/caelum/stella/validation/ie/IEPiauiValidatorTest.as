package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;

	public class IEPiauiValidatorTest extends IEValidatorTest {
		
		/*
		* Formato: 8 dígitos (empresa)+1 dígito verificador Exemplo: 19.301.656-7
		*/
		private static const wrongCheckDigitUnformattedString:String = '193016560';		
		private static const validUnformattedString:String = '193016567';		
		private static const validFormattedString:String = '19.301.656-7';		
		private static const validValues:Array = [validFormattedString];
		
		public function IEPiauiValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEPiauiValidator(isFormatted);
		}
	}
}