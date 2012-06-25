package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;

	public class IESaoPauloComercioIndustriaValidatorTest extends IEValidatorTest {
		
		private static const wrongCheckDigitString:String = '110042490104';
		private static const wrongSecondCheckDigitString:String = '110042490115';
		private static const validUnformattedString:String = '110042490114';
		private static const validString:String = '110.042.490.114';
		
		// TODO adicionar mais IE validos para São Paulo
		private static const validValues:Array = [validString];
		
		public function IESaoPauloComercioIndustriaValidatorTest() {
			super(wrongCheckDigitString, validUnformattedString, validString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):StellaValidator {
			return new IESaoPauloComercioIndustriaValidator(isFormatted);
		}
		
		[Test]
		public function shouldNotValidateIEsWithSecondCheckDigitWrong():void {
			var validator:StellaValidator = getValidator(false);
			
			var result:ValidationResultEvent = validator.validate(wrongSecondCheckDigitString);
			assertEquals(ValidationResultEvent.INVALID, result.type);
			
			var errors:Array = errorResults(result);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_CHECK_DIGITS, ValidationResult(errors[0]).errorCode);
		}
	}
}