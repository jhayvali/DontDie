package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class Bullet extends Sprite {
		
		private var speed : int;
		
		public function Bullet() {
			// constructor code
			speed = 20;
			//  add an event listener to update every frame
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(_event:Event) {
			// move in the direction the bullet is facing
			x = x + Math.cos(rotation/180*Math.PI)*speed;
			y = y + Math.sin(rotation/180*Math.PI)*speed;
			
			// delete the bullet when it's off screen
			if (x < 0 || x > stage.stageWidth || y < 0 || y > stage.stageHeight) {
				// remove the update listener
				removeEventListener(Event.ENTER_FRAME, update);
				// remove the bullet from the screen
				parent.removeChild(this);
			}
		}
	}
	
}
