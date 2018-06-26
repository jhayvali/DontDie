package  {
	
	import flash.events.Event;
	
	public class LevelEvent extends Event {

		public var score:int;
		public static const GAME_OVER = "gameOver";
		
		public function LevelEvent(type:String, s:int) {
			// constructor code
			super(type);
			score=s;
		}

	}
	
}
