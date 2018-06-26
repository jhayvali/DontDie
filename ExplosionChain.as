package  {
	
	import flash.display.Sprite;
	import Explosion;
	import ReusableCode.MyMaths;
	import flash.events.Event;
	
	public class ExplosionChain extends Sprite {
		
		private var lifeSpan:int;
		private var birthRate:Number;
		private var blastRadius:Number;
		private var minBlastSize:int;
		private var maxBlastSitze:int;
		private var birthCounter:Number;

		public function ExplosionChain(l:int=20, b:Number=0.5, br:Number=20, minB:int=5, maxB:int=20) {
			// constructor code
			lifeSpan = l;
			birthRate = b;
			blastRadius = br;
			minBlastSize = minB;
			maxBlastSitze = maxB;
			birthCounter = 1;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(event:Event) {
			lifeSpan--;
			if (lifeSpan>0) {
				while(birthCounter>=0) {
					birthCounter-=birthRate;
					var ex = new Explosion(maxBlastSitze+(maxBlastSitze-minBlastSize)*Math.random());
					ex.rotation = Math.random()*360;
					MyMaths.moveForward(ex, Math.random()*blastRadius);
					addChild(ex);
				}
				birthCounter+=1;
			} else if(numChildren==0){
				Sprite(parent).removeChild(this);
				removeEventListener(Event.ENTER_FRAME, update);
			}
		}
	}
	
}
