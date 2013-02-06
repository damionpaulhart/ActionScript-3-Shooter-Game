//TODO:
// create parameters for image, direction, speed

package  {
	
	import flash.display.MovieClip;
	public class BackgroundScroll extends MovieClip {
		
		public var bg1:MovieClip;
		public var bg2:MovieClip;

		public function BackgroundScroll() {
			
			bg1 = new background();
			bg1.x = bg1.width/2;
			bg1.y = 0;
			addChild(bg1);
			
			bg2 = new background();
			bg2.x = -bg2.width/2;
			bg2.y = 0;
			addChild(bg2);
		}
		
		public function Scroll():void
		{
			bg1.x -= 1;
			if (bg1.x <= 0 -stage.stageWidth) bg1.x = stage.stageWidth;
			bg2.x -= 1;
			if (bg2.x <= 0 - stage.stageWidth) bg2.x = stage.stageWidth;
		}

	}
	
}
