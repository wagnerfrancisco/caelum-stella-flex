package br.com.caelum.stella.validation
{
	import mx.events.ValidationResultEvent;
	import mx.validators.IValidator;

	public interface StellaValidator extends IValidator {
		
		function isEligible(value:Object):Boolean;
	}
}