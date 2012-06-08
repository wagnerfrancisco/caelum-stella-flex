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
		
		
		/*@Test
		public void shouldNotValidateIEsWithCheckDigitWrong() {
			Validator<String> validator = getValidator(messageProducer, false);
			
			String value = wrongCheckDigitUnformattedIE;
			try {
				validator.assertValid(value);
				fail();
			} catch (InvalidStateException e) {
				assertEquals(1, e.getInvalidMessages().size());
			}
			
			verify(messageProducer, times(1)).getMessage(IEError.INVALID_CHECK_DIGITS);
		} */
		
		[Test]
		public function shouldValidateValidIE():void {
			var validator:Validator = getValidator(false);
			var resultEvent:ValidationResultEvent;
			
			for each (var validValue:String in _validFormattedValues) {
				resultEvent = validator.validate(validValue);
				trace(validValue);
				
				
				var errors:Array = errorResults(resultEvent);
				trace(errors);
				assertEquals(ValidationResultEvent.VALID, resultEvent.type);
				
			}
		}
		
		/*
		@Test
		public void shouldValidateValidIE() {
			Validator<String> validator = getValidator(messageProducer, true);
			
			for (String validValue : validFormattedValues) {
				try {
					validator.assertValid(validValue);
				} catch (InvalidStateException e) {
					fail("IE inválida: " + validValue);
				}
				List<ValidationMessage> errors = validator.invalidMessagesFor(validValue);
				assertTrue(errors.isEmpty());
			}
			
			verify(messageProducer, never()).getMessage(any(IEError.class));
				
			}
				
				@Test
				public void shouldValidateValidFormattedNovaIE() {
					Validator<String> validator = getValidator(messageProducer, true);
					
					String[] validValues = { validFormattedIE };
					for (String validValue : validValues) {
						try {
							validator.assertValid(validValue);
						} catch (InvalidStateException e) {
							fail("IE inválida: " + validValue);
						}
						List<ValidationMessage> errors = validator.invalidMessagesFor(validValue);
						assertTrue(errors.isEmpty());
					}
					
					verify(messageProducer, never()).getMessage(any(IEError.class));
					}
						
						@Test
						public void shouldValidateNullIE() {
							Validator<String> validator = getValidator(messageProducer, false);
							List<ValidationMessage> errors;
							String value = null;
							try {
								validator.assertValid(value);
							} catch (InvalidStateException e) {
								fail();
							}
							errors = validator.invalidMessagesFor(value);
							assertTrue(errors.isEmpty());
							
							verify(messageProducer, never()).getMessage(any(IEError.class));
							}
								
								@Test
								public void shouldNotValidateValidUnformattedIE() {
									Validator<String> validator = getValidator(messageProducer, true);
									
									String value = validFormattedIE.replace('-', ':');
									if(value.equals(validFormattedIE)) {
										value = value.replace('/', ':');
										if(value.equals(validFormattedIE)) {
											value = value.replace('.', ':');
										}
									}
									try {
										validator.assertValid(value);
										fail();
									} catch (InvalidStateException e) {
										assertEquals(1, e.getInvalidMessages().size());
									}
									
									verify(messageProducer, times(1)).getMessage(IEError.INVALID_FORMAT);
								}
		
		
		*/
		
		private function errorResults(event:ValidationResultEvent):Array {
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