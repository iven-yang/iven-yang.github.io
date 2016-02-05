
package{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	
	public class spaceship extends MovieClip{
		public var vx:Number;
		public var vy:Number;
		public var maxSpd:Number;
		public var ax:Number;
		public var ay:Number;
		public var Angle:Number;
		
		public var shields:int;
		public var shieldpower:int;
		public var shieldcharger:int;
		public var i:int;
		
		public var boostpower:int;
		public var boostcooldown:int;
		public var TerrorPower:int;
		public var deathTime:int;
		public var boostangle:Number;
		public var TSM:int;//triple shot time		

		public var mD:Boolean;//mouse
		public var zD:Boolean;//shooting
		public var xD:Boolean;//shields
		public var cD:Boolean;//Technological Terror Boost
		public var spaceD:Boolean;//boost
		public var tripleShot:Boolean;//triple shot upgrade on?
		public var isDead:Boolean;//am i dead
		
		public var TerrorOn:Boolean;//In Tech Terror Mode?
		public var shieldson:Boolean;//Are shields on?
		public var shieldsV:Boolean;//idk what this is for
		public var boosting:Boolean;//Is currently boosting?
		
		public function spaceship(vel:Number=0, ms:Number=14, acc:Number=0.7) {
			vx=vel;
			vy=vel;
			maxSpd=ms;
			ax=acc;
			ay=acc;
			mD=false;
			this.addEventListener(Event.ENTER_FRAME, drive);
			this.addEventListener(Event.ADDED_TO_STAGE, setUp);
		}
		function setUp(e:Event):void{
			stage.focus = stage;
			hit.visible = false;
			hitS.visible = false;
			shields = 3;
			shieldpower = 72;
			TSM=240;
			deathTime = 0;
			shieldcharger = 0;
			boostcooldown = 0;
			tripleShot=false;
			shieldson = false;
			shieldsV = false;
			boosting = false;
			TerrorOn = false;
			boostpower = 8;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseD);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseU);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, released);
		}
		function mouseD(e:MouseEvent):void{
			mD=true;
		}
		function mouseU(e:MouseEvent):void{
			mD=false;
		}
		function pressed(ke:KeyboardEvent):void{
			if(ke.keyCode == 90)
				zD=true;
			if(ke.keyCode == 88)
				xD=true;
			if(ke.keyCode == 67)
				cD=true;
			if(ke.keyCode == 32)
				spaceD=true;
		}
		function released(ke:KeyboardEvent):void{
			if(ke.keyCode == 90)
				zD=false;
			if(ke.keyCode == 88)
				xD=false;
			if(ke.keyCode == 67)
				cD=false;
			if(ke.keyCode == 32)
				spaceD=false;
		}
		public function remover():void{
			this.removeEventListener(Event.ENTER_FRAME, drive);
			this.removeEventListener(Event.ADDED_TO_STAGE, setUp);
		}
		function drive(e:Event):void{
			//Death START
			if(isDead){
				deathTime++;
				if(deathTime == 50){
					if(MovieClip(root).lives==0){
						MovieClip(root).End();
					}
					isDead = false;
					visible = true;
					x = 625;
					y = 500;
					vx = 0;
					vy = 0;
					shieldson=true;
					shieldsV=true;
					shieldpower=72;
				}
			}
		else{
			if(!shieldson){
				for(i = MovieClip(root).rocks.length-1; i>=0; i--){
					if(hitS.hitTestObject(MovieClip(root).rocks[i].hit)){
						MovieClip(root).rocks[i].remover();
						isDead=true;
						visible=false;
						deathTime=0;
						MovieClip(root).lives--;
						if(MovieClip(root).lives!=0)
							MovieClip(root).lifeBar.gotoAndStop(MovieClip(root).lives);
						MovieClip(root).spawnShipExplosion(x,y);
						return;
					}
				}
				for(i = MovieClip(root).scourges.length-1; i>=0; i--){
					if(hitS.hitTestObject(MovieClip(root).scourges[i].hit)){
						MovieClip(root).scourges[i].remover();
						isDead=true;
						visible=false;
						deathTime=0;
						MovieClip(root).lives--;
						if(MovieClip(root).lives!=0)
							MovieClip(root).lifeBar.gotoAndStop(MovieClip(root).lives);
						MovieClip(root).spawnShipExplosion(x,y);
						return;
					}
				}
			}
			//Death END
			
			//Mouse Movement START
			var mX = MovieClip(root).mouseX; 
			var mY = MovieClip(root).mouseY;
			var vvx;
			var vvy;
			Angle = Math.atan2((mX-x),(mY-y));
			arrow.rotation = (-Angle/Math.PI*180)+90;
			if(mD){
				vvx=vx;
				vvy=vy;
				vx+=Math.sin(Angle)*ax;
				vy+=Math.cos(Angle)*ay;
			}
			if(vx*vx+vy*vy > maxSpd*maxSpd){
				vx=vvx;
				vy=vvy;
			}
			x+=vx;
			y+=vy;
			if(x>1250)
				x=0;
			if(x<0)
				x=1250;
			if(y>1000)
				y=0;
			if(y<0)
				y=1000;
			//Mouse Movement END
			
			//Boost START
			if(spaceD && !boosting && boostcooldown == 0){
				boostcooldown = 50;
				boostangle = Angle;
				boosting = true;
				boostpower = 8;
			}
			if(boosting && boostpower>0){
				vx=0;
				vy=0;
				x+=Math.sin(boostangle)*35;
				y+=Math.cos(boostangle)*35;
				boostpower--;
			}
			if(boostpower==0 && boosting){
				boosting = false;
				vx=Math.sin(boostangle)*5*ax;
				vy=Math.cos(boostangle)*5*ay;
			}
			if(boostcooldown!=0)
				boostcooldown--;
			//Boost END
			
			//Shields START
			shieldcharger++;
			if(shieldcharger == 480 && shields<5){
				shields++;
				MovieClip(root).shieldsbar.gotoAndPlay(shields);
				shieldcharger = 0;
			}
			if(shieldcharger>480){
				shieldcharger-=120;
			}
			if(xD && shields>0 && !shieldson){
				shieldson = true;
				shieldsV = true;
				shields--;
				MovieClip(root).shieldsbar.gotoAndPlay(shields);
				shieldpower=72;
			}
			if(shieldson && shieldpower>0){
				shieldpower--;
				for(i = MovieClip(root).scourges.length-1; i>=0; i--){
					if(hit.hitTestObject(MovieClip(root).scourges[i].hit)){
						MovieClip(root).scourges[i].remover();
					}
				}
				for(i = MovieClip(root).rocks.length-1; i>=0; i--){
					if(hit.hitTestObject(MovieClip(root).rocks[i].hit)){
						MovieClip(root).rocks[i].remover();
					}
				}
			}
			if(shieldpower==0){
				shieldson = false;
				shieldsV = false;
			}
			//Shields END
			
			//Technological Terror START
			if(cD){
				if(!TerrorOn){
					if(MovieClip(root).TDrive.ready){
						TerrorOn=true;
						TerrorPower=240;
						MovieClip(root).TDrive.gotoAndStop(481);
					}
				}
			}
			if(TerrorOn){
				TerrorPower--;
				if(TerrorPower==0){
					TerrorOn=false;
					MovieClip(root).TDrive.gotoAndPlay(1);
				}
			}
			//Technological Terror END
			
			//Triple shot START
			
			for(i = MovieClip(root).triples.length-1; i>=0; i--){
				if(hit.hitTestObject(MovieClip(root).triples[i])){
					MovieClip(root).triples[i].remover();
					tripleShot=true;
					TSM=240;
				}
			}
			if(tripleShot){
				TSM--;
				if(TSM==0)
					tripleShot=false;
			}
			
			//Triple shot END

			//Shooting START
			if(zD){
				if(tripleShot){
					var runaansHurricane1:missile = new missile(MovieClip(root), Angle+0.1, x, y, TerrorOn);
					var runaansHurricane2:missile = new missile(MovieClip(root), Angle-0.1, x, y, TerrorOn);
				}
				var mainMissile:missile = new missile(MovieClip(root), Angle, x, y, TerrorOn);
			}
			//Shooting END
		}
		}
	}
}
