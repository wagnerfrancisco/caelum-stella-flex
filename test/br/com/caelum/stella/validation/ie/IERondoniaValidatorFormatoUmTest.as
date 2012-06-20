package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	
	import org.flexunit.asserts.assertEquals;
	
	/*
	* Teste de valores do caso um contra IERondoniaValidator
	* Verificar IERondoniaValidatorFormatoDoisTest para valores do caso dois.
	*/
	public class IERondoniaValidatorFormatoUmTest extends IERondoniaValidatorCasoUmTest {
		
		public function IERondoniaValidatorFormatoUmTest() {
		}
		
		override public function shouldNotValidateIEWithLessDigitsThanAllowed():void {
		}
		
		override public function shouldNotValidateIEWithMoreDigitsThanAlowed():void {
		}
		
		override public function shouldNotValidateIEWithInvalidCharacter():void {
			var validator:StellaValidator = getValidator(false);
			var resultEvent:ValidationResultEvent = validator.validate(validUnformattedString.replace(/./, '&'));
			
			assertEquals(ValidationResultEvent.INVALID, resultEvent.type);
			var errors:Array = errorResults(resultEvent);
			assertEquals(1, errors.length);
			assertEquals(IEErrors.INVALID_FORMAT, ValidationResult(errors[0]).errorCode);
		}
		
		override protected function getValidator(isFormatted:Boolean):StellaValidator {
			return new IERondoniaValidator(isFormatted);
		}
	}
}