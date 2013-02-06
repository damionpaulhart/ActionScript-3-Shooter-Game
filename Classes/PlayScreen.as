package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.display.Sprite;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class PlayScreen extends MovieClip
	{
		public var useMouseControl:Boolean;
		public var downKeyIsBeingPressed:Boolean;
		public var upKeyIsBeingPressed:Boolean;
		public var leftKeyIsBeingPressed:Boolean;
		public var rightKeyIsBeingPressed:Boolean;

		public var army:Array;
		public var avatar:Avatar;
		public var gameTimer:Timer;
		public var gameScore:MovieClip;

		public var backgroundMusic:BackgroundMusic;
		public var bgmSoundChannel:SoundChannel;//bgm for BackGround Music
		public var backgroundVolume:SoundTransform;
		public var backgroundScroll:BackgroundScroll;

		public function PlayScreen()
		{
			//CONTROL
			Mouse.hide();
			useMouseControl = false;
			downKeyIsBeingPressed = false;
			upKeyIsBeingPressed = false;
			leftKeyIsBeingPressed = false;
			rightKeyIsBeingPressed = false;


			//SPRITES
			backgroundScroll = new BackgroundScroll();
			addChild(backgroundScroll);

			army = new Array();
			avatar = new Avatar();
			avatar.x = mouseX;
			avatar.y = mouseY;
			if (useMouseControl)
			{
				avatar.x = mouseX;
				avatar.y = mouseY;
			}
			else
			{
				avatar.x = 0 + avatar.width / 2;
				avatar.y = 200;
			}
			addChild(avatar);

			backgroundMusic = new BackgroundMusic();
			bgmSoundChannel = backgroundMusic.play(0,10);
			backgroundVolume = new SoundTransform(0.1,0);
			bgmSoundChannel.soundTransform = backgroundVolume;

			setChildIndex(gameScore, numChildren-1);

			//LISTENERS
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);

			//TIME
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, onTick, false, 0, true );
			gameTimer.start();
		}

		public function onTick(timerEvent:TimerEvent):void
		{
			backgroundScroll.Scroll();

			// AVATAR MOVEMENT;
			if (useMouseControl)
			{
				avatar.x = mouseX;
				if (avatar.x > (stage.stageWidth+30) - (avatar.width/2))
				{
					avatar.x = (stage.stageWidth+30) - (avatar.width/2);
				}
				if (avatar.x < (0-10) + (avatar.width/2))
				{
					avatar.x = (0-10) + (avatar.width/2);
				}
				avatar.y = mouseY;
				if (avatar.y > (stage.stageHeight+20) - (avatar.height/2))
				{
					avatar.y = (stage.stageHeight+20) - (avatar.height/2);
				}
				if (avatar.y < (0-10) + (avatar.height/2))
				{
					avatar.y = (0-10) + (avatar.height/2);
				}
			}
			else
			{
				if (downKeyIsBeingPressed)
				{
					avatar.moveABit(0,1);
				}
				else if ( upKeyIsBeingPressed )
				{
					avatar.moveABit( 0, -1 );
				}
				else if ( leftKeyIsBeingPressed )
				{
					avatar.moveABit( -1, 0 );
				}
				else if ( rightKeyIsBeingPressed )
				{
					avatar.moveABit( 1, 0 );
				}
			}

			//we should check the avatar's position here
			//and move it if we need to
			//RIGHT
			if (avatar.x > (stage.stageWidth+30) - (avatar.width/2))
			{
				avatar.x = (stage.stageWidth+30) - (avatar.width/2);
			}
			//LEFT
			if (avatar.x < (0-10) + (avatar.width/2))
			{
				avatar.x = (0-10) + (avatar.width/2);
			}
			//TOP
			if (avatar.y > (stage.stageHeight+20) - (avatar.height/2))
			{
				avatar.y = (stage.stageHeight+20) - (avatar.height/2);
			}
			//BOTOM
			if (avatar.y < (0-10) + (avatar.height/2))
			{
				avatar.y = (0-10) + (avatar.height/2);
			}
			
			avatar.glower();
			//COLLISION DETECTION
			var i:int = army.length - 1;
			var enemy:Enemy;

			while (i >-1)
			{
				enemy = army[i];
				enemy.Move();

				if (avatar.hit.hitTestObject(enemy.hit))
				//if ( PixelPerfectCollisionDetection.isColliding( avatar, enemy, this, true ) )
				{
					bgmSoundChannel.stop();
					gameTimer.stop();
					dispatchEvent(new AvatarEvent(AvatarEvent.HIT));
				}
				if (enemy.x <= 0)
				{
					removeChild(enemy);
					army.splice(i,1);
					gameScore.addToValue( 10 );
				}

				i = i - 1;
			}

			// Add new enemies
			if (Math.random() < 0.05)
			{// Stops from creating every tick

				if (army.length < 5)
				{
					//var RandomX:Number = Math.random() * 600;
					var RandomX:Number = stage.stageWidth;
					var RandomY:Number = Math.random() * 400;
					var newEnemy = new Enemy(RandomX,RandomY);
					army.push(newEnemy);
					addChild(newEnemy);
					setChildIndex(gameScore, numChildren-1);
				}
			}
		}

		public function onKeyPress(keyboardEvent:KeyboardEvent):void
		{
			if (keyboardEvent.keyCode == Keyboard.DOWN)
			{
				downKeyIsBeingPressed = true;
			}
			else if ( keyboardEvent.keyCode == Keyboard.UP )
			{
				upKeyIsBeingPressed = true;
			}
			else if ( keyboardEvent.keyCode == Keyboard.LEFT )
			{
				leftKeyIsBeingPressed = true;
			}
			else if ( keyboardEvent.keyCode == Keyboard.RIGHT )
			{
				rightKeyIsBeingPressed = true;
			}
		}

		public function onKeyRelease(keyboardEvent:KeyboardEvent):void
		{
			if (keyboardEvent.keyCode == Keyboard.DOWN)
			{
				downKeyIsBeingPressed = false;
			}
			else if ( keyboardEvent.keyCode == Keyboard.UP )
			{
				upKeyIsBeingPressed = false;
			}
			else if ( keyboardEvent.keyCode == Keyboard.LEFT )
			{
				leftKeyIsBeingPressed = false;
			}
			else if ( keyboardEvent.keyCode == Keyboard.RIGHT )
			{
				rightKeyIsBeingPressed = false;
			}
		}

		public function onAddToStage(event:Event):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress, false, 0, true );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease, false, 0, true );
		}
		
		public function getFinalScore():Number{
			return gameScore.currentValue;
		}

	}

}