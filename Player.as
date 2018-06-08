package {
    import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
    import KeyObject;
    import flash.events.MouseEvent;
 
    public class Player extends MovieClip {
        public var stageRef:Stage;
        public var key:KeyObject;
 
        public var leftPressed:Boolean = false;
        public var rightPressed:Boolean = false;
        public var upPressed:Boolean = false;
        public var downPressed:Boolean = false;
 
        public var speed:Number = 5; //add this Number variable
		
		private var shotCooldown:int;
		private const MAX_COOLDOWN = 15;
		
 
        public function Player(stageRef:Stage, X:int, Y:int):void {
			// constructor
            this.stageRef = stageRef;
            this.x = X;
            this.y = Y;
            key = new KeyObject(stageRef);
			
			// set the shot cooldown;
			shotCooldown = MAX_COOLDOWN;
			
            addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, initialise);
        }
		
		public function initialise(_event:Event) {
			stage.addEventListener(MouseEvent.CLICK, fire);
		}
 
        public function loop(e:Event):void {
			
			// reduce the shot cooldown by 1
			shotCooldown--;
			
			// reload
			reload();
			
			// check if movement buttons are pressed
            checkKeypresses();
			
			// character movement
			playerControl();
			clampPlayerToStage();
            
        }
		
		public function playerControl() {
			if(leftPressed){
                x -= speed; // move to the left if leftPressed is true
            } else if(rightPressed){
                x += speed; // move to the right if rightPressed is true
            }
 
            if(upPressed){
                y -= speed; // move up if upPressed is true
            } else if(downPressed){
                y += speed; // move down if downPressed is true
            }
			
			//calculate these values, which we will use to determine the angle we need to rotate to
			var yDifference:Number = stageRef.mouseY - y;
			var xDifference:Number = stageRef.mouseX - x;
			//this constant will convert our angle from radians to degrees
			var radiansToDegrees:Number = 180/Math.PI;
			//this final line uses trigonometry to calculate the rotation
			rotation = Math.atan2(yDifference, xDifference) * radiansToDegrees;
		}
		
		public function clampPlayerToStage() {
			// if the player reaches the end of the stage
				// setup the player to the edge of the stage
			if (this.x < this.width/2) {
				this.x = this.width/2;
			}
			
			if (this.x > stage.stageWidth-(this.width/2)) {
				this.x = stage.stageWidth-(this.width/2);
			}
			
			if (this.y < this.height/2) {
				this.y = this.height/2;
			}
			
			if (this.y > stage.stageHeight-(this.height/2)) {
				this.y = stage.stageHeight-(this.height/2);
			}
		}
 
        public function checkKeypresses():void {
            if(key.isDown(37) || key.isDown(65)){
                leftPressed = true;
            } else {
                leftPressed = false;
            }
 
            if(key.isDown(38) || key.isDown(87)){
                upPressed = true;
            } else {
                upPressed = false;
            }
 
            if(key.isDown(39) || key.isDown(68)){
                rightPressed = true;
            } else {
                rightPressed = false;
            }
 
            if(key.isDown(40) || key.isDown(83)){
                downPressed = true;
            } else {
                downPressed = false;
            }
        }
		
		public function fire (_event:MouseEvent) {
			// if we're allowed to shoot
			if (shotCooldown <= 0) {
				// reset the cooldown
				shotCooldown = MAX_COOLDOWN;
				// spawn a bullet
				var b = new Bullet();
				// set the position and rotation of the bullet
				b.rotation = rotation;
				b.x = x;
				b.y = y;
				// add the bullet to the parent object
				parent.addChild(b);
				gotoAndPlay("shoot");
			}
		}
		
		
		public function reload () {
			// reload
			if (key.isDown(82)){
				gotoAndPlay("reload");
			}
		}
    }
}