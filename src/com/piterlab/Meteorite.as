package com.piterlab {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Meteorite extends Entity {
		
		private var _delay:Number;
		private var angle:Number;
		private var distance:Number;
		private var velocity:Number;
		private var _color:uint;
		
		public function Meteorite() {
			distance = Math.max(FP.halfWidth, FP.halfHeight) + FP.random * 30;
			angle = FP.random * 360 * FP.RAD;
			velocity = 1 + 1.5 * FP.random;
			
			var img:BitmapData;
			var aleatory:Number = FP.random;
			if (aleatory < 0.33) {
				_color = 0;
				img = SpaceWorld.circleR;
			} else if (aleatory < 0.66) {
				_color = 1;
				img = SpaceWorld.circleG;
			} else {
				_color = 2;
				img = SpaceWorld.circleB;
			}
			var s:Image = new Image(img);
			s.centerOrigin();
			addGraphic(s);
			x = -20;
			y = -20;
		}
		
		override public function update():void {
			delay -= FP.elapsed;
			if (delay > 0)
				return;
			else
				delay = 0;
			
			distance -= velocity;
			if (distance > 0) {
				//velocity += 0.5;
				x = FP.halfWidth + Math.cos(angle) * distance;
				y = FP.halfHeight + Math.sin(angle) * distance;
			} else {
				distance = 0;
			}
			
			// Collision detection
			// with Shield
			var dx:Number = SpaceWorld.shield.x - x;
			var dy:Number = SpaceWorld.shield.y - y;
			var d:Number = dx * dx + dy * dy;
			
			if (d < 225) { //15*15
				visible = false;
				SpaceWorld.explodeMeteoro(this);
				SpaceWorld.removeMeteoro(this);
				SpaceWorld.score.points += 10;
				Assets.getSound("ShieldFx").play();
			}
			
			// with TinyWorld
			dx = SpaceWorld.world.x - x;
			dy = SpaceWorld.world.y - y;
			d = dx * dx + dy * dy;
			
			if (d < SpaceWorld.world.radius * SpaceWorld.world.radius) { //30*30
				visible = false;
				
				if (SpaceWorld.world.color == _color) {
					SpaceWorld.world.radius += 1;
					SpaceWorld.removeMeteoro(this);
					SpaceWorld.score.points += 30;
					Assets.getSound("ShootFx").play();
					
					var score:Score = SpaceWorld.getScoreForColor(_color);
					if (score.points == 0) {
						SpaceWorld.getScoreForColor(0).points--;
						SpaceWorld.getScoreForColor(1).points--;
						SpaceWorld.getScoreForColor(2).points--;
					} else
						score.points--;
				} else {
					//SpaceWorld.getScoreForColor(SpaceWorld.world.color).points++;
					SpaceWorld.world.changeColor(_color);
					SpaceWorld.explodeMeteoro(this);
					SpaceWorld.removeMeteoro(this);
					SpaceWorld.world.radius -= 3;
					Assets.getSound("ExplosionFx").play();
				}
			}
		
		}
		
		//override public function render():void {
		//trace(x, y);
		//Draw.circlePlus(x, y, 15, 0xffff0000, 1, true);
		//}
		
		public function get delay():Number {
			return _delay;
		}
		
		public function set delay(value:Number):void {
			_delay = value;
		}
		
		public function get color():uint {
			return _color;
		}
	
	}

}