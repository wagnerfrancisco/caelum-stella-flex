package br.com.caelum.stella.validation.ie
{
	import flash.events.Event;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class IEAbstractValidator extends Validator {
		
		private var _isFormatted:Boolean;
		
		private var _invalidCheckDigitsErrorMessage:String = 'Dígitos verificadores inválidos';
		private var _invalidDigitsErrorMessage:String = 'Dígitos inválidos';
		private var _invalidFormatErrorMessage:String = 'Formato inválido';
		private var _invalidMunicipalityErrorMessage:String = 'Municipalidade inválida';
		private var _undefinedStateErrorMessage:String = 'Estado indefinido';
		
		public function IEAbstractValidator(isFormatted:Boolean = true) {
			super();
			this._isFormatted = isFormatted;
			super.requiredFieldError
		}
		
		override protected function doValidation(value:Object):Array {
			var results:Array = super.doValidation(value);
			
			if (results.length > 0) {
				return results;
			}
			
			if (value != null) {
				results = getInvalidValues(value.toString());
			}
			
			return results;
		}
		
		private function getInvalidValues(ie:String):Array {
			var errors:Array = [];
			var unformattedIE:String = checkForCorrectFormat(ie, errors);
			if (errors.length === 0) {
				if (!hasValidCheckDigits(unformattedIE)) {
					errors.push(new ValidationResult(true, null, IEErrors.INVALID_CHECK_DIGITS, 'invalid_check_digits'));
				}
			}
			return errors;
		}
		
		protected function checkForCorrectFormat(ie:String, errors:Array):String {
			var unformattedIE:String;
			if (isFormatted) {
				if (!ie.match(getFormattedPattern())) {
					errors.push(new ValidationResult(true, null, IEErrors.INVALID_FORMAT, 'invalid_format'));
				}
				unformattedIE = ie.replace(/\D/g, '');
			} else {
				if (!ie.match(getUnformattedPattern())) {
					errors.push(new ValidationResult(true, null, IEErrors.INVALID_DIGITS, 'invalid_digits'));
				}
				unformattedIE = ie;
			}
			return unformattedIE;
		}
		
		protected function getFormattedPattern():RegExp {
			throw new Error('override IEAbstractValidator.getFormattedPattern');
		}
		
		protected function getUnformattedPattern():RegExp {
			throw new Error('override IEAbstractValidator.getUnformattedPattern');
		}
		
		protected function hasValidCheckDigits(value:String):Boolean {
			throw new Error('override IEAbstractValidator.hasValidCheckDigits');
		}

		[Bindable(event='isFormattedChange')]
		public function get isFormatted():Boolean { return _isFormatted; }

		public function set isFormatted(value:Boolean):void {
			if (_isFormatted !== value ) {
				_isFormatted = value;
				dispatchEvent(new Event('isFormattedChange'));
			}
		}

		public function get invalidCheckDigitsErrorMessage():String { return _invalidCheckDigitsErrorMessage; }

		public function set invalidCheckDigitsErrorMessage(value:String):void {
			_invalidCheckDigitsErrorMessage = value;
		}

		public function get invalidDigitsErrorMessage():String { return _invalidDigitsErrorMessage; }

		public function set invalidDigitsErrorMessage(value:String):void {
			_invalidDigitsErrorMessage = value;
		}

		public function get invalidFormatErrorMessage():String { return _invalidFormatErrorMessage; }

		public function set invalidFormatErrorMessage(value:String):void {
			_invalidFormatErrorMessage = value;
		}

		public function get invalidMunicipalityErrorMessage():String { return _invalidMunicipalityErrorMessage; }

		public function set invalidMunicipalityErrorMessage(value:String):void {
			_invalidMunicipalityErrorMessage = value;
		}

		public function get undefinedStateErrorMessage():String { return _undefinedStateErrorMessage; }

		public function set undefinedStateErrorMessage(value:String):void {
			_undefinedStateErrorMessage = value;
		}

		
	}
}