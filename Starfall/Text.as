
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Text extends MovieClip{
		public var game:MovieClip;
		public var lifetime;
		
		public function Text(rt:MovieClip){
			gotoAndPlay(1);
			x=625;
			y=400;
			lifetime=70;
			
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
