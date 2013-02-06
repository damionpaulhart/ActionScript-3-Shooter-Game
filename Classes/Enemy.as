package 
{

	import flash.display.MovieClip;
	import flash.filters.*;
	
	public class Enemy extends MovieClip
	{
		public var hit;
		public var xSpeed:Number = 3;	//pixels moved to the right per tick
		public var ySpeed:Number = 3;	//pixels moved downwards per tick
		public var myGlow:GlowFilter;
		public var glow:Boolean = true;

		public function Enemy(startX:Number, startY:Number)
		{
			x = startX;
			y = startY;
			//xSpeed
			//ySpeed
			myGlow = new GlowFilter();
			myGlow.color = 0x0000FF;
			myGlow.strength = 255;
			myGlow.alpha = randomMinMax(0,1);
			this.filters = [myGlow];
		}

		public function Move():void
		{
			//x += xSpeed;
			x = x - xSpeed;
			/*x = x + xSpeed + ((Math.random() * 2) -1);
			if (x > stage.stageWidth - (width/2))
			 {
				 x = stage.stageWidth - (width/2);
				 xSpeed *= -1;
				 this.rotationY += 180;
			 }
			 if (x < 0 + (width/2))
			 {
				 x = 0 + (width/2);
				 xSpeed *= -1;
				 this.rotationY += 180;
			 }*/
			
			//y += ySpeed;
			/*y = y + ySpeed + (Math.random() / 10);
			if (y > stage.stageHeight - (height/2))
			{ 
				y = stage.stageHeight - (height/2);
				ySpeed *= -1
			}
			if (y < 0 + (height/2))
			{ 
				y = 0 + (height/2);
				ySpeed *= -1
			}*/
			
			if (glow == true) {
				if (myGlow.alpha >= 1) {
					glow = false;
				}
			myGlow.alpha = myGlow.alpha + 0.02;
			}
			if (glow == false)  {
				if (myGlow.alpha <= .5) {
					glow = true;
				}
				myGlow.alpha = myGlow.alpha - 0.02;
			}
			filters = [myGlow];
			
			
            
		}
		function randomMinMax( min:Number, max:Number ):Number
{
     return min + (max - min) * Math.random();
}

	}

}