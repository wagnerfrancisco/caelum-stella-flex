package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.MessageProducer;
	import br.com.caelum.stella.exceptions.InvalidStateException;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	
	import org.flexunit.asserts.assertEquals;

	public class IERioGrandeDoNorteValidatorTest extends IEValidatorTest {
		
		
		/*
		* IE validas 20.040.040-1(9 dígitos) ou 20.0.040.040-0(10 dígitos)
		*/
		private static const wrongCheckDigitUnformattedStringWithTenDigits:String = '2000400403';		
		private static const validUnformattedStringWithNineDigits:String = '200400401';		
		private static const validUnformattedStringWithTenDigits:String = '2000400400';		
		private static const validFormattedStringWithNineDigits:String = '20.040.040-1';		
		private static const validFormattedStringWithTenDigits:String = '20.0.040.040-0';
		
		private static const validValues:Array = [validFormattedStringWithTenDigits, validFormattedStringWithNineDigits];
		
		public function IERioGrandeDoNorteValidatorTest() {
			super(wrongCheckDigitUnformattedStringWithTenDigits, validUnformattedStringWithNineDigits,
				validFormattedStringWithTenDigits, validValues);
		}
		
		override protected function getValidator(messageProducer:MessageProducer, isFormatted:Boolean):StellaValidator {
			return new IERioGrandeDoNorteValidator(isFormatted, messageProducer);
		}
		
		[Test]
		override public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			var value:String = validUnformattedStringWithTenDigits + "5";
			
			try {
				validator.assertValid(value);
			} catch (e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);*/
		}
	}
}