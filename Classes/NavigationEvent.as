package  {
	
	import flash.events.Event;
	public class NavigationEvent extends Event {
		
		public static const START:String = "start";
		public static const RESTART:String = "restart";
		public static const STARTSCREEN:String = "startscreen";

		public function NavigationEvent(type:String) {
			super (type);		}

	}
	
}
