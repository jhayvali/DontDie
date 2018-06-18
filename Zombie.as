﻿package  {
	
	import flash.display.MovieClip;
	import GameConstants;
	
	public class Zombie extends MovieClip {
		
		public var health:int;
		
		public function Zombie(_x : int, _y : int) {
			x = _x;
			y = _y;
			health = GameConstants.ZOMBIE_MELEE_HEALTH;
		}
		
		public function update(target:MovieClip) {
			rotation = facePoint(target.x, target.y);
		}
		
		private function facePoint(fx:Number, fy:Number): Number {
			var dx = fx - x;
			var dy = fy - y;
			var angle = Math.atan2(dy, dx)/Math.PI*180;
			return angle;
		}
	}	
}