package br.com.caelum.stella.validation
{
	import br.com.caelum.stella.validation.ie.IEErrors;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class LogicOrComposedValidator extends Validator implements StellaValidator {
		
		public var validators:Array;
		
		public function LogicOrComposedValidator(isFormatted:Boolean,
			validatorClasses:Array) {
			this.validators = [];
			for each (var clazz:Class in validatorClasses) {
				this.validators.push(new clazz(isFormatted));
			}
		}
		
		override protected function doValidation(value:Object):Array {
			var results:Array = super.doValidation(value);
			
			if (results.length > 0) {
				return results;
			}
			
			if (value != null) {
				
				var isValid:Boolean = false;
				var lastErrorResultEvent:ValidationResultEvent;
				
				for each (var validator:StellaValidator in validators) {
					if (validator.isEligible(value)) {
						var resultEvent:ValidationResultEvent = validator.validate(value);
						if (ValidationResultEvent.VALID === resultEvent.type) {
							isValid = true;
							break;
						}
						lastErrorResultEvent = resultEvent;	
					}					
				}
			}
			
			if (!isValid) {
				if (lastErrorResultEvent) {
					results = lastErrorResultEvent.results;
				} else {
					results.push(new ValidationResult(true, null, IEErrors.INVALID_FORMAT, 'invalid_format'));  
				}
			}
			
			return results;
		}
		
		public function isEligible(value:Object):Boolean {
			var result:Boolean = false;
			
			for each (var v:StellaValidator in validators) {
				if (v.isEligible(value)) {
					result = true;
					break;
				}
			}
			
			return result;
		}
	}
}