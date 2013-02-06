package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class MenuScreen extends MovieClip {
		
		public var buttonStart:SimpleButton;
		public var userName:TextField;
		
		public function MenuScreen(Name:String) {
			Mouse.show();
			userName.text = Name;
			buttonStart.addEventListener(MouseEvent.CLICK, onClickStart, false, 0, true );
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		}
		
		public function onClickStart(event:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.START));
		}
		public function onAddToStage( event:Event ):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress, false, 0, true );
			//stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease, false, 0, true );
		}
		public function onKeyPress(keyboardEvent:KeyboardEvent):void{
			if (keyboardEvent.keyCode == Keyboard.SPACE)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				dispatchEvent(new NavigationEvent(NavigationEvent.START));
			}
		}
		public function onKeyRelease(keyboardEvent:KeyboardEvent):void{
			if (keyboardEvent.keyCode == Keyboard.SPACE)
			{
				//do nothing
			}
		}
	}
	
}
