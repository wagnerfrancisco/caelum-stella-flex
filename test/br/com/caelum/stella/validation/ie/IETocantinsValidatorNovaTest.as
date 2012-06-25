package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	
	import org.flexunit.asserts.assertEquals;

	public class IETocantinsValidatorNovaTest extends IEValidatorTest {
		
		private static const wrongCheckDigitUnformattedString:String = '290406360';		
		private static const validUnformattedString:String = '290406360';		
		private static const validFormattedString:String = '29.040.636-6';		
		private static const validValues:Array = [validFormattedString, '29.040.634-0', '29.385.524-2', '29.032.038-0'];
		
		public function IETocantinsValidatorNovaTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):StellaValidator {
			return new IETocantinsValidator(isFormatted);
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