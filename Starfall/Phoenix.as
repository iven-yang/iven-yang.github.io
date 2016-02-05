package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Phoenix extends MovieClip{
		public var game:MovieClip;
		public var mX, mY, Angle;
		public var vel;
		public var side: Boolean;
		public var down: Boolean;
		var Scounter:int;
		var counter:int;
		var HP:int;
		
		public function Phoenix(rt:MovieClip){
			x=250+750*Math.random();
			y=10;
			vel=7;
			counter=0;
			Scounter=0;
			HP=15;
			side=false;
			down=true;
			game=rt;
			addEventListener(Event.ENTER_FRAME, drive);
			game.addChild(this);
			MovieClip(root).mutas.push(this);
		}
		function drive(e:Event):void{
			Scounter++;
			
			mX = MovieClip(root).viking.x; 
			mY = MovieClip(root).viking.y;
			Angle = Math.atan2((mX-x), (mY-y));
			rotation = (-Angle/Math.PI*180)+35;
			
			if(Scounter%20==0)
				shoot(Angle);
			
			if(down){
				if(y<550)
					y+=7;
				counter++;
				if(counter==10){
					down=false;
					side=true;
					counter=0;
					vel=-vel;
				}
			}
			if(side){
				x+=vel;
				if(x>1000 || x<250){
					x-=vel;
					side=false;
					down=true;
				}
			}
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
				MovieClip(root).score+=5;
				MovieClip(root).scoreBox.text="Score: "+MovieClip(root).score;
				trueRemover();
			}
		}
		public function shoot(cc:Number):void{
			var laser:eBullet = new eBullet(MovieClip(root), x, y+35, 9, 15-Math.random()*30+360*((cc)/(2*Math.PI)), 2); 
		}
	}
}