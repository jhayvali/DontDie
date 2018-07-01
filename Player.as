package {

	import flash.display.Stage
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import KeyObject;
	import ReusableCode.MyMaths;
	import flash.media.Sound;
	import flash.sampler.Sample;

	public class Player extends MovieClip {

		private var leftPressed: Boolean;
		private var rightPressed: Boolean;
		private var upPressed: Boolean;
		private var downPressed: Boolean;
		private var key: KeyObject;

		private var shotCooldown: Number;
		public var bonusFiringSpeed:Number;
		private var speed: Number;
		private var firing: Boolean;
		public var numShots: int;
		public var bonusShots:int;
		public var health:Number;
		public var fireSound:Sound;
		public var radius:int;
		public var energy:Number;


		public function Player() {
			// constructor code
			key = new KeyObject(stage);
			health = 10;
			shotCooldown = 15;
			speed = 5;
			bonusFiringSpeed=0;
			numShots = 1;
			bonusShots = 0;
			radius = 15;
			energy = 100/2;
			fireSound = new LaserSound();
			addEventListener(Event.ADDED_TO_STAGE, initialise);
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup);
		}

		private function init() {
			leftPressed = false;
			rightPressed = false;
			upPressed = false;
			downPressed = false;
			firing = false;
		}

		private function initialise(event: Event) {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, startFire);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopFire);
		}
		
		private function cleanup(event: Event) {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, startFire);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopFire);
		}
		
		public function update() {
			energy+=0.3;
			if (energy>100) energy = 100;
			shotCooldown--;
			if (shotCooldown<-1) shotCooldown=-1;
			checkKeypresses();
			movePlayer();
			clampPlayerToStage();
			if (firing)
				fire();
		}

		private function startFire(mouse: MouseEvent) {
			firing = true;
		}

		private function stopFire(mouse: MouseEvent) {
			firing = false;
		}

		private function fire() {
			while (shotCooldown <= 0) {
				shotCooldown += 15/(1+bonusFiringSpeed);
				for (var i = 0; i < numShots+bonusShots; i++) {
					var b = new Bullet();
					b.rotation = rotation-(5*(numShots+bonusShots-1)/2)+(i*5);
					b.x = x;
					b.y = y;
					MovieClip(parent).setBullets(b);
					parent.addChild(b);
				}
				play();
				fireSound.play();
			}
		}

		private function movePlayer() {
			if (parent != null) {
				rotation = MyMaths.angleBetween(this, {
					x: parent.mouseX,
					y: parent.mouseY
				});
			}

			if (leftPressed) {
				x -= speed; // move to the left if leftPressed is true
			} else if (rightPressed) {
				x += speed; // move to the right if rightPressed is true
			}

			if (upPressed) {
				y -= speed; // move up if upPressed is true
			} else if (downPressed) {
				y += speed; // move down if downPressed is true
			}
		}

		private function clampPlayerToStage() {
			// if the player reaches the end of the stage
			// setup the player to the edge of the stage
			if (this.x < this.width / 2) {
				this.x = this.width / 2;
			}

			if (this.x > stage.stageWidth - (this.width / 2)) {
				this.x = stage.stageWidth - (this.width / 2);
			}

			if (this.y < this.height / 2) {
				this.y = this.height / 2;
			}

			if (this.y > stage.stageHeight - (this.height / 2)) {
				this.y = stage.stageHeight - (this.height / 2);
			}
		}

		private function checkKeypresses() {
			if (key.isDown(37) || key.isDown(65)) {
				leftPressed = true;
			} else {
				leftPressed = false;
			}

			if (key.isDown(38) || key.isDown(87)) {
				upPressed = true;
			} else {
				upPressed = false;
			}

			if (key.isDown(39) || key.isDown(68)) {
				rightPressed = true;
			} else {
				rightPressed = false;
			}

			if (key.isDown(40) || key.isDown(83)) {
				downPressed = true;
			} else {
				downPressed = false;
			}
		}
		
		public function getHealth(): Number {
			return health;
		}
		
		public function reduceHealth():void {
			health--;
		}
	}

}