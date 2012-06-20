package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.LogicOrComposedValidator;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;

	public class IERondoniaValidator extends Validator implements StellaValidator {
		
		private var logicOrComposedValidator:LogicOrComposedValidator;
		
		public function IERondoniaValidator(isFormatted:Boolean = true) {
			var validatorClasses:Array = [IERondoniaCasoUmValidator, IERondoniaCasoDoisValidator];
			logicOrComposedValidator = new LogicOrComposedValidator(isFormatted, validatorClasses);
			this.required = false;
		}
		
		override public function validate(value:Object=null, suppressEvents:Boolean=false):ValidationResultEvent {
			return logicOrComposedValidator.validate(value, suppressEvents);
		}
		
		public function isEligible(value:Object):Boolean {
			return logicOrComposedValidator.isEligible(value);
		}
	}
}