package br.com.caelum.stella.validation.ie
{
	import mx.events.ValidationResultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;

	public class IEDistritoFederalValidatorTest extends IEValidatorTest {
		
		private static const wrongFirstCheckDigitUnformattedString:String = '0740873800240';		
		private static const wrongSecondCheckDigitUnformattedString:String = '0740873800240';		
		private static const validUnformattedString:String = '0740873800250';		
		private static const validFormattedString:String = '07.408.738/002-50';		
		private static const validValues:Array = [validFormattedString, '07.343.623/001-77', '07.451.530/001-68',
			'07.389.634/001-01', '07.336.802/001-60', '07.346.779/001-46', '07.548.137/001-52'];
		
		public function IEDistritoFederalValidatorTest() {
			super(wrongFirstCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEDistritoFederalValidador(isFormatted);
		}
		
		[Test]
		public function shouldNotValidateIEWithSecondCheckDigitWrong():void {
			var validator:Validator = getValidator(false);
			var resultEvent:ValidationResultEvent = validator.validate(wrongSecondCheckDigitUnformattedString);
			
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_CHECK_DIGITS, ValidationResult(errors[0]).errorCode);
		}
	}
}