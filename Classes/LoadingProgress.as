package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class LoadingProgress extends Counter {
		
		public var percentDisplay:TextField;
		
		public function LoadingProgress() {
			super();
		}
		
		override public function updateDisplay():void
		{
	 		super.updateDisplay();
			percentDisplay.text = currentValue.toString();
		}
	}
	
}
