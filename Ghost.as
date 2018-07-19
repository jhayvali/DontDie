package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import ReusableCode.MyMaths;

	public class Ghost extends MovieClip {

		protected var speed: int;
		protected var target: Point;
		protected var health: int;
		protected var timeToTarget:int;
		public var radius:int;

		public function Ghost() {
			// constructor code
			health = Config.getInstance().ghostHealth;
			timeToTarget = 0;
			speed = 2 + Math.random() * 5;
			radius = Config.getInstance().bulletRadius;
			target = new Point(Math.random() * 640, Math.random() * 500);
		}

		public function update() {
			timeToTarget++;
			var desiredRotation = MyMaths.angleBetween(this, target);
			var angleDiff = desiredRotation-rotation;
			while(angleDiff>180) angleDiff-=360;
			while(angleDiff<-180) angleDiff+=360;
			if(angleDiff>2)
				rotation = rotation+2;
			if(angleDiff<-2)
				rotation = rotation-2;
			MyMaths.moveForward(this, speed);
			var hyp = MyMaths.distanceBetween(target, this);
			if (hyp < 20 || timeToTarget>200) {
				target.x = Math.random() * 640;
				target.y = Math.random() * 500;
				timeToTarget = 0;
			}
		}
		
		public function getHealth():int{
			return health;
		}
		
		public function reduceHealth(){
			health--;
		}
	}

}