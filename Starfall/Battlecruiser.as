
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Battlecruiser extends MovieClip{
		public var game:MovieClip;
		public var HP:int;
		public var counter:int;
		public var Yamato:Boolean;
		public var charge:int;
		
		public function Battlecruiser(rt:MovieClip, xx, yy){
			x=xx;
			y=yy;
			
			HP=126;
			counter=0;
			charge=0;
			Yamato=false;
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
			MovieClip(root).mutas.push(this);
		}
		function drive(e:Event):void{
			counter++;
			if(y<600)
				y++;
			if(Math.random()*500 > 496 && !Yamato){
				Yamato=true;
				YCharge();
			}
			else if(Yamato){
				charge++;
				if(charge==43)
					YamatoCannon();
				if(charge==60){
					Yamato=false;
					charge=0;
				}
			}
			if(counter%20==0)
				shoot(x+68,y+15);
			else if(counter%10==0)
				shoot(x-68,y+15);
			if(hit.hitTestObject(MovieClip(root).viking.hit)){
				MovieClip(root).dmg(10);
				remover(10);
				return;
			}
		}
		public function shoot(xs, ys):void{
			var plasmaBullet:eBullet = new eBullet(MovieClip(root), xs, ys, 8, 6-12*Math.random(), 2);
		}
		public function YCharge():void{
			var charging:YamatoCannonCharge = new YamatoCannonCharge(MovieClip(root), x, y);
		}
		public function YamatoCannon():void{
			var plasmaBullet:eBullet = new eBullet(MovieClip(root), x, y+100, 20, 2-4*Math.random(), 3);
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
				MovieClip(root).score+=20;
				MovieClip(root).scoreBox.text="Score: "+MovieClip(root).score;
				trueRemover();
			}
		}
	}
}
