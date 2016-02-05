
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Carrier extends MovieClip{
		public var game:MovieClip;
		public var HP:int;
		public var counter:int;
		
		public function Carrier(rt:MovieClip, xx, yy){
			x=xx;
			y=yy;
			
			HP=100;
			counter=0;
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
			MovieClip(root).mutas.push(this);
		}
		function drive(e:Event):void{
			if(y<500)
				y++;
			counter++;
			if(counter%20==0)
				spawnInterceptor();
			if(hit.hitTestObject(MovieClip(root).viking.hit)){
				MovieClip(root).dmg(10);
				remover(10);
				return;
			}
		}
		public function trueRemover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).mutas.splice(MovieClip(root).mutas.indexOf(this),1);
			game.removeChild(this);
			return;
		}
		public function remover(d:int):void{
			HP-=d;
			if(HP<=0){
				MovieClip(root).score+=15;
				MovieClip(root).scoreBox.text="Score: "+MovieClip(root).score;
				trueRemover();
			}
		}
		public function spawnInterceptor():void{
			var Int:Interceptor = new Interceptor(MovieClip(root), x, y);
		}
	}
}
