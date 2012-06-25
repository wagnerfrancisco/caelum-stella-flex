package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;

	public class IESaoPauloValidatorProdutorRuralTest extends IEValidatorTest {
		
		private static const wrongCheckDigitString:String = 'P011004245002';
		private static const validUnformattedString:String = 'P011004243002';
		private static const validString:String = 'P-01100424.3/002';
		// TODO adicionar mais IE validos para São Paulo
		private static const validValues:Array = [validString];
		
		public function IESaoPauloValidatorProdutorRuralTest() {
			super(wrongCheckDigitString, validUnformattedString, validString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):StellaValidator {
			return new IESaoPauloValidator(isFormatted);
		}
		
		override public function shouldNotValidateIEWithLessDigitsThanAllowed():void {
		}
		
		override public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
		}
		
		override public function shouldNotValidateIEWithInvalidCharacter():void {
			var validator:StellaValidator = getValidator(false);
			var result:ValidationResultEvent = validator.validate(validUnformattedString.replace(/./, '&'));
			assertEquals(ValidationResultEvent.INVALID, result.type);
			
			var errors:Array = errorResults(result);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_FORMAT, ValidationResult(errors[0]).errorCode);
		}
	}
}