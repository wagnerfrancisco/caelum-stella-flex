package br.com.caelum.stella.validation.ie
{
	import mx.validators.Validator;

	public class IEEspiritoSantoValidatorTest extends IEValidatorTest {
		
		/*
		* Formato: 8 dígitos (empresa)+1 dígito verificador
		* 
		* Exemplo: 082.223.54-8
		*/
		
		private static const wrongCheckDigitUnformattedString:String = '082223540';		
		private static const validUnformattedString:String = '082223548';		
		private static const validFormattedString:String = '082.223.54-8';		
		private static const validUnformattedValues:Array = [validFormattedString, '082.260.66-4', '081.877.45-5'];
		
		public function IEEspiritoSantoValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validUnformattedValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEEspiritoSantoValidator(isFormatted);
		}
	}
}