package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;

	public class IECearaValidatorTest extends IEValidatorTest {
		
		private static const wrongCheckDigitUnformattedString:String = '060000010';
		
		private static const validUnformattedString:String = '060000015';
		
		private static const validFormattedString:String = '06.000.001-5';
		private static const validValues:Array = ['06.998.161-2', '06.864.509-0', '06.031.909-7'];
		
		public function IECearaValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IECearaValidator(isFormatted);
		}
	}
}