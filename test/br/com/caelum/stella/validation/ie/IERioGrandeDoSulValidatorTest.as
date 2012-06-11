package br.com.caelum.stella.validation.ie
{
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;

	public class IERioGrandeDoSulValidatorTest extends IEValidatorTest {
		
		private static const validFormattedString:String = '224/3658792';
		private static const validUnformattedString:String = '2243658792';
		private static const wrongCheckDigitUnformattedString:String = '2243658791';
		private static const validValues:Array = [validFormattedString];
		
		public function IERioGrandeDoSulValidatorTest() {
			super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
		}
		
		[Test]
		public function shouldNotValidateIEWithInvalidMunicipalityWithZeros():void {
			var validator:Validator = getValidator(false);
			
			// VALID IE = 224/3658792
			var value1:String = '0003658791';			
			var resultEvent:ValidationResultEvent = validator.validate(value1);
			var errors:Array = errorResults(resultEvent);
			
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_MUNICIPALITY, ValidationResult(errors[0]).errorCode);
						
			var value2:String = '0003658792';
			resultEvent = validator.validate(value2);
			errors = errorResults(resultEvent);
			
			assertEquals(2, errors.length);
			
			var errorCodes:Array = [];
			for each (var e:ValidationResult in errors) {
				errorCodes.push(e.errorCode);
			}
			
			assertTrue(errorCodes.indexOf(IEErrors.INVALID_MUNICIPALITY) != -1);
		}
		
		override protected function getValidator(isFormatted:Boolean):Validator {
			return new IERioGrandeDoSulValidator(isFormatted);
		}

	}
}