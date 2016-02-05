
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	
	public class missile extends MovieClip{
		public var Angle:Number;
		public var power:int;
		public var game:MovieClip;
		public var Terror:Boolean;
		
		public function missile(r:MovieClip, ang:Number, xx:Number, yy:Number, T:Boolean){
			Angle = ang;
			
			x=xx;
			y=yy;
			
			rotation = (-Angle/Math.PI*180)+90;
			Terror=T;
			
			if(T)
				gotoAndStop(2);
			else
				gotoAndStop(1);

			x+=Math.sin(Angle)*20;
			y+=Math.cos(Angle)*20;
			power=50;
			
			game=r;
			
			game.addChild(this);
			MovieClip(root).bullets.push(this);
			addEventListener(Event.ENTER_FRAME, drive);
		}

		function drive(e:Event):void{
			power--;
			if(!Terror){
				x+=Math.sin(Angle)*30;
				y+=Math.cos(Angle)*30;
			}
			else{
				x+=Math.sin(Angle)*45;
				y+=Math.cos(Angle)*45;
			}
			for(var i:int = MovieClip(root).rocks.length-1; i>=0; i--){
				if(MovieClip(root).rocks[i].Cframe==1){
					if( hit.hitTestObject(MovieClip(root).rocks[i].hit) ||
						hit.hitTestObject(MovieClip(root).rocks[i].hit2) ||
						hit.hitTestObject(MovieClip(root).rocks[i].hit3) ||
						hit.hitTestObject(MovieClip(root).rocks[i].hit4) ||
						hit.hitTestObject(MovieClip(root).rocks[i].hit5) ||
						hit.hitTestObject(MovieClip(root).rocks[i].hit6) ){
						MovieClip(root).rocks[i].remover();
						if(!Terror){
							MovieClip(root).spawnExplosion(x,y);
							remover();
						}
						return;
					}
				}
				else{
					if(hit.hitTestObject(MovieClip(root).rocks[i].hit)){
						MovieClip(root).rocks[i].remover();
						if(!Terror){
							MovieClip(root).spawnExplosion(x,y);
							remover();
						}
						return;
					}
				}
			}
			for(i = MovieClip(root).scourges.length-1; i>=0; i--){
				if(hit.hitTestObject(MovieClip(root).scourges[i].hit)){
					MovieClip(root).scourges[i].remover();
					if(!Terror){
						MovieClip(root).spawnExplosion(x,y);
						remover();
					}
					return;
				}
			}
			if(power==0){
				remover();
				return;
			}
		}
		
		public function remover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).bullets.splice(MovieClip(root).bullets.indexOf(this),1);
			game.removeChild(this);
		}
	}
}
