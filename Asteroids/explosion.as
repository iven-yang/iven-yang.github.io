
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class explosion extends MovieClip{
		public var game:MovieClip;
		public var lifetime;
		
		public function explosion(rt:MovieClip, xx:int, yy:int){
			gotoAndPlay(1);
			x=xx;
			y=yy;
			lifetime=11;
			
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
		}
		function drive(e:Event):void{
			lifetime--;
			if(lifetime==0){
				removeEventListener(Event.ENTER_FRAME, drive);
				game.removeChild(this);
			}
		}
	}
}
