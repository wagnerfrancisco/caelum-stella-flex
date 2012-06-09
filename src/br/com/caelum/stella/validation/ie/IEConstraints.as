package br.com.caelum.stella.validation.ie
{
	import br.com.caelum.stella.format.LeftSideZerosFormatter;
	import br.com.caelum.stella.validation.DigitoVerificadorInfo;
	import br.com.caelum.stella.validation.RotinaParameters;

	public class IEConstraints {
		
		public static const PRE_VALIDATION_FORMATTER:LeftSideZerosFormatter = new LeftSideZerosFormatter(14);
		
		public static const P1:Array = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 0];
		
		public static const P2:Array = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 0, 0];
	}
}