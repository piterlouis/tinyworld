package com.piterlab {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class TinyWorld extends Entity {
		
		private var _radius:Number;
		private var _color:uint;
        
        private var time:uint;
        
		
		public function TinyWorld() {
			x = FP.halfWidth;
			y = FP.halfHeight;
			_radius = 25;
			_color = 0xffffffff;
            time = 0;
		}
		
		override public function render():void {
			Draw.circlePlus(x, y, _radius, _color, 1, true);
		}
		
		public function get radius():Number {
			return _radius;
		}
		
		public function set radius(value:Number):void {
			_radius = value;
			SpaceWorld.shield.distance = value + 30;
			if (_radius <= 8) {
				_radius = 0;
				SpaceWorld.endGame();
			}
		}
		
		public function get color():uint {
		    var icolor:uint = 3;
            if (_color == 0xffff0000) icolor = 0;
            else if (_color == 0xff00ff00) icolor = 1;
            else if (_color == 0xff0000ff) icolor = 2;
            return icolor;
		}
		//
		//public function set color(value:uint):void {
			//_color = value;
		//}
        
        public function changeColor(value:uint):void {
            _color = 0xffffffff;
            if (value == 0) _color = 0xffff0000;
            else if (value == 1) _color = 0xff00ff00;
            else if (value == 2) _color = 0xff0000ff;
            Assets.getSound("ChangeFx").play();
        }
        
        override public function update():void {
            if (time % 4) {
				x = (FP.random * 3) - 2 + FP.halfWidth;
				y = (FP.random * 3) - 2 + FP.halfHeight;
			}
			time++;
        }
	}

}