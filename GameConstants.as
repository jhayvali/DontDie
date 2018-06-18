package {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class GameConstants {
		
		public static const BULLET_SPEED:int = 20;
		public static const ENEMY_SPEED:int = 2;
		public static const PLAYER_SPEED:int = 5;
		public static const HANDGUN_RELOAD_COOLDOWN:int = 15;
		public static const ZOMBIE_MELEE_HEALTH:int = 1;
		
		private var loader:URLLoader;
		private var values:Array;
		public function GameConstants() {
			values = new Array();
			loader = new URLLoader(new URLRequest("Settings.ini"));
			loader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event) {
			var data:String = e.target.data;
			data = data.replace(' ','');
			var pairs:Array = data.split("\r\n");
			var pattern:RegExp = /=/;
			for each (var s:String in pairs) {
				if (pattern.test(s)) {
					//we've got a match, let's extract value
					var value:String = s.split("=")[1];
					value = value.split("\"").join("");
					values.push(value);
				}
			}
		}
	}
}