package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class Config {
		
		public var bulletSpeed:int;
		public var bulletRadius:int;
		public var ghostHealth:int;
		public var ghostRadius:int;
		public var perkCost:Number;
		public var playerShotCooldown:Number;
		public var playerSpeed:Number;
		public var playerHealth:Number;
		public var playerRadius:int;
		public var playerEnergy:Number;
		
		private var varLoader:URLLoader = new URLLoader(new URLRequest("Config.txt"));
		
		private static var _instance:Config;
		
		public function Config() {
			varLoader.addEventListener(Event.COMPLETE, completeConfig);
		}
		
		public static function getInstance():Config {
			if(!_instance)
				_instance = new Config();
			return _instance;
		}
		
		private function completeConfig(event:Event):void {
			var loadedVars:URLLoader = URLLoader(event.target);
			var variables:URLVariables = new URLVariables(loadedVars.data);
			
			bulletSpeed = variables.bullet_speed;
			bulletRadius = variables.bullet_radius;
			ghostHealth = variables.ghost_health;
			ghostRadius = variables.ghost_radius;
			perkCost = variables.perk_cost;
			playerShotCooldown = variables.player_shotcooldown;
			playerSpeed = variables.player_speed;
			playerHealth = variables.player_health;
			playerRadius = variables.player_radius;
			playerEnergy = variables.player_energy;
			
			trace(playerHealth);
			
		}

	}
	
}
