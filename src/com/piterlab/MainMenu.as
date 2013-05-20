package com.piterlab {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class MainMenu extends World {
		
        private var mainTitle:Entity;
        private var subtitle:Entity;
        private var option1:Entity;
        private var option2:Entity;
        private var madein1:Entity;
        private var madein2:Entity;
        
        private var option1Red:Graphic;
        private var option1White:Graphic;
        
        private var option2Red:Graphic;
        private var option2White:Graphic;
        
        private var optionSelected:uint;
        
        private var _bloom:BloomLighting;
        
		public function MainMenu() {
            optionSelected = 1;
            
            _bloom = new BloomLighting(10.0, 2);
            _bloom.layer = -1;
            _bloom.color = 0xafff00;
            add(_bloom);
            
            mainTitle = new Entity(100, 50);
            mainTitle.graphic = new BloomWrapper(new Text("Tiny World",0, 0, {size:25}));
            add(mainTitle);
            _bloom.register(mainTitle.graphic as BloomWrapper);
            
            subtitle = new Entity(120, 80);
            subtitle.graphic = new Text("a game by piterlouis",0, 0);
            add(subtitle);

            option1Red = new BloomWrapper(new Text("Play", 0, 0, { color:0xffff0000 } ));
            option1White = new Text("Play", 0, 0);
            option1 = new Entity(140, 150);
            option1.graphic = option1Red;
            add(option1);
            _bloom.register(option1Red as BloomWrapper);

            option2Red = new BloomWrapper(new Text("How to play", 0, 0, { color:0xffff0000 } ));
            option2White = new Text("How to play", 0, 0);
            option2 = new Entity(140, 180);
            option2.graphic = option2White;
            add(option2);
            _bloom.register(option2Red as BloomWrapper);

            madein1 = new Entity(550, 330);
            madein1.graphic = new BloomWrapper(new Text("Made in 48 hours", 0, 0, {size:20}));
            add(madein1);
            _bloom.register(madein1.graphic as BloomWrapper);

            madein2 = new Entity(550, 360);
            madein2.graphic = new BloomWrapper(new Text("for Ludum Dare #23", 0, 0, {size:20}));
            add(madein2);
            _bloom.register(madein2.graphic as BloomWrapper);
		}
        
        override public function update():void {
            if (Input.check(Key.DOWN) && optionSelected != 2) {
                option1.graphic = option1White;
                option2.graphic = option2Red;
                Assets.getSound("PingFx").play();
                optionSelected = 2;
            }
            else if (Input.check(Key.UP) && optionSelected != 1) {
                option1.graphic = option1Red;
                option2.graphic = option2White;
                Assets.getSound("PingFx").play();
                optionSelected = 1;
            }
            else if (Input.check(Key.ENTER)) {
                if (optionSelected == 1) {
                    FP.world = new SpaceWorld();
                    Main.state = Main.STATE_GAME;
                }
                else if (optionSelected == 2) {
                    FP.world = new Rules();
                    Main.state = Main.STATE_RULE;
                }
            }
        }
	
	}

}