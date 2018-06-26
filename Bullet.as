package {

	import flash.display.Sprite;
	import flash.events.Event;
	import ReusableCode.MyMaths;

	public class Bullet extends Sprite {
		
		private var speed: int;

		public function Bullet() {
			// constructor code
			speed = 10;
		}

		public function update() {
			MyMaths.moveForward(this, speed);
			
			if(x<0 || x>stage.stageWidth || y<0 || y> stage.stageHeight){
				parent.removeChild(this);
			}
		}
	}
}