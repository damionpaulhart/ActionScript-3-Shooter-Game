package  {
	
	import flash.events.Event;
	public class AvatarEvent extends Event {
		
		public static const WIN:String = "win";
		public static const HIT:String = "hit";

		public function AvatarEvent(type:String) {
			
			super(type);
			
		}

	}
	
}
