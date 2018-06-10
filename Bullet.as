package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class Bullet extends Sprite {
		
		private var speed : int;
		
		public function Bullet() {
			// constructor code
			speed = 20;
		}
		
		public function update() {
			// move in the direction the bullet is facing
			moveForward(speed);
			// delete the bullet when it's off screen
			deleteBullet();
		}
		
		private function moveForward(s:Number) {
			x = x + Math.cos(rotation/180*Math.PI)*s;
			y = y + Math.sin(rotation/180*Math.PI)*s;
		}
		
		private function deleteBullet() {
			if (x < 0 || x > stage.stageWidth || y < 0 || y > stage.stageHeight) {
				// remove the bullet from the screen
				parent.removeChild(this);
			}
		}
	}
}
