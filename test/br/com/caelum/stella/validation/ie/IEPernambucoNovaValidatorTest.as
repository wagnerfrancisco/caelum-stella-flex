package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;

	public class IEPernambucoNovaValidatorTest extends IEValidatorTest {
		
		/*
		* IE validas
		* 
		* 0321418-40 032141840
		*/		
		
		private static const wrongCheckDigitUnformattedString:String = '032141849';		
		private static const validUnformattedString:String = '032141840';		
		private static const validFormattedString:String = '0321418-40';		
		// TODO Adicionar mais IE validas
		private static const validValues:Array = [validFormattedString];
		
		public function IEPernambucoNovaValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEPernambucoNovaValidator(isFormatted);
		}
	}
}