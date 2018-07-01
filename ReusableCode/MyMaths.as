package ReusableCode {
	
	public class MyMaths {
		
		public static function distanceBetween(o1:Object, o2:Object):Number {
			var dx = o1.x - o2.x;
			var dy = o1.y - o2.y;
			return Math.sqrt((dx * dx) + (dy * dy));
		}
		
		public static function hitTest(o1:Object, o2:Object): Boolean {
			var combinedRadii = o1.radius+o2.radius;
			if (combinedRadii > distanceBetween(o1,o2)){
				return true;
			}
			return false;
		}
		
		public static function moveForward(o1:Object, s:Number) {
			o1.x = o1.x + Math.cos(o1.rotation / 180 * Math.PI) * s;
			o1.y = o1.y + Math.sin(o1.rotation / 180 * Math.PI) * s;
		}
		
		public static function angleBetween(o1:Object, o2:Object):Number {
			var dx = o2.x - o1.x;
			var dy = o2.y - o1.y;
			return Math.atan2(dy, dx) / Math.PI * 180;
		}

	}
	
}
