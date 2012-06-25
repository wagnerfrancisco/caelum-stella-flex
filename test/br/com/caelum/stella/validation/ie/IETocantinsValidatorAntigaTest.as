package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	
	import org.flexunit.asserts.assertEquals;

	public class IETocantinsValidatorAntigaTest extends IEValidatorTest {
		
		private static const wrongCheckDigitUnformattedString:String = '29010227830';		
		private static const validUnformattedString:String = '29010227836';		
		private static const validFormattedString:String = '29.01.022.783-6';		
		private static const validValues:Array = [validFormattedString];
		
		public function IETocantinsValidatorAntigaTest() {
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