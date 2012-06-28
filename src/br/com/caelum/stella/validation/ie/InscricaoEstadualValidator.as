package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.ValidationMessage;
	import br.com.caelum.stella.exceptions.InvalidStateException;
	import br.com.caelum.stella.validation.StellaValidator;
	
	import flash.events.Event;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class InscricaoEstadualValidator extends Validator {		
		
		private var _formatted:Boolean = true;
		private var _uf:String;
		private var _currentValidator:StellaValidator;
		
		private static const validators:Object = {
			'AC': IEAcreValidator,
			'AL': IEAlagoasValidator,
			'AM': IEAmazonasValidator,
			'AP': IEAmapaValidator,
			'BA': IEBahiaValidator,
			'CE': IECearaValidator,
			'DF': IEDistritoFederalValidator,
			'ES': IEEspiritoSantoValidator,
			'GO': IEGoiasValidator,
			'MA': IEMaranhaoValidator,
			'MS': IEMatoGrossoDoSulValidator,
			'MT': IEMatoGrossoValidator,
			'MG': IEMinasGeraisValidator,
			'PA': IEParaValidator,
			'PB': IEParaibaValidator,
			'PR': IEParanaValidator,
			'PE': IEPernambucoValidator,
			'PI': IEPiauiValidator,
			'RJ': IERioDeJaneiroValidator,
			'RN': IERioGrandeDoNorteValidator,
			'RO': IERondoniaValidator,
			'RR': IERondoniaValidator,
			'RS': IERioGrandeDoSulValidator,
			'SC': IESantaCatarinaValidator,
			'SP': IESaoPauloValidator,
			'SE': IESergipeValidator,
			'TO': IETocantinsValidator
		}
		
		public function InscricaoEstadualValidator() {
			super();
		}
		
		override protected function doValidation(value:Object):Array {
			var result:Array = super.doValidation(value);
			
			if (result.length > 0) {
				return result;
			}
			
			if (_currentValidator == null) {	
				return result;
			}
			
			try {
				_currentValidator.assertValid(value);
			} catch(e:InvalidStateException) {
				var invalidMessages:Vector.<ValidationMessage> = e.invalidMessages;
				
				for each (var m:ValidationMessage in invalidMessages) {
					result.push(new ValidationResult(true, '', m.getMessage(), m.getMessage())); 
				}
			}
			
			return result;
		}

		[Bindable(event='ufChange')]
		public function get uf():String { return _uf; }

		public function set uf(value:String):void {
			value = value.toUpperCase();
			
			if (value !== _uf) {
				if (validators[value] == null) {
					throw new Error('Nao ha validador para a UF informada');
				}
				
				var validator:StellaValidator = new validators[value](_formatted);
				
				_uf = value;
				_currentValidator = validator;
				
				dispatchEvent(new Event('ufChange'));
			}
		}

		[Bindable(event='formattedChange')]
		public function get formatted():Boolean { return _formatted; }

		public function set formatted(value:Boolean):void {
			if (value !== _formatted) {
				_formatted = value;
				
				dispatchEvent(new Event('formattedChange'));
			}
		}
	}
}