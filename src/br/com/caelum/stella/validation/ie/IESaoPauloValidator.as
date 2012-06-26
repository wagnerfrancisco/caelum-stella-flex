package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.LogicOrComposedValidator;
	
	import mx.events.ValidationResultEvent;

	public class IESaoPauloValidator extends AbstractIEValidator {
		
		private var logicOrComposedValidator:LogicOrComposedValidator;
		
		public function IESaoPauloValidator(isFormatted:Boolean = true) {
			super(isFormatted);
			
			var validatorClasses:Array = [IESaoPauloComercioIndustriaValidator, IESaoPauloProdutorRuralValidator];
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