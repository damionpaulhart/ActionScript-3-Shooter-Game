package 
{

	import flash.display.MovieClip;
	import flash.filters.*;
	
	public class Avatar extends MovieClip
	{

		public var hit;
		public var myGlow:GlowFilter;
		public var glow:Boolean = false;

		public function Avatar()
		{
			// constructor code
			myGlow = new GlowFilter();
			myGlow.color = 0x00FF00;
			myGlow.strength = 255;
			this.filters = [myGlow];
		}
		public function moveABit(xDistance:Number, yDistance:Number):void
		{
			var baseSpeed:Number = 4;
			x += ( xDistance * baseSpeed );
			y += ( yDistance * baseSpeed );
		}
		public function glower() {
			if (glow == true) {
				if (myGlow.alpha >= 1) {
					glow = false;
				}
			myGlow.alpha = myGlow.alpha + 0.02;
			}
			if (glow == false)  {
				if (myGlow.alpha <= 0) {
					glow = true;
				}
				myGlow.alpha = myGlow.alpha - 0.02;
			}
			filters = [myGlow];
		}

	}

}