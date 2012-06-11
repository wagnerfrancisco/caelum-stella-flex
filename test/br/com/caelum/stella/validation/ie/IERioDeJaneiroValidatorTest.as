package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;

	public class IERioDeJaneiroValidatorTest extends IEValidatorTest {
		
		private static const validFormattedString:String = '78.045.302';
		private static const validUnformattedString:String = '78045302';
		private static const wrongCheckDigitUnformattedString:String = '78045304';
		private static const validValues:Array = [validFormattedString];
		
		public function IERioDeJaneiroValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}		
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IERioDeJaneiroValidator(isFormatted);
		}
	}
}