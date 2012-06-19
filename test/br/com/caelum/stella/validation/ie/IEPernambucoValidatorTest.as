package br.com.caelum.stella.validation.ie
{
	
	/*
	* Em ActionScript nao ha como escrever inner classes.
	* As classes Helper nao funcionam como classes de testes, ja
	* que sua visibilidade é somente dentro da classe declarada.
	
	* Por isso estou efetuando testes usando dados da IE antiga e da IE
	* nova neste mesmo TestCase */
	public class IEPernambucoValidatorTest {
		
		public var iePernambucoValidatorAntigoFormato:IEPernambucoValidatorAntigoFormato;
		
		public static function newValidator(isFormatted:Boolean):IEPernambucoValidator {
			return new IEPernambucoValidator(isFormatted);
		}
	}

}

import br.com.caelum.stella.validation.StellaValidator;
import br.com.caelum.stella.validation.ie.IEErrors;
import br.com.caelum.stella.validation.ie.IEPernambucoValidatorTest;
import br.com.caelum.stella.validation.ie.IEValidatorTest;

import mx.events.ValidationResultEvent;
import mx.validators.ValidationResult;

import org.flexunit.asserts.assertEquals;



class IEPernambucoValidatorAntigoFormato extends IEValidatorTest {
	
	/*
	* IE validas
	* 
	* 18.1.001.0000004-9 18100100000049
	*/
	private static const wrongCheckDigitUnformattedString:String = '18100100000048';	
	private static const validUnformattedString:String = '18100100000049';	
	private static const validFormattedString:String = '18.1.001.0000004-9';	
	// TODO Adicionar mais IE validas
	private static const validValues:Array = [validFormattedString];
	
	public function IEPernambucoValidatorAntigoFormato() {
		super(wrongCheckDigitUnformattedString, validUnformattedString, validFormattedString, validValues);
	}
	
	override protected function getValidator(isFormatted:Boolean):StellaValidator {
		return IEPernambucoValidatorTest.newValidator(isFormatted);
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
}