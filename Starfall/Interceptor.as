
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Interceptor extends MovieClip{
		public var Angle:Number;
		public var tmpAngle:Number;
		public var game:MovieClip;
		public var power:int;
		public var HP:int;
		public var aVel:Number;
		public var tmpaVel:Number;

		public function Interceptor(rt:MovieClip, xx:int, yy:int){
			x=xx;
			y=yy;
			power=850;
			HP=3;
			
			//addEventListener(Event.ENTER_FRAME, drive);
			Angle = 2*Math.random()*Math.PI;
			x+=Math.sin(Angle)*40;
			y+=Math.cos(Angle)*40;
			tmpAngle=0;
			game=rt;
			tmpaVel=(0.01+0.02*Math.random())*(Math.pow( -1,int(2*Math.random())) );
			aVel=0;
			game.addChild(this);
			MovieClip(root).interceptors.push(this);
		}
		/*function drive(e:Event):void{
			power--;
			tmpAngle = Math.atan2((MovieClip(root).viking.x-x),(MovieClip(root).viking.y-y));
			
			aVel=tmpaVel-Math.abs((Angle-tmpAngle)/1000);
			
			Angle+=aVel;
			
			rotation = (-Angle/Math.PI*180)+35;
			
			x+=Math.sin(Angle)*4;
			y+=Math.cos(Angle)*4;
			if(power==0){
				trueRemover();
				return;
			}
			if(hit.hitTestObject(MovieClip(root).viking.hit)){
				MovieClip(root).dmg(3);
				remover(3);
				return;
			}
		}*/
		public function trueRemover():void{
			//removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).interceptors.splice(MovieClip(root).interceptors.indexOf(this),1);
			game.removeChild(this);
			return;
		}
		public function remover(d:int):void{
			HP-=d;
			if(HP<=0){
				MovieClip(root).score+=1;
				MovieClip(root).scoreBox.text="Score: "+MovieClip(root).score;
				trueRemover();
			}
		}
	}
}
