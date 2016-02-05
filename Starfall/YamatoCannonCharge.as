package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class YamatoCannonCharge extends MovieClip{
		public var game:MovieClip;
		public var power:int;
		public function YamatoCannonCharge(r:MovieClip, xx:Number, yy:Number){
			x=xx;
			y=yy+100;
			power=49;
			game=r;
			
			game.addChild(this);
			addEventListener(Event.ENTER_FRAME, drive);
		}
		public function drive(e:Event):void{
			power--;
			if(y<701)
				y++;
			if(power==0){
				remover();
				return;
			}
		}
		public function remover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			game.removeChild(this);
			return;
		}
	}
}
