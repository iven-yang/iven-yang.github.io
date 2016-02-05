package{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Missile extends MovieClip{
		public var game:MovieClip;
		var xv,yv;
		var i:int;
		
		public function Missile(r:MovieClip, xx:Number, yy:Number, xvel:Number, yvel:Number){
			x=xx;
			y=yy;
			xv=0.75*xvel;
			yv=yvel;
			
			game=r;
			
			game.addChild(this);
			MovieClip(root).missiles.push(this);
			addEventListener(Event.ENTER_FRAME, drive);
		}
		function drive(e:Event):void{
			if(y<=0){
				remover();
				return;
			}
			yv-=1;
			y+=yv;
			x+=xv;
			for(i = MovieClip(root).mutas.length-1; i>=0; i--){
				if(this.hitTestObject(MovieClip(root).mutas[i].hit)){
					MovieClip(root).mutas[i].remover(1);
					MovieClip(root).spawnExplosion(x,y,3);
					remover();
					return;
				}
			}
			for(i = MovieClip(root).interceptors.length-1; i>=0; i--){
				if(this.hitTestObject(MovieClip(root).interceptors[i].hit)){
					MovieClip(root).interceptors[i].remover(1);
					MovieClip(root).spawnExplosion(x,y,3);
					remover();
					return;
				}
			}
		}
		public function remover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).missiles.splice(MovieClip(root).missiles.indexOf(this),1);
			game.removeChild(this);
		}
	}
}
