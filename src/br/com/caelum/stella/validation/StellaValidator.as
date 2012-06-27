package br.com.caelum.stella.validation
{
	import br.com.caelum.stella.ValidationMessage;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.IValidator;

	public interface StellaValidator {
		
		function assertValid(object:Object):void;
		
		function invalidMessagesFor(object:Object):Vector.<ValidationMessage>;
		
		function isEligible(value:Object):Boolean;
	}
}