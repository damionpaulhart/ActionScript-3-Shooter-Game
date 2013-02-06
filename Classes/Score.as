package  {
	
	import flash.text.TextField;
	import flash.display.MovieClip;
	public class Score extends Counter{
		
		public var scoreDisplay:TextField;

		public function Score() {
			super();
		}
		
		override public function updateDisplay():void
		{
			super.updateDisplay();
			//scoreDisplay is a named symbol instance
			scoreDisplay.text = currentValue.toString();

		}

	}
	
}
