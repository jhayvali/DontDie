package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import LevelEvent;

	public class Main extends MovieClip {

		private var endScore:int;
		public function Main() {

		}

		public function doGameOver(event: LevelEvent) {
			endScore = event.score;
			play();
		}
	}
}