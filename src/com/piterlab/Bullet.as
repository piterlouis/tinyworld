package com.piterlab {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Bullet extends Entity {
		
        private var velocity:Number;
        private var angle:Number;
        private var acceleration:Number;
        
		public function Bullet(vel:Number, accel:Number, ang:Number) {
            graphic = new Image(SpaceWorld.particle);
            velocity = vel;
            acceleration = accel;
            angle = ang;
            x = SpaceWorld.shield.x;
            y = SpaceWorld.shield.y;
		}
        
        override public function update():void {
            velocity += acceleration;
            
            x += velocity * Math.cos(angle);
            y += velocity * Math.sin(angle);
        }
	
	}

}