package 
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.text.TextField;
	import com.facebook.graph.Facebook;

	public class GameOverScreen extends MovieClip
	{

		public var buttonRestart:SimpleButton;
		public var buttonStartScreen:SimpleButton;
		public var finalScore:TextField;

		public function GameOverScreen()
		{
			Mouse.show();
			buttonRestart.addEventListener(MouseEvent.CLICK, onClickRestart, false, 0, true );
			buttonStartScreen.addEventListener(MouseEvent.CLICK, onClickStartScreen, false, 0, true );
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
			Facebook.init("270330579682606");
		}

		public function onClickRestart(mouseEvent:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.RESTART));
		}
		public function onClickStartScreen(mouseEvent:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.STARTSCREEN));
		}
		public function onAddToStage( event:Event ):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress, false, 0, true );
			//stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease, false, 0, true );
			postNewHighScore();
		}
		public function onKeyPress(keyboardEvent:KeyboardEvent):void
		{

			if (keyboardEvent.keyCode == Keyboard.SPACE)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				dispatchEvent(new NavigationEvent(NavigationEvent.RESTART));
			}
			else if (keyboardEvent.keyCode == Keyboard.M)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				dispatchEvent(new NavigationEvent(NavigationEvent.STARTSCREEN));
			}
		}
		public function onKeyRelease(keyboardEvent:KeyboardEvent):void
		{
			if (keyboardEvent.keyCode == Keyboard.SPACE)
			{
				//do nothing
			}
		}

		public function setFinalScore( scoreValue:Number ):void
		{
			finalScore.text = scoreValue.toString();
		}
		public function postNewHighScore():void
		{
			
			
			var data:Object = new Object();
			data.score = "285";
			data.access_token = "270330579682606|rIAeOM8vpS0AwqYsIxzouuC7JdA";
			var requestType:String = "post";
			Facebook.api( Facebook.getAuthResponse().uid + "/scores/" , handlePostScoreComplete, data, requestType);
		}
		public function handlePostScoreComplete(result:Object, fail:Object) {
			trace(result);
			trace(fail);
		}
	}
}