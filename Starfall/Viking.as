package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Viking extends MovieClip{
		public var v:Number;
		public var xv,yv;
		public var frame:int;
		public var missileTimer;int;
		public var bulletTimer;int;
		public var lives:int;
		public var deathTime:int;
		var deathlag:int;
		
		public var missilesOn:Boolean;
		
		public var leftD:Boolean;
		public var upD:Boolean;
		public var rightD:Boolean;
		public var downD:Boolean;
		public var zD:Boolean;//shoot
		public var spaceD:Boolean;//nuke
		public var dead:Boolean;
		public var shieldOn:Boolean;
		var shieldCount:Number;
		var shieldPressed:Boolean;
		var shieldTimer:Number;
		
		/*public var shields:int;
		public var shieldpower:int;
		public var shieldcharger:int;*/
		var i:int;
		
		public function Viking(){
			v=5;
			hit.visible=false;
			this.addEventListener(Event.ENTER_FRAME, drive);
			this.addEventListener(Event.ADDED_TO_STAGE, setUp);
		}
		function setUp(e:Event):void{
			stage.focus = stage;
			
			missileTimer=0;
			bulletTimer=0;
			MovieClip(root).shieldbar.gotoAndStop(100);
			missilesOn=true;
			//missilesOn=false;
			
			deathlag=1;
			deathTime=0;
			lives=5;
			frame=1;
			leftD=false;
			upD=false;
			rightD=false;
			downD=false;
			zD=false;
			spaceD=false;
			dead=false;
			
			shieldTimer=0;
			shieldOn=false;
			shieldPressed=false;
			shieldCount=0;
			shieldy.visible=false;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, released);
		}
		function pressed(ke:KeyboardEvent):void{
			if(ke.keyCode == 37)
				leftD=true;
			if(ke.keyCode == 38)
				upD=true;
			if(ke.keyCode == 39)
				rightD=true;
			if(ke.keyCode == 40)
				downD=true;
			if(ke.keyCode == 90)
				zD=true;
			if(ke.keyCode == 32)
				spaceD=true;
			if(ke.keyCode == 88)
				shieldPressed = true;
		}
		function released(ke:KeyboardEvent):void{
			if(ke.keyCode == 37)
				leftD=false;
			if(ke.keyCode == 38)
				upD=false;
			if(ke.keyCode == 39)
				rightD=false;
			if(ke.keyCode == 40)
				downD=false;
			if(ke.keyCode == 90)
				zD=false;
			if(ke.keyCode == 32)
				spaceD=false;
			if(ke.keyCode == 88)
				shieldPressed = false;	
		}
		function drive(e:Event):void{
			//Movement Stuff START
			if(dead){
				deathTime++;
				if(deathTime == 100){
					deathTime=0;
					dead = false;
					visible = true;
					x = 625;
					y = 900;
					MovieClip(root).healthbar.gotoAndStop(0);
				}
				return;
			}
			//Shield Stuff START
			if(shieldCount!=0){
				shieldCount--;
				MovieClip(root).shieldbar.gotoAndStop(100-int(shieldCount/4));
			}
			if(shieldCount==0 && shieldPressed && shieldTimer==0){
				shieldTimer=120;
				MovieClip(root).shieldbar.gotoAndStop(1);
				shieldy.visible=true;
				shieldOn=true;
			}
			else if(shieldTimer>0){
				shieldTimer--;
				if(shieldTimer==0){
					shieldCount=400;
					shieldy.visible = false;
					shieldOn=false;
				}
			}
			//Shield Stuff END
			frame=1;
			if(upD && !downD)
				frame=2;
			if(!(rightD && leftD)){
				if(rightD)
					frame=4;
				if(leftD)
					frame=3;
			}
			gotoAndStop(frame);
			xv=0;
			yv=0;
			if(leftD && x>24)
				xv=-v;
			if(upD && y>24)
				yv=-1.5*v;
			if(rightD && x<1226)
				xv=v;
			if(downD && y<910)
				yv=v;
			x+=xv;
			y+=yv;
			//Movement Stuff END
			
			//Shooting Stuff START
			if(zD){
				if(bulletTimer <= 0){
					bulletTimer=3;
					var mainShot:Bullet = new Bullet(MovieClip(root), x, y-30, xv, yv);
				}
				if(missilesOn && missileTimer <= 0){
					missileTimer=30;
					var mainMissile1:Missile = new Missile(MovieClip(root), x-16, y-30, xv, yv);
					var mainMissile2:Missile = new Missile(MovieClip(root), x+16, y-30, xv, yv);
				}
			}
			missileTimer--;
			bulletTimer--;
			//Shooting Stuff START
			
		}
		public function die():void{
			MovieClip(root).spawnExplosion(x,y,3);
			y=2500;
			visible=false;
			dead=true;
			lives--;
			if(lives<0){
				MovieClip(root).dd=0;
				MovieClip(root).suckBox.visible=true;
				MovieClip(root).scoreBox.visible=false;
				lives=0;
			}
			MovieClip(root).livesbar.gotoAndStop(lives+1);
			MovieClip(root).dmg(-10);
		}
		public function isDead():Boolean{
			return dead;
		}
		public function remover():void{
			this.removeEventListener(Event.ENTER_FRAME, drive);
			this.removeEventListener(Event.ADDED_TO_STAGE, setUp);
		}
	}
}
