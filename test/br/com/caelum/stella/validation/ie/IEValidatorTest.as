package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.MessageProducer;
	import br.com.caelum.stella.MessageProducerMock;
	import br.com.caelum.stella.ValidationMessage;
	import br.com.caelum.stella.exceptions.InvalidStateException;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.fail;

	public class IEValidatorTest {
		
		protected const _messageProducer:MessageProducer = new MessageProducerMock();
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
			var validator:StellaValidator = getValidator(_messageProducer, false);
			
			try {
				validator.assertValid(_validUnformattedIE.replace(/./, '&'));
				fail();
			} catch (e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);*/
		}
		
		[Test]
		public function shouldNotValidateIEWithLessDigitsThanAllowed():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			
			try {
				validator.assertValid(_validUnformattedIE.replace(/./, ''));
				fail();
			} catch(e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);*/
		}
		
		// IEMatoGrosso e IERioGrandeDoNorte sobreescrevem
		[Test]
		public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			
			try {
				var value:String = _validUnformattedIE + '5';
				validator.assertValid(value);
				fail();
			} catch(e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_DIGITS, ValidationResult(errors[0]).errorCode);*/
		}
		
		[Test]
		public function shouldNotValidateIEsWithWrongCheckDigit():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			
			try {
				validator.assertValid(_wrongCheckDigitUnformattedIE);
				fail();
			} catch(e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_CHECK_DIGITS, ValidationResult(errors[0]).errorCode);*/
		}
		
		[Test]
		public function shouldValidateValidIE():void {
			var validator:StellaValidator = getValidator(_messageProducer, true);
			
			for each (var validValue:String in _validFormattedValues) {
				try {
					validator.assertValid(validValue);
				} catch(e:InvalidStateException) {
					fail("IE Invalida: " + validValue);
				}

				var errors:Vector.<ValidationMessage> = validator.invalidMessagesFor(validValue);
				assertStrictlyEquals(0, errors.length);
			}
		}
		
		[Test]
		public function shouldValidateNullIE():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			var errors:Vector.<ValidationMessage>;
			
			try {
				validator.assertValid(null);
			} catch(e:InvalidStateException) {
				fail();
			}
			/*errors = validator.invalidMessagesFor(value);
			assertTrue(errors.isEmpty());
			
			verify(messageProducer, never()).getMessage(any(IEError.class));*/
		}
		
		[Test]
		public function shouldNotValidateValidUnformattedIE():void {
			var validator:StellaValidator = getValidator(_messageProducer, true);
			
			var value:String = _validFormattedIE.replace('-', ':');
			if (value === _validFormattedIE) {
				value = value.replace('/', ':');
				if (value === _validFormattedIE) {
					value = value.replace('.', ':');
				}
			}
			
			try {
				validator.assertValid(value);
				fail();
			} catch(e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_FORMAT, ValidationResult(errors[0]).errorCode);*/
		}
		
		protected function getValidator(messageProducer:MessageProducer, isFormatted:Boolean):StellaValidator {
			throw new Error('override IEValidatorTest.getValidator');
		}
	}
}