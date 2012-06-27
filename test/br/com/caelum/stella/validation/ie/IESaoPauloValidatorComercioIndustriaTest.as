package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.MessageProducer;
	import br.com.caelum.stella.exceptions.InvalidStateException;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;

	public class IESaoPauloValidatorComercioIndustriaTest extends IEValidatorTest {
		
		private static const wrongCheckDigitString:String = '110042490104';
		private static const validUnformattedString:String = '110042490114';
		private static const validString:String = '110.042.490.114';
		// TODO adicionar mais IE validos para São Paulo
		private static const validValues:Array = [validString];
				
		public function IESaoPauloValidatorComercioIndustriaTest() {
			super(wrongCheckDigitString, validUnformattedString, validString, validValues);
		}
		
		override protected function getValidator(messageProducer:MessageProducer, isFormatted:Boolean):StellaValidator {
			return new IESaoPauloValidator(isFormatted, messageProducer);
		}
		
		override public function shouldNotValidateIEWithLessDigitsThanAllowed():void {
		}
		
		override public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
		}
		
		override public function shouldNotValidateIEWithInvalidCharacter():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			
			try {
				validator.assertValid(validUnformattedString.replace(/./, '&'));
				fail();
			} catch (e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}
			
			/*assertEquals(IEErrors.INVALID_FORMAT, ValidationResult(errors[0]).errorCode);*/
		}
	}
}