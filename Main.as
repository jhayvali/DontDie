package {
    import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
	import GameConstants;
 
    public class Main extends MovieClip {
        private var player:Player;
		
		private var bullets:Array;
		private var enemys:Array;
		
		private var count:int;
		
		private var enemySpeed:int;
		
		private var g:GameConstants;
 
        public function Main():void {
			g =new GameConstants();
            player = new Player(stage, 320, 240); //pass the stage as the first argument
			addChild(player);
			
			addEventListener(Event.ENTER_FRAME, loop);
			enemys = new Array();
			bullets = new Array();
			count = 0;
			enemySpeed = GameConstants.ENEMY_SPEED;
        }
		
		private function loop(_event:Event) {
			if (count < 5) {
				var zombie = new Zombie(Math.random()*stage.stageWidth, Math.random()*stage.stageHeight);
				enemys.push(zombie);
				addChild(zombie);
				count++;
			}
			for (var bCount=bullets.length-1; bCount>=0;bCount--) {
				bullets[bCount].update();
				if (bullets[bCount].parent==null){
					bullets.splice(bCount, 1);
				}
			}
			// make for loop ti iterate through all enemys
			for (var j = enemys.length-1; j>=0; j--) {
				enemys[j].update(player);
				if (enemys[j].hitTestObject(player)){
					trace("dead");
				}
				// add a new for loop to go through all bullets
				for (bCount=bullets.length-1; bCount>=0;bCount--) {
					// check collision
					if(enemys[j].hitTestObject(bullets[bCount])) {
						// hit equals true
						enemys[j].health--;
						removeChild(bullets[bCount]);
						bullets.splice(bCount, 1);
					}
				}
				// if enemy is dead, remove it
				if (enemys[j].health<=0) {
					removeChild(enemys[j]);
					enemys.splice(j,1);
				}
			}
			moveEnemys();
		}
		
		private function moveEnemys() {
			for (var k = 0; k<enemys.length;k++) {
				if(enemys[k].x < player.x) {
					enemys[k].x += enemySpeed;
					if(enemys[k].y < player.y) {
						enemys[k].y += enemySpeed;
					} else if(enemys[k].y > player.y) {
						enemys[k].y -= enemySpeed;
					} 
				} else if(enemys[k].x > player.x) {
					enemys[k].x -= enemySpeed;
					if(enemys[k].y < player.y) {
						enemys[k].y += enemySpeed;
					} else if(enemys[k].y > player.y) {
						enemys[k].y -= enemySpeed;
					} 
				}
			}
		}
		
		public function setBulletArray(b:Bullet) {
			bullets.push(b);
		}
    }
}