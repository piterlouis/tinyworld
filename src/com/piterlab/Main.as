package com.piterlab {
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Main extends Engine {
		
        public static const STATE_MENU:uint = 0;
        public static const STATE_GAME:uint = 1;
        public static const STATE_RULE:uint = 2;
        
        
        static public var state:uint;
        
		public function Main():void {
			super(800, 400, 60, false);
			
			//FP.world = new SpaceWorld();
			FP.world = new MainMenu();
			//FP.console.enable();
            state = STATE_MENU;
		}
		
		override public function init():void {
			FP.screen.color = 0;
			//FP.world.addTween(SPAWN_ALARM, true);
			
			Assets.prepareSounds();
		}
		
		override public function update():void {
			if (state == STATE_GAME && Input.pressed(Key.ESCAPE)) {
				FP.world = new MainMenu();
                state = STATE_MENU;
			}
            else if (state == STATE_GAME && SpaceWorld.isGameOver && Input.pressed(Key.SPACE)) {
                FP.world = new MainMenu();
                state = STATE_MENU;
            }
            super.update();
		}
		
		override public function render():void {
			var temp:BitmapData = FP.buffer;
			FP.screen.swap();
			FP.buffer.copyPixels(temp, FP.bounds, FP.zero);
			Draw.setTarget(FP.buffer, FP.zero);
			Draw.rect(0, 0, FP.width, FP.height, FP.screen.color, .1);
			Draw.resetTarget();
			if (FP.world.visible)
				FP.world.render();
			FP.screen.redraw();
		}
	}

}