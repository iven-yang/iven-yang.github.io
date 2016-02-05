
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class tripleShot extends MovieClip{
		public var Angle:Number;
		public var game:MovieClip;
		public var mX:Number;
		public var mY:Number;

		public function tripleShot(rt:MovieClip){
			x=Math.random()*1250;
			y=1000;
			mX = Math.random()*1250;
			mY = 0;
			
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
			MovieClip(root).triples.push(this);
		}
		function drive(e:Event):void{
			Angle = Math.atan2((mX-x),(mY-y));
			
			x+=Math.sin(Angle)*5;
			y+=Math.cos(Angle)*5;
			
			if(y<=0)
				remover();
		}
		public function remover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			MovieClip(root).triples.splice(MovieClip(root).triples.indexOf(this),1);
			game.removeChild(this);
		}
	}
}
