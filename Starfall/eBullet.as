package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class eBullet extends MovieClip{
		public var game:MovieClip;
		//var i:int;
		public var vel;
		public var Angle:Number;
		public var framer:int;
		
		public function eBullet(r:MovieClip, xx:Number, yy:Number, vv:int, aa:Number, fr:int){
			framer=fr;
			gotoAndStop(fr);
			
			x=xx;
			y=yy;
			vel=vv;
			Angle=aa*(Math.PI/180);
			game=r;
			
			game.addChild(this);
			MovieClip(root).ebullets.push(this);
			//addEventListener(Event.ENTER_FRAME, drive);
		}
		/*function drive(e:Event):void{
				x+=Math.sin(Angle)*vel;
				y+=Math.cos(Angle)*vel;
				
				if(framer!=4)
					rotation = (-Angle/Math.PI*180);
				
				if(y>910 || y<0 || x>1250 || x<0){
					remover();
					return;
				}
				if(hit.hitTestObject(MovieClip(root).viking.hit)){
					if(framer==1)
						MovieClip(root).dmg(1);
					else if(framer==2)
						MovieClip(root).dmg(3);
					else if(framer==3)
						MovieClip(root).dmg(10);
					else if(framer==4)
						MovieClip(root).dmg(1);
					remover();
					return;
				}
		}*/
		public function remover():void{
			//removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).ebullets.splice(MovieClip(root).ebullets.indexOf(this),1);
			game.removeChild(this);
			return;
		}
	}
}
