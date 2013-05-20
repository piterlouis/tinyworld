package com.piterlab {
	import adobe.utils.CustomActions;
    import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Score extends Entity {
		
		private var text:Text;
		private var _points:int;
		
		private var icon:Graphic;
		private var origin:Point;
		private var time:uint;
		
		public function Score(fontSize:uint = 12, fontColor:uint = 0xffffffff, iconColor:uint = 0xffffffff) {
			text = new Text("0", 20, 0, {color: fontColor, size: fontSize});
			addGraphic(text);
			
			if (iconColor != 0xffffffff) {
                var c:BitmapData;
                if (iconColor == 0) c = SpaceWorld.circleR;
                else if (iconColor == 1) c = SpaceWorld.circleG;
                else if (iconColor == 2) c = SpaceWorld.circleB;
				icon = new Image(c);
				icon.x = 0;
				icon.y = fontSize / 4;
				origin = new Point(icon.x, icon.y);
				addGraphic(icon);
			}
			
			_points = 0;
			time = 0;
		}
		
		public function get points():int {
			return _points;
		}
		
		public function set points(value:int):void {
            _points = value;
            if (_points < 0) _points = 0;
			text.text = String(_points);
			
		}
		
		override public function update():void {
            if (!icon) return;
            
			if (time % 4) {
				icon.x = (FP.random * 3) - 2 + origin.x;
				icon.y = (FP.random * 3) - 2 + origin.y;
			}
			time++;
		}
	
	}

}