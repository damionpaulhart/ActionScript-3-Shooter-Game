package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.events.FocusEvent;
	import flash.external.ExternalInterface;

	public class DocumentClass extends MovieClip
	{
		public var loadingProgress:LoadingProgress;
		public var menuScreen:MenuScreen;
		public var playScreen:PlayScreen;
		public var gameOverScreen:GameOverScreen;
		public var params:Object;
		public var params1:String;

		// HACK:: Internet Explorer. allows use of arrow keys in windowMode:opaque 
		private var _hiddenText:TextField;

		public function DocumentClass()
		{
			stage.stageFocusRect = false;
			loaderInfo.addEventListener(Event.COMPLETE, onCompletelyDownloaded, false, 0, true );
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, onDownloadProgressMade, false, 0, true );
			params = loaderInfo.parameters;
			var length:int = 0;
			for (var str:String in params)
			{
				length++;
			}
			if (length == 0)
			{
				params = {myVariable:"Space Shark",myVariable2:"Test2"};
			}
			params1 = "WELCOME: " + params["myVariable"];

			/*for (str in params)
			{
			trace(str+" : "+ params[str]);
			params1 = params[str];
			trace(params1);
			
			}*/
			// HACK:: Internet Explorer. allows use of arrow keys in windowMode:opaque 
			_hiddenText = new TextField();
			_hiddenText.type = TextFieldType.INPUT;
			_hiddenText.width = 1;
			_hiddenText.height = 1;
			_hiddenText.alpha = 0.0;
			_hiddenText.mouseEnabled = false;
			addChild( _hiddenText );
			// under addChild( _hiddenText );
			_hiddenText.addEventListener( FocusEvent.FOCUS_OUT, _textFocus );
			stage.focus = _hiddenText;
			//get browser focus
			
		}

		public function onDownloadProgressMade( progressEvent:ProgressEvent):void
		{
			//trace( Math.floor(100*loaderInfo.bytesLoaded / loaderInfo.bytesTotal) );
			loadingProgress.setValue(Math.floor(100*loaderInfo.bytesLoaded / loaderInfo.bytesTotal) );
		}

		public function onCompletelyDownloaded( event:Event):void
		{
			FocusThisSwf();
			gotoAndStop(3);
			showMenuScreen();
		}

		public function showMenuScreen():void
		{
			menuScreen = new MenuScreen(params1);
			menuScreen.x = 0;
			menuScreen.y = 0;
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart, false, 0, true  );
			addChild(menuScreen);
			stage.focus = menuScreen;
		}

		public function onRequestStart(navigationEvent:NavigationEvent):void
		{
			playScreen = new PlayScreen();
			playScreen.x = 0;
			playScreen.y = 0;
			playScreen.addEventListener( AvatarEvent.HIT, onAvatarEvent, false, 0, true  );
			addChild(playScreen);
			removeChild(menuScreen);
			menuScreen = null;
			stage.focus = playScreen;
		}

		public function onAvatarEvent(avatarEvent:AvatarEvent):void
		{
			// AvatarEvent.HIT
			var finalScore:Number = playScreen.getFinalScore();
			gameOverScreen = new GameOverScreen();
			gameOverScreen.x = 0;
			gameOverScreen.y = 0;
			gameOverScreen.setFinalScore( finalScore );
			gameOverScreen.addEventListener(NavigationEvent.RESTART, onRequestRestart, false, 0, true );
			gameOverScreen.addEventListener(NavigationEvent.STARTSCREEN, onRequestStartScreen, false, 0, true );
			addChild(gameOverScreen);
			removeChild(playScreen);
			playScreen = null;
			stage.focus = gameOverScreen;
		}

		public function onRequestRestart(navigationEvent:NavigationEvent):void
		{
			playScreen = new PlayScreen();
			playScreen.x = 0;
			playScreen.y = 0;
			playScreen.addEventListener( AvatarEvent.HIT, onAvatarEvent, false, 0, true  );
			addChild(playScreen);
			removeChild(gameOverScreen);
			gameOverScreen = null;
			stage.focus = playScreen;
		}

		public function onRequestStartScreen(navigationEvent:NavigationEvent):void
		{
			menuScreen = new MenuScreen(params1);
			menuScreen.x = 0;
			menuScreen.y = 0;
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart, false, 0, true  );
			addChild(menuScreen);
			removeChild(gameOverScreen);
			gameOverScreen = null;
			stage.focus = playScreen;
		}

		// HACK:: Internet Explorer. allows use of arrow keys in windowMode:opaque 
		private function _textFocus( e:FocusEvent ):void
		{
			// check if anything has focus
			if (stage.focus)
			{
				// if you have other input fields, don’d update focus
				//if ( stage.focus.name != “_txtName” && stage.focus.name != “_txtDescription” )
				//{
				// set focus dynamically
				stage.focus = _hiddenText;
			}
			else
			{
				// set focus dynamically
				stage.focus = _hiddenText;
			}
		}
		public static function FocusThisSwf():void {
			if(!ExternalInterface.available)
				return;
			/*ExternalInterface.call("eval", "document.getElementById('" +
				ExternalInterface.objectID + "').focus()");*/
			ExternalInterface.call("eval", "document.getElementById('FlashID').focus()");
		}
	}
}