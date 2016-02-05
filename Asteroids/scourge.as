
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class scourge extends MovieClip{
		public var Angle:Number;
		public var game:MovieClip;
		public var mX:Number;
		public var mY:Number;

		public function scourge(rt:MovieClip, xx:int, yy:int){
			x=xx;
			y=yy;
			
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
			MovieClip(root).scourges.push(this);
		}
		function drive(e:Event):void{
			mX = MovieClip(root).ship.x; 
			mY = MovieClip(root).ship.y;
			Angle = Math.atan2((mX-x),(mY-y));
			
			rotation = (-Angle/Math.PI*180)+35;
			
			x+=Math.sin(Angle)*6;
			y+=Math.cos(Angle)*6;
		}
		public function trueRemover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).scourges.splice(MovieClip(root).scourges.indexOf(this),1);
			game.removeChild(this);
		}
		function remover():void{
			MovieClip(root).score+=2;
			MovieClip(root).lifescore+=2;
			removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).scourges.splice(MovieClip(root).scourges.indexOf(this),1);
			game.removeChild(this);
		}
	}
}
