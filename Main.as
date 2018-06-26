package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import LevelEvent;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class Main extends MovieClip {

		private var endScore: int;
		private var tweens: Array;
		private var targetFrame:String;
		private var proTipTimer:Timer;
		private var proTips:Array;
		
		public function Main() {
			targetFrame = "Menu";
			proTips = new Array();
			proTips.push("You can fire with mouse!");
			proTips.push("You can move with W A S D");
			proTips.push("If a ghost touches you, you lose a life");
		}
		
		private function newProTip(t:TimerEvent) {
			if(currentLabel != "Menu") {
				proTipTimer.removeEventListener(TimerEvent.TIMER, newProTip);
				proTipTimer.stop();
				return;
			}
			var tip:String = proTips[Math.floor(Math.random()*proTips.length)];
			theProTip.text = tip;
		}

		public function doGameOver(event: LevelEvent) {
			endScore = event.score;
			targetFrame = "GameOver";
			tweenOut();
		}

		private function gotoLabel(desiredLabel: String) {
			for (var i = 0; i < currentLabels.length; i++) {
				if (currentLabels[i].name == desiredLabel) {
					gotoAndPlay(desiredLabel);
					return;
				}
			}
		}
		
		private function restart(mouse:MouseEvent) {
			targetFrame = "Menu";
			tweenOut();
		}
		
		private function startGame(mouse:MouseEvent) {
			targetFrame = "Level1";
			tweenOut();
		}
		
		private function tweenIn() {
			tweens = new Array();
			for (var i = 0; i<numChildren; i++) {
				var ob = getChildAt(i);
				
				var tw:Tween = new Tween(ob, "x", Back.easeInOut, ob.x-stage.stageWidth, ob.x, 20+(i*10));
				tweens.push(tw);
			}
		}
		
		private function tweenOut() {
			for (var i = 0; i<tweens.length; i++) {
				tweens[i].yoyo();
				if(i == tweens.length-1){
					tweens[i].addEventListener(TweenEvent.MOTION_FINISH, tweenedOut);
				}
			}
		}
		
		private function tweenedOut(t: TweenEvent) {
			gotoLabel(targetFrame);
		}
	}
}