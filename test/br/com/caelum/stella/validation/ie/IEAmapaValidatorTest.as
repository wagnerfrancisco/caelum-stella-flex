package br.com.caelum.stella.validation.ie {
	import mx.validators.Validator;
	
	public class IEAmapaValidatorTest extends IEValidatorTest {
		
		private static const wrongCheckDigitUnformattedString:String = '030123450';		
		private static const validUnformattedString:String = '030123459';		
		private static const validFormattedString:String = '03.012.345-9';		
		private static const validValues:Array = [validFormattedString];
		
		public function IEAmapaValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}		
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEAmapaValidator(isFormatted);
		}
	}
}