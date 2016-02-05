
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class explosion extends MovieClip{
		public var game:MovieClip;
		public var lifetime;
		var i:int;
		var dmg:int;
		
		public function explosion(rt:MovieClip, xx:int, yy:int, dd:int){
			gotoAndPlay(1);
			x=xx;
			y=yy;
			dmg=dd;
			lifetime=12;
			
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
		}
		function drive(e:Event):void{
			lifetime--;
			if(lifetime==11){
				for(i = MovieClip(root).mutas.length-1; i>=0; i--){
					if(hit.hitTestObject(MovieClip(root).mutas[i].hit)){
						MovieClip(root).mutas[i].remover(dmg);
					}
				}
				for(i = MovieClip(root).interceptors.length-1; i>=0; i--){
					if(hit.hitTestObject(MovieClip(root).interceptors[i].hit)){
						MovieClip(root).interceptors[i].remover(dmg);
					}
				}
			}
			if(lifetime==0){
				removeEventListener(Event.ENTER_FRAME, drive);
				game.removeChild(this);
			}
		}
	}
}
