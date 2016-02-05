
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Mokou extends MovieClip{
		public var game:MovieClip;
		public var HP:int;
		var counter:int;
		var charge:int;
		var pattern:int;
		var oldP:int;
		var patternT:int;
		
		var down:Boolean;
		var side:Boolean;
		var mCounter:int;
		var vel:Number;
		var vel2:Number;
		
		public function Mokou(rt:MovieClip, xx, yy){
			x=xx;
			y=yy;
			
			HP=500;
			counter=0;
			pattern=1;
			patternT=-1;
			charge=0;
			vel=3.5;//dx
			vel2=3.5;//dy
			mCounter=0;
			
			MokouM.phoenixB.visible=false;
			MokouM.x=625;
			hit.x=625;//480
			MokouM.y=0;//400
			hit.y=0;
			heal.visible=false;
			
			down=false;
			side=true;
			
			addEventListener(Event.ENTER_FRAME, drive);
			
			game=rt;
			game.addChild(this);
			MovieClip(root).mutas.push(this);
		}
		function drive(e:Event):void{
			//trace(""+hit.x+", "+hit.y);
			counter++;
			if(counter<=200){
				HP=500;
				MokouB.gotoAndStop(501-int(counter*2.5));
				if(hit.y<=300){
					MokouM.y+=2;
					hit.y+=2;
				}
				else{
					MokouM.x-=3;
					hit.x-=3;
				}
			}
			else{
				MokouB.gotoAndStop(501-HP);
				if(down){
					MokouM.y+=vel2;
					hit.y+=vel2;
					mCounter++;
					if(mCounter==50){
						down=false;
						side=true;
						mCounter=0;
						vel2=-vel2;
					}
				}
				if(side){
					MokouM.x+=vel;
					hit.x+=vel;
					mCounter++;
					if(mCounter==100){
						side=false;
						down=true;
						mCounter=0;
						vel=-vel;
					}
				}
				
				patternT++;
				if(patternT%300==0){
					while(pattern==oldP){
						pattern=int(Math.random()*5+1);
					}
					MokouM.phoenix.visible=true;
					MokouM.phoenixB.visible=false;
					if(pattern!=5){
						heal.visible=false;
						if(pattern==1){
							vel=3.5;
							vel2=3.5;
						}
						else if(pattern==2){
							vel=2.25;
							vel2=2.25;
						}
						else if(pattern==3){
							vel=1.5;
							vel2=1.5;
						}
						else if(pattern==4){
							vel=0.25;
							vel2=0.25;
						}
					}
					else{
						heal.visible=true;
						vel=1;
						vel2=1;
						MokouM.phoenixB.visible=true;
						MokouM.phoenix.visible=false;
					}
					oldP=pattern;
				}
				if(pattern==1){
					if(counter%4==0){
						shoot(counter*3.7);
						shoot(counter*3.7+120)
						shoot(counter*3.7+240)
					}
				}
				else if(pattern==2){
					if(counter%3==0){
						shoot(counter*3.3);
						shoot(counter*3.3+180)
					}
				}
				else if(pattern==3){
					if(counter%2==0)
						shoot(counter*2.8);
				}
				else if(pattern==4){
					laser(counter/1.5);
					laser(counter/1.5+120);
					laser(counter/1.5+240);
					if(counter%8==0){
						shoot(-counter*1.7);
						shoot(-counter*1.7+120);
						shoot(-counter*1.7+240);
					}
				}
				else if(pattern==5){
					if(counter%12==0){
						shoot(counter*3.9);
						shoot(counter*3.9+72);
						shoot(counter*3.9+144);
						shoot(counter*3.9+217)
						shoot(counter*3.9+288)
					}
					if(counter%3==0){
						if(HP<500)
							HP++;
					}
				}
			}
			if(hit.hitTestObject(MovieClip(root).viking.hit)){
				MovieClip(root).dmg(10);
				remover(10);
				return;
			}
		}
		public function shoot(cc):void{
			var plasmaBullet:eBullet = new eBullet(MovieClip(root), hit.x+Math.sin(cc*Math.PI/180)*30, hit.y+Math.cos(cc*Math.PI/180)*30, 8, cc, 4);
		}
		public function laser(cd):void{
			var MoonLight:eLaser = new eLaser(MovieClip(root), hit.x+Math.sin(cd*Math.PI/180)*30, hit.y+Math.cos(cd*Math.PI/180)*30, cd, 2);
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
				MovieClip(root).score+=100;
				MovieClip(root).scoreBox.text="Score: "+MovieClip(root).score;
				trueRemover();
			}
		}
	}
}
