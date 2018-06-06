package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class Bullet extends Sprite {
		
		private var speed : int;
		
		public function Bullet() {
			// constructor code
			speed = 10;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(_event:Event) {
			x = x + Math.cos(rotation/180*Math.PI)*speed;
			y = y + Math.sin(rotation/180*Math.PI)*speed;
		}
	}
	
}
