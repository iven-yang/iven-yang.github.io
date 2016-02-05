package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip{
		public var game:MovieClip;
		//var i:int;
		public var xvv:Number;
		public var yvv:Number;
		
		public function Bullet(r:MovieClip, xx:Number, yy:Number, xvel:Number, yvel:Number){
			x=xx;
			y=yy;
			xvv=0.25*xvel;
			yvv=yvel;
			
			game=r;
			
			game.addChild(this);
			MovieClip(root).bullets.push(this);
			//addEventListener(Event.ENTER_FRAME, drive);
		}
		/*function drive(e:Event):void{
			y+=yvv-10;
			x+=xvv;
			if(y<0){
				remover();
				return;
			}
			for(i = MovieClip(root).mutas.length-1; i>=0; i--){
				if(hit.hitTestObject(MovieClip(root).mutas[i].hit)){
					MovieClip(root).mutas[i].remover(1);
					remover();
					return;
				}
			}
			for(i = MovieClip(root).interceptors.length-1; i>=0; i--){
				if(hit.hitTestObject(MovieClip(root).interceptors[i].hit)){
					MovieClip(root).interceptors[i].remover(1);
					remover();
					return;
				}
			}
		}*/
		public function remover():void{
			//removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).bullets.splice(MovieClip(root).bullets.indexOf(this),1);
			game.removeChild(this);
			return;
		}
	}
}
