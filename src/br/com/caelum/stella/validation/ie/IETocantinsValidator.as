package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.LogicOrComposedValidator;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import mx.events.ValidationResultEvent;

	public class IETocantinsValidator extends IEAbstractValidator {
		
		private var  logicOrComposedValidator:LogicOrComposedValidator;
		
		public function IETocantinsValidator(isFormatted:Boolean = true) {
			super(isFormatted);
			
			var validatorClasses:Array = [IETocantinsNovaValidator, IETocantinsAntigaValidator];
			this.logicOrComposedValidator = new LogicOrComposedValidator(isFormatted, validatorClasses);
		}
		
		override public function validate(value:Object=null, suppressEvents:Boolean=false):ValidationResultEvent {
			return logicOrComposedValidator.validate(value, suppressEvents);
		}
		
		override public function isEligible(value:Object):Boolean {
			return logicOrComposedValidator.isEligible(value);
		}
	}
}