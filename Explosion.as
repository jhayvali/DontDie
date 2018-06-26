package {

	import flash.display.Sprite;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.events.Event;

	public class Explosion extends Sprite {

		private var tweenAlpha: Tween;
		private var tweenSize: Tween;

		public function Explosion(s: Number = 10) {
			// constructor code
			graphics.beginFill(0xFF5A00);
			graphics.drawCircle(0, 0, s / 2);
			graphics.endFill();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event: Event) {
			tweenAlpha = new Tween(this, "alpha", Regular.easeInOut, 1, 0, 20);
			tweenAlpha.addEventListener(TweenEvent.MOTION_FINISH, removeExplosion);

			tweenSize = new Tween(this, "scaleX", Regular.easeInOut, 0, 1, 10);
			tweenSize.addEventListener(TweenEvent.MOTION_CHANGE, applyScale);
		}

		private function removeExplosion(tween: TweenEvent) {
			Sprite(parent).removeChild(this);
		}

		private function applyScale(tween: TweenEvent) {
			scaleY = scaleX;
		}

	}

}