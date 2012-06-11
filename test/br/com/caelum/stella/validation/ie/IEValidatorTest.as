package br.com.caelum.stella.validation.ie
{
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;

	public class IEValidatorTest {
		
		private var _wrongCheckDigitUnformattedIE:String;
		private var _validUnformattedIE:String;
		private var _validFormattedIE:String;
		private var _validFormattedValues:Array;
		
		public function IEValidatorTest(wrongCheckDigitUnformattedIE:String,
										validUnformattedIE:String,
										validFormattedIE:String,
										validFormattedValues:Array) {
			this._wrongCheckDigitUnformattedIE = wrongCheckDigitUnformattedIE;
			this._validUnformattedIE = validUnformattedIE;
			this._validFormattedIE = validFormattedIE;
			this._validFormattedValues = validFormattedValues;
		}
		
		[Test]
		public function shouldNotValidateIEWithInvalidCharacter():void {
			var validator:Validator = getValidator(false);
			
			var resultEvent:ValidationResultEvent = validator.validate(_validUnformattedIE.replace(/./, '&'));
			assertEquals(ValidationResultEvent.INVALID, resultEvent.type);
			
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);
		}
		
		[Test]
		public function shouldNotValidateIEWithLessDigitsThanAllowed():void {
			var validator:Validator = getValidator(false);
			
			var resultEvent:ValidationResultEvent = validator.validate(_validUnformattedIE.replace(/./, ''));
			assertEquals(ValidationResultEvent.INVALID, resultEvent.type);
			
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);
		}
		
		// IEMatoGrosso e IERioGrandeDoNorte sobreescrevem
		[Test]
		public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
			var validator:Validator = getValidator(false);
			
			var value:String = _validUnformattedIE + '5';
			var resultEvent:ValidationResultEvent = validator.validate(value);			
			assertEquals(ValidationResultEvent.INVALID, resultEvent.type);
			
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);
		}
		
		[Test]
		public function shouldNotValidateIEsWithWrongCheckDigit():void {
			var validator:Validator = getValidator(false);
			
			var resultEvent:ValidationResultEvent = validator.validate(_wrongCheckDigitUnformattedIE);
			assertEquals(ValidationResultEvent.INVALID, resultEvent.type);

			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_CHECK_DIGITS, ValidationResult(errors[0]).errorCode);
		}
		
		[Test]
		public function shouldValidateValidIE():void {
			var validator:Validator = getValidator(true);
			var resultEvent:ValidationResultEvent;
			
			for each (var validValue:String in _validFormattedValues) {
				resultEvent = validator.validate(validValue);
				assertEquals(ValidationResultEvent.VALID, resultEvent.type);
			}
		}
		
		[Test]
		public function shouldValidateNullIE():void {
			var validator:Validator = getValidator(false);
			validator.required = false;
			
			var resultEvent:ValidationResultEvent = validator.validate(null);
			assertEquals(ValidationResultEvent.VALID, resultEvent.type);
		}
		
		[Test]
		public function shouldNotValidateValidUnformattedIE():void {
			var validator:Validator = getValidator(true);
			
			var value:String = _validFormattedIE.replace('-', ':');
			if (value === _validFormattedIE) {
				value = value.replace('/', ':');
				if (value === _validFormattedIE) {
					value = value.replace('.', ':');
				}
			}
			
			var resultEvent:ValidationResultEvent = validator.validate(value);
			assertEquals(ValidationResultEvent.INVALID, resultEvent.type);
			
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_FORMAT, ValidationResult(errors[0]).errorCode);
		}
		
		protected function errorResults(event:ValidationResultEvent):Array {
			var errors:Array = [];
			for each (var validationResult:ValidationResult in event.results) {
				if (validationResult.isError) {
					errors.push(validationResult);
				}
			}
			return errors;
		}
		
		protected function getValidator(isFormatted:Boolean):Validator {
			throw new Error('override IEValidatorTest.getValidator');
		}
	}
}