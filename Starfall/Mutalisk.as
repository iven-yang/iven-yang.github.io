
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Mutalisk extends MovieClip{
		public var game:MovieClip;
		public var mX:int;
		public var mY:int;
		public var HP:int;
		public var vel:int;
		public var down:Boolean;
		public var side:Boolean;
		public var counter:int;
		
		public function Mutalisk(rt:MovieClip, xx, yy){
			x=xx;
			y=yy;
			
			HP=5;
			vel=-2;
			down=true;
			side=false;
			counter=0;
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
			MovieClip(root).mutas.push(this);
		}
		function drive(e:Event):void{
			if(Math.random()*1000 > 990){
				shoot();
			}
			if(down){
				if(y<550)
					y+=2;
				counter++;
				if(counter==30){
					down=false;
					side=true;
					counter=0;
					vel=-vel;
				}
			}
			if(side){
				x+=vel;
				counter++;
				if(counter==80){
					side=false;
					down=true;
					counter=0;
				}
			}
			if(hit.hitTestObject(MovieClip(root).viking.hit)){
				MovieClip(root).dmg(5);
				remover(5);
				return;
			}
		}
		public function shoot():void{
			var glaiveWurm:eBullet = new eBullet(MovieClip(root), x, y, 5, 15-30*Math.random(), 1);
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
				MovieClip(root).score+=2;
				MovieClip(root).scoreBox.text="Score: "+MovieClip(root).score;
				trueRemover();
				return;
			}
		}
	}
}
