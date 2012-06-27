package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.MessageProducer;
	import br.com.caelum.stella.exceptions.InvalidStateException;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import org.flexunit.asserts.assertEquals;

	/*
	 * Teste de valores de IE antigos contra IEPernambucoValidator
	 * Verificar IEPernambucoValidatorNovoFormatoTest para valores novos.
	 */
	public class IEPernambucoValidatorAntigoFormatoTest extends IEPernambucoAntigaValidatorTest {
		
		public function IEPernambucoValidatorAntigoFormatoTest() {
		}
		
		override public function shouldNotValidateIEWithLessDigitsThanAllowed():void {
		}
		
		override public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
		}
		
		override public function shouldNotValidateIEWithInvalidCharacter():void {
			var validator:StellaValidator = getValidator(_messageProducer, false);
			
			try {
				validator.assertValid(validUnformattedString.replace(/./, '&'));
			} catch (e:InvalidStateException) {
				assertEquals(1, e.invalidMessages.length);
			}

			/*assertEquals(IEErrors.INVALID_FORMAT, ValidationResult(errors[0]).errorCode);*/
		}
		
		override protected function getValidator(messageProducer:MessageProducer, isFormatted:Boolean):StellaValidator {
			return new IEPernambucoValidator(isFormatted, messageProducer);
		}
	}
}