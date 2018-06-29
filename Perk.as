package  {
	
	public class Perk {
		
		protected var type:String;
		protected var strength:Number;
		protected var attribute:String;
		protected var target:Object;
		protected var lifeSpan:int;
		
		public function Perk(tar:Object, s:Number=1, a:String="bonusShots", t:String="Multi SHot", l:int=100) {
			// constructor code
			type = t;
			strength = s;
			attribute = a;
			target = tar;
			lifeSpan = l;
			target[attribute] += strength;
		}
		
		public function update() {
			lifeSpan--;
			if (lifeSpan<=0) {
				target[attribute] -= strength;
			}
		}
		
		public function dead():Boolean {
			return lifeSpan<=0 ? true : false; 
		}

	}
	
}
