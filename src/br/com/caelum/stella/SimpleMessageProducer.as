package br.com.caelum.stella
{
	
	public class SimpleMessageProducer implements MessageProducer {
		
		public function SimpleMessageProducer() {
		}
		
		public function getMessage(error:String):ValidationMessage {
			/*var simpleName:String = error
			String simpleName = error.getClass().getSimpleName();
			String errorName = error.name();
			String key = simpleName + "." + errorName;
			String message;
			message = key.replaceFirst("[.]", " : ").replaceAll("_", " ");
			return new SimpleValidationMessage(message);*/
			return new SimpleValidationMessage(error);
		}
	}
}