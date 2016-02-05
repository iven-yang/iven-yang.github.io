package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class eLaser extends MovieClip{
		public var game:MovieClip;
		var i:int;
		public var Angle:Number;
		public var counter:int;
		var damage:int;
		
		public function eLaser(r:MovieClip, xx:Number, yy:Number, aa:Number, fr:int){
			if(fr==1)
				damage=2;
			else
				damage=1;
			gotoAndStop(fr);
			x=xx;
			y=yy;
			Angle=aa*(Math.PI/180);
			rotation = (-Angle/Math.PI*180);
			game=r;
			counter=0;
			game.addChild(this);
			addEventListener(Event.ENTER_FRAME, drive);
		}
		function drive(e:Event):void{
			counter++;
			rotation = (-Angle/Math.PI*180);
			for(i = L.length-1; i>=0; i--){
				if(L[i].hitTestObject(MovieClip(root).viking.hit)){
					MovieClip(root).dmg(damage);
				}
			}
			if(counter==1){
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
