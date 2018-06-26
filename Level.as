package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import ExplosionChain;
	import LevelEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;

	public class Level extends MovieClip {

		protected var ghosts: Array;
		protected var bullets: Array;
		protected var gameOver: Boolean;
		protected var spawning: Boolean;
		protected var score: int;
		protected var timer: Timer;
		protected var spawnCounter: int;
		protected var numToSpawn: int;
		protected var numToSpawnCounter: int;

		public function Level() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, everyFrame);
			ghosts = new Array();
			bullets = new Array();
			gameOver = false;
			spawning = false;
			score = 0;
			spawnCounter = 0;
			numToSpawn = 1;
			numToSpawnCounter = 0;
			timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, beginSpawning);
			timer.start();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		}
		
		protected function keyPressed(k:KeyboardEvent) {
			if(k.keyCode==Keyboard.Q) {
				thePlayer.numShots++;
			}
			if(k.keyCode==Keyboard.E) {
				thePlayer.numShots--;
			}
		}

		protected function beginSpawning(t: TimerEvent) {
			spawning = true;
		}

		protected function transitionOut(t: TimerEvent) {
			var ev: LevelEvent = new LevelEvent(LevelEvent.GAME_OVER, score);
			dispatchEvent(ev);
		}

		protected function everyFrame(event: Event) {

			spawnCounter++;
			numToSpawnCounter++;

			doBullets();

			doGhosts();

			if (!gameOver) {
				doSpawning();
				thePlayer.update();

				if (thePlayer.health <= 0) {
					gameOver = true;
					timer = new Timer(3000, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, transitionOut);
					timer.start();

					var ex = new ExplosionChain(60, 0.3, 60, 20, 45);
					ex.x = thePlayer.x;
					ex.y = thePlayer.y;
					addChild(ex);
				}
			}

			output.text = "Score: " + score;

		}

		protected function doSpawning() {
			if (!spawning)
				return;
			
			if(numToSpawnCounter > 200){
				numToSpawn++;
				numToSpawnCounter = 0;
			}

			if (spawnCounter > 100) {
				spawnCounter = 0;
				for (var i = 0; i < numToSpawn; i++) {
					var g = new Ghost();
					addChild(g);
					var rnd:Number = Math.random()*2*Math.PI;
					g.x = thePlayer.x + Math.cos(rnd)*360;
					g.y = thePlayer.y + Math.sin(rnd)*360;
					g.rotation = Math.random() * 360;
					ghosts.push(g);
				}
			}
		}

		protected function doBullets() {
			for (var bCount = bullets.length - 1; bCount >= 0; bCount--) {
				bullets[bCount].update();
				if (bullets[bCount].parent == null) {
					bullets.splice(bCount, 1);
				}
			}
		}

		protected function doGhosts() {
			for (var count = ghosts.length - 1; count >= 0; count--) {
				var gh = ghosts[count];
				gh.update();
				for (var bCount = bullets.length - 1; bCount >= 0; bCount--) {
					if (gh.hitTestObject(bullets[bCount])) {
						gh.reduceHealth();
						removeChild(bullets[bCount]);
						bullets.splice(bCount, 1);
					}
				}

				if (gh.hitTestObject(thePlayer)) {
					thePlayer.reduceHealth();
					gh.reduceHealth();
				}

				if (gh.getHealth() <= 0) {
					score++;
					removeChild(gh);
					ghosts.splice(count, 1);
				}
			}
		}

		public function setBullets(b: Bullet) {
			bullets.push(b);
		}
	}

}