package com.piterlab {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Shield extends Entity {
		
		private var angle:Number;
		private var time:Number;
		private var velocity:Number;
		private var _distance:Number;
		private var direction:Number;
		private var firstColorChange:Boolean;
		
		public function Shield() {
			angle = 0.0;
			time = 0.0;
			velocity = 6;
			_distance = SpaceWorld.world.radius + 30;
			direction = 1.0;
			firstColorChange = true;
		}
		
		override public function update():void {
			
			if (Input.check(Key.RIGHT)) {
				angle += velocity * FP.elapsed; //0.15;
				direction = 1.0;
			} else if (Input.check(Key.LEFT)) {
				angle -= velocity * FP.elapsed; //0.15;
				direction = -1.0;
			} else {
				angle += direction * velocity * 0.1 * FP.elapsed;
			}
			x = FP.halfWidth + Math.cos(angle) * _distance;
			y = FP.halfHeight + Math.sin(angle) * _distance;
			
			if (firstColorChange) {
				time += FP.elapsed;
				if (time > 1.0) {
					time = 0;
					SpaceWorld.world.changeColor(FP.random * 3);
					firstColorChange = false;
				}
			}
		
		}
		
		override public function render():void {
			Draw.circlePlus(x, y, 10, 0xffffffff, 1, true);
		}
		
		public function get distance():Number {
			return _distance;
		}
		
		public function set distance(value:Number):void {
			_distance = value;
		}
	
	}
}