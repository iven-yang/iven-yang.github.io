
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class rock extends MovieClip{
		public var Angle:Number;
		public var game:MovieClip;
		public var Frame:int;
		public var HP:int;
		
		public function rock(hitpts:int, frm:int, xx:Number, yy:Number, rt:MovieClip){
			x=xx;
			y=yy;
			
			HP=hitpts;
			
			Frame=frm;
			gotoAndStop(Frame);
			
			addEventListener(Event.ENTER_FRAME, drive);
			Angle=Math.PI*Math.random();

			game=rt;
			game.addChild(this);
			MovieClip(root).rocks.push(this);
		}

		function drive(e:Event):void{
			if(Frame==1){
				x+=Math.sin(Angle)*1.5;
				y+=Math.cos(Angle)*1.5;
			}
			if(Frame==2){
				x+=Math.sin(Angle)*5;
				y+=Math.cos(Angle)*5;
			}
			if(Frame==3){
				x+=Math.sin(Angle)*2;
				y+=Math.cos(Angle)*2;
			}
			if(Frame==4){
				x+=Math.sin(Angle)*6;
				y+=Math.cos(Angle)*6;
			}
			if(Frame==5){
				x+=Math.sin(Angle)*11;
				y+=Math.cos(Angle)*11;
			}
			if(x>1250)
				x=0;
			if(x<0)
				x=1250;
			if(y>1000)
				y=0;
			if(y<0)
				y=1000;
		}
		public function trueRemover():void{
			removeEventListener(Event.ENTER_FRAME, drive);
			removeEventListener(Event.ENTER_FRAME, driver);
			MovieClip(root).rocks.splice(MovieClip(root).rocks.indexOf(this),1);
			game.removeChild(this);
		}
		function remover():void{
			HP--;
			if(HP==20){
				Frame=2;
				MovieClip(root).spawnScourge(x+150,y+150);
				//MovieClip(root).spawnScourge(x+150,y-150);
				//MovieClip(root).spawnScourge(x-150,y+150);
				MovieClip(root).spawnScourge(x-150,y-150);
				MovieClip(root).spawnScourge(x+200,y-200);
				MovieClip(root).spawnScourge(x+200,y+200);
				MovieClip(root).spawnScourge(x-200,y+200);
				MovieClip(root).spawnScourge(x-200,y-200);
				MovieClip(root).spawnScourge(x+250,y+250);
				MovieClip(root).spawnScourge(x+250,y-250);
				MovieClip(root).spawnScourge(x-250,y+250);
				MovieClip(root).spawnScourge(x-250,y-250);
				MovieClip(root).spawnScourge(x,y);
				MovieClip(root).spawnRock(20,2,x+100,y+100);
				MovieClip(root).spawnRock(20,2,x-100,y-100);
				MovieClip(root).spawnRock(20,2,x+150,y-150);
				gotoAndStop(Frame);
			}
			if(HP==9){
				MovieClip(root).lifescore+=50;
				MovieClip(root).score+=50;
				Frame=3;
				MovieClip(root).spawnRock(9,3,x,y);
				gotoAndStop(Frame);
			}
			if(HP==3){
				MovieClip(root).lifescore+=5;
				MovieClip(root).score+=5;
				Frame=4;
				MovieClip(root).spawnRock(3,4,x,y);
				gotoAndStop(Frame);
			}
			if(HP==1){
				MovieClip(root).lifescore+=2;
				MovieClip(root).score+=2;
				Frame=5;
				MovieClip(root).spawnRock(1,5,x,y);
				gotoAndStop(Frame);
			}
			if(HP==0){
				MovieClip(root).lifescore++;
				MovieClip(root).score++;
				trueRemover();
			}
		}
	}
}
