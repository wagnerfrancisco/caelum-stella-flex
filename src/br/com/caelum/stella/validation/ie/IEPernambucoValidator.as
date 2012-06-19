package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.LogicOrComposedValidator;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;

	public class IEPernambucoValidator extends Validator implements StellaValidator {
		
		private var logicOrComposedValidator:LogicOrComposedValidator;
		
		public function IEPernambucoValidator(isFormatted:Boolean = true) {
			var validatorClasses:Array = [IEPernambucoNovaValidator, IEPernambucoAntigaValidator];
			logicOrComposedValidator = new LogicOrComposedValidator(isFormatted, validatorClasses);
		}
		
		override public function validate(value:Object=null, suppressEvents:Boolean=false):ValidationResultEvent {
			return logicOrComposedValidator.validate(value, suppressEvents);
		}
				
		public function isEligible(value:Object):Boolean {
			return logicOrComposedValidator.isEligible(value);
		}
	}
}