package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import ExplosionChain;
	import LevelEvent;

	public class Level extends MovieClip {

		protected var ghosts: Array;
		protected var bullets: Array;
		protected var gameOver: Boolean;
		private var score: int;

		public function Level() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, everyFrame);
			ghosts = new Array();
			bullets = new Array();
			gameOver = false;
			score = 0;
		}

		protected function everyFrame(event: Event) {



			doBullets();

			doGhosts();

			if (!gameOver) {
				doSpawning();
				thePlayer.update();

				if (thePlayer.health <= 0) {
					gameOver = true;
					var ev:LevelEvent = new LevelEvent(LevelEvent.GAME_OVER, score);
					dispatchEvent(ev);
					var ex = new ExplosionChain(60, 0.3, 60, 20, 45);
					ex.x = thePlayer.x;
					ex.y = thePlayer.y;
					addChild(ex);
				}
			}

			output.text = "Score: " + score;

		}

		protected function doSpawning() {
			if (numChildren < 10) {
				var g = new Ghost();
				addChild(g);
				g.x = Math.random() * stage.stageWidth;
				g.y = Math.random() * stage.stageHeight;
				g.rotation = Math.random() * 360;
				ghosts.push(g);
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