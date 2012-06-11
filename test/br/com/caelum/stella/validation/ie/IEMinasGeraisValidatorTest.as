package br.com.caelum.stella.validation.ie
{
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;

	public class IEMinasGeraisValidatorTest extends IEValidatorTest {
		
		private static const wrongFirstCheckDigitUnformattedString:String = '0623079040045';
		private static const wrongSecondCheckDigitUnformattedString:String = '0623079040085';
		private static const validUnformattedString:String = '0623079040081';
		private static const validFormattedString:String = '062.307.904/0081';
		//TODO adicionar mais exemplo de IE validos
		private static const validValues:Array = ['062.307.904/0081'];
		
		public function IEMinasGeraisValidatorTest() {
			super(wrongFirstCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEMinasGeraisValidator(isFormatted);
		}
		
		[Test]
		public function shouldNotValidateIEWithSecondCheckDigitWrong():void {
			var validator:Validator = getValidator(false);
			var resultEvent:ValidationResultEvent = validator.validate(wrongFirstCheckDigitUnformattedString);
			
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_CHECK_DIGITS, ValidationResult(errors[0]).errorCode);
		}
	}
}