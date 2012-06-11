package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;

	public class IERoraimaValidatorTest extends IEValidatorTest {
		
		private static const validString:String = '24004145-5';
		private static const wrongCheckDigitString:String = '240041458';
		private static const validUnformattedString:String = '240017556';
		private static const validValues:Array = ['24006628-1', '24001755-6', '24003429-0', '24001360-3', '24008266-8',
			'24006153-6', '24007356-2', '24005467-4', '24004145-5', '24001340-7'];
		
		public function IERoraimaValidatorTest() {
			super(wrongCheckDigitString, validUnformattedString, validString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IERoraimaValidator(isFormatted);
		}
	}
}