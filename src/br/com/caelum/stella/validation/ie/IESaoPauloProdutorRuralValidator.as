package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.validation.DigitoVerificadorInfo;
	import br.com.caelum.stella.validation.StellaValidator;
	import br.com.caelum.stella.validation.ValidadorDeDV;
	
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class IESaoPauloProdutorRuralValidator extends Validator implements StellaValidator {
		
		private static const MOD:int = 11;
		
		// TAMANHO = 13;
		private static const MISSING_LEFT_SIDE_ZEROS:String = "00";
		
		private static const DVX_POSITION:int = MISSING_LEFT_SIDE_ZEROS.length + 9;		
		private static const DVX_MULTIPLIERS:Array = IEConstraints.P12;
		
		private static const rotinas:Array = [IERotinas.D, IERotinas.POS_IE];
		
		private static const DVX_INFO:DigitoVerificadorInfo = new DigitoVerificadorInfo(0, rotinas, MOD, DVX_MULTIPLIERS,
			DVX_POSITION);
		
		private static const DVX_CHECKER:ValidadorDeDV = new ValidadorDeDV(DVX_INFO);
		
		private var isFormatted:Boolean;
		
		public static const FORMATTED:RegExp = /^P-(\d{8})[.](\d{1})[\/](\d{3})$/;		
		public static const UNFORMATTED:RegExp = /^P(\d{8})(\d{1})(\d{3})$/;
		
		public function IESaoPauloProdutorRuralValidator(isFormatted:Boolean) {
			super();
			this.isFormatted = isFormatted;
			this.required = false;
		}
		
		private function getInvalidValues(ie:String):Array {
			var errors:Array = [];
			if (ie != null) {
				var unformattedIE:String = checkForCorrectFormat(ie, errors);
				if (errors.length === 0) {
					if (!hasValidCheckDigits(unformattedIE)) {
						errors.push(new ValidationResult(true, null, IEErrors.INVALID_CHECK_DIGITS, 'invalid_check_digits'));
					}
				}
			}
			return errors;
		}
		
		private function checkForCorrectFormat(ie:String, errors:Array):String {
			var unformattedIE:String;
			
			if (isFormatted) {
				if (!FORMATTED.test(ie)) {
					errors.push(new ValidationResult(true, null, IEErrors.INVALID_FORMAT, 'invalid_format'));
				}
				unformattedIE = ie.replace(/\D/g, '');
			} else {
				if (!UNFORMATTED.test(ie)) {
					errors.push(new ValidationResult(true, null, IEErrors.INVALID_DIGITS, 'invalid_digits'));
				}
				unformattedIE = ie.replace(/\D/g, '');
			}
			return unformattedIE;
		}
		
		private function hasValidCheckDigits(value:String):Boolean {
			var testedValue:String = MISSING_LEFT_SIDE_ZEROS + value;
			return (DVX_CHECKER.isDVValid(testedValue));
		}
		
		public function isEligible(value:Object):Boolean {
			var result:Boolean;
			if (isFormatted) {
				result = FORMATTED.test(String(value));
			} else {
				result = UNFORMATTED.test(String(value));
			}
			return result;
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
	}
}