package com.piterlab {
    import flash.display.BitmapData;
	import net.flashpunk.Entity;
    import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
    import net.flashpunk.graphics.Particle;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Explosion extends Entity {
		private var emitter:Emitter;
		private var numParticles:uint = 20;
        private var timer:Number = 0;
		
		public function Explosion(color:uint) {
            
            var pcolor:BitmapData;
            if (color == 0) pcolor = SpaceWorld.particleR;
            else if (color == 1) pcolor = SpaceWorld.particleG;
            else if (color == 2) pcolor = SpaceWorld.particleB;
            else pcolor = SpaceWorld.particleW;
            
			emitter = new Emitter(pcolor);
			emitter.newType("explode", [0]);
			emitter.setMotion("explode", 0, 0, 0.2, 360, 300, 1);
			
			this.graphic = emitter;
		}
		
		public function explode(x:Number, y:Number):void {
			for (var i:int = 0; i < numParticles; i++) {
				emitter.emit('explode', x, y);
			}
		}
		
		//override public function update():void {
			//timer += FP.elapsed;
			//if (timer > 1) {
				//timer = 0;
				//var random_x:Number = (Math.random() * (FP.width - 10)) + 5;
				//var random_y:Number = (Math.random() * (FP.height - 10)) + 5;
				//explode(random_x, random_y);
			//}
		//}
	
	}

}