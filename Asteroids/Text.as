
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Text extends MovieClip{
		public var game:MovieClip;
		public var lifetime;
		
		public function Text(rt:MovieClip){
			gotoAndPlay(1);
			x=154;
			y=460;
			lifetime=50;
			
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
		}
		function drive(e:Event):void{
			lifetime--;
			if(lifetime==0){
				MovieClip(root).newLevel();
				removeEventListener(Event.ENTER_FRAME, drive);
				MovieClip(root).texts.splice(MovieClip(root).texts.indexOf(this),1);
				game.removeChild(this);
			}
		}
	}
}
