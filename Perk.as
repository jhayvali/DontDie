package  {
	
	import flash.display.Sprite;
	
	public class Perk extends Sprite{
		
		protected var type:String;
		protected var strength:Number;
		protected var attribute:String;
		protected var target:Object;
		protected var lifeSpan:int;
		protected var maxLifeSpan:int;
		
		const BAR_WIDTH=100;
		const BAR_HEIGHT=15;
		public function Perk(tar:Object, s:Number=1, a:String="bonusShots", t:String="Multi Shot", l:int=100) {
			// constructor code
			type = t;
			strength = s;
			attribute = a;
			target = tar;
			lifeSpan = l;
			maxLifeSpan = l;
			perkName.text=t+"::::::::::::::::";
			perkName.blendMode="invert";
			target[attribute] += strength;
		}
		
		public function update() {
			lifeSpan--;
			graphics.clear();
			var fraction = lifeSpan/maxLifeSpan;
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,fraction*BAR_WIDTH,BAR_HEIGHT);
			graphics.endFill();
			if (lifeSpan<=0) {
				target[attribute] -= strength;
			}
		}
		
		public function dead():Boolean {
			return lifeSpan<=0 ? true : false; 
		}

	}
	
}
