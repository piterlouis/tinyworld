package com.piterlab {
	import flash.display.BitmapData;
	import flash.display.Sprite;
    import net.flashpunk.Engine;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class SpaceWorld extends World {
		
        private static const TIME_RESPAWN:Number = 2.5;
        private static const NUM_RESPAWN:uint = 0;
        
        private static var timeRespawn:Number;
        private static var numRespawn:uint;
        
		static private var _circleR:BitmapData;
		static private var _circleG:BitmapData;
		static private var _circleB:BitmapData;
		
		static private var _particleR:BitmapData;
		static private var _particleG:BitmapData;
		static private var _particleB:BitmapData;
		static private var _particleW:BitmapData;
		
		static private var meteorites:Vector.<Meteorite>;
		static public var shield:Shield;
		static public var world:TinyWorld;
		
		static public var score:Score;
		static public var scoreR:Score;
		static public var scoreG:Score;
		static public var scoreB:Score;
		
		static public var gameOver:Entity;
		static public var pressSpace:Entity;
		
		static public var isGameOver:Boolean;
		
		private var time:Number;
        
        static public var level:uint;
        
        static public var eLevel:Entity;
		
		public function SpaceWorld() {
			
			isGameOver = false;
            
			level = 0;
            timeRespawn = TIME_RESPAWN;
            numRespawn = NUM_RESPAWN;
            
			time = 0;
			
			world = new TinyWorld();
			add(world);
			
			shield = new Shield();
			add(shield);
			
			meteorites = new Vector.<Meteorite>();
			
			score = new Score(40);
			score.x = 10;
			score.y = 10;
			add(score);
			
			var base:uint = 600;
			scoreR = new Score(20, 0xffffffff, 0);
			scoreR.x = base;
			scoreR.y = 370;
			add(scoreR);
			
			scoreG = new Score(20, 0xffffffff, 1);
			scoreG.x = base + 70;
			scoreG.y = 370;
			add(scoreG);
			
			scoreB = new Score(20, 0xffffffff, 2);
			scoreB.x = base + 140;
			scoreB.y = 370;
			add(scoreB);
            
            winLevel();
		}
		
		override public function update():void {
            if (isGameOver) return;

            if (scoreB.points + scoreG.points + scoreR.points == 0) {
                winLevel();
            }

			time += FP.elapsed;
			if (time > TIME_RESPAWN) {
				time = 0;
                var maxi:uint = 1 + (FP.random * numRespawn);
				for (var i:uint = 0; i < maxi; i++) {
					var meteoro:Meteorite = new Meteorite();
					meteoro.delay = FP.random * 3;
					meteorites.push(meteoro);
					add(meteoro);
				}
			}
            if (eLevel) {
                (eLevel.graphic as Text).alpha -= 0.01;
                if ((eLevel.graphic as Text).alpha == 0) {
                    this.remove(eLevel);
                }
            }
            super.update();
		}
        		
		static public function explodeMeteoro(meteoro:Meteorite):void {
			var e:Explosion = new Explosion(meteoro.color);
			FP.world.add(e);
			e.explode(meteoro.x, meteoro.y);
		}
		
		static public function removeMeteoro(meteoro:Meteorite):void {
			FP.world.remove(meteoro);
			meteorites.splice(meteorites.indexOf(meteoro), 1);
		}
		
        public function winLevel():void {
            var meteo:Meteorite = meteorites.pop();
			while (meteo) {
				explodeMeteoro(meteo);
				FP.world.remove(meteo);
				meteo = meteorites.pop();
			}

            level ++;
            //timeRespawn = TIME_RESPAWN -level;
            numRespawn = NUM_RESPAWN + level;
            scoreR.points = level * 3;
            scoreG.points = level * 3;
            scoreB.points = level * 3;
            if (world.radius < 25)
                world.radius = 25;
            
            var txtLevel:Text = new Text("LEVEL " + level, 0, 0, { size:40 } );
            txtLevel.centerOrigin();
            eLevel = new Entity(FP.halfWidth, FP.halfHeight -100, txtLevel);
            this.add(eLevel);
        }
        
		static public function endGame():void {
			var meteo:Meteorite = meteorites.pop();
			while (meteo) {
				explodeMeteoro(meteo);
				FP.world.remove(meteo);
				meteo = meteorites.pop();
			}
			var e:Explosion = new Explosion(3);
			FP.world.add(e);
			e.explode(shield.x, shield.y);
			FP.world.remove(shield);
			FP.world.remove(scoreR);
			FP.world.remove(scoreG);
			FP.world.remove(scoreB);
			
			var t:Text = new Text("Game Over", 0, 0, {size: 60});
			t.centerOrigin();
			gameOver = new Entity(FP.halfWidth, FP.halfHeight - 30, t);
			FP.world.add(gameOver);
			
			t = new Text("- PRESS SPACEBAR -", 0, 0, {size: 18});
			t.centerOrigin();
			pressSpace = new Entity(FP.halfWidth, FP.halfHeight + 30, t);
			FP.world.add(pressSpace);
			
			isGameOver = true;
		}
		
		static private function drawCircle(color:uint):BitmapData {
			var b:Sprite = new Sprite();
			b.graphics.lineStyle(1, color);
			b.graphics.beginFill(color);
			b.graphics.drawCircle(7, 7, 5);
			b.graphics.endFill();
			var c:BitmapData = new BitmapData(b.width + 2, b.height + 2, true, 0x00000000);
			c.draw(b);
			return c;
		}
		
		static public function get circleR():BitmapData {
			if (!_circleR) {
				_circleR = drawCircle(0xffff0000);
			}
			return _circleR;
		}
		
		static public function get circleG():BitmapData {
			if (!_circleG) {
				_circleG = drawCircle(0xff00ff00);
			}
			return _circleG;
		}
		
		static public function get circleB():BitmapData {
			if (!_circleB) {
				_circleB = drawCircle(0xff0000ff);
			}
			return _circleB;
		}
		
		static public function get particleR():BitmapData {
			if (!_particleR) {
				_particleR = new BitmapData(3, 3, false, 0x80FF0000);
			}
			return _particleR;
		}
		
		static public function get particleG():BitmapData {
			if (!_particleG) {
				_particleG = new BitmapData(3, 3, false, 0x8000FF00);
			}
			return _particleG;
		}
		
		static public function get particleB():BitmapData {
			if (!_particleB) {
				_particleB = new BitmapData(3, 3, false, 0x800000FF);
			}
			return _particleB;
		}
		
		static public function get particleW():BitmapData {
			if (!_particleW) {
				_particleW = new BitmapData(3, 3, false, 0xffffffff);
			}
			return _particleW;
		}
		
		static public function getScoreForColor(icolor:uint):Score {
			var ic:Score = null;
			if (icolor == 0)
				ic = scoreR;
			else if (icolor == 1)
				ic = scoreG;
			else if (icolor == 2)
				ic = scoreB;
			else if (icolor == 3)
				ic = score;
			
			return ic;
		}
	}

}