package br.com.caelum.stella.validation.ie
{
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;

	public class IEParanaValidatorTest extends IEValidatorTest {		
		
		private static const wrongFirstCheckDigitUnformattedString:String = '1234567860';
		private static const wrongSecondCheckDigitUnformattedString:String = '1234567859';
		private static const validUnformattedString:String = '1234567850';
		private static const validFormattedString:String = '099.00004-09';
		private static const validValues:Array = ['099.00004-09', '123.45678-50', '826.01749-09', '902.33203-01',
			'738.00291-16', '738.00294-69', '738.00302-03', '738.00313-66', '738.00338-14', '738.00348-96'];
		
		public function IEParanaValidatorTest() {
			super(wrongFirstCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IEParanaValidator(isFormatted);
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