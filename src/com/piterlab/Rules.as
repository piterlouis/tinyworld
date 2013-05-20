package com.piterlab {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.flashpunk.World;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Rules extends World {
		private var mainTitle:Entity;
        private var summary:Entity;
        private var back:Entity;
        
        private var _bloom:BloomLighting;
        
        
		public function Rules() {
            _bloom = new BloomLighting(10.0, 2);
            _bloom.layer = -1;
            _bloom.color = 0xafff00;
            add(_bloom);
            
            var txt:Text = new Text("How to play", 0, 0, { size:30 } );
            //txt.centerOrigin()
            mainTitle = new Entity(40, 40, new BloomWrapper(txt));
            add(mainTitle);
            _bloom.register(mainTitle.graphic as BloomWrapper);
            
            var st:String = "You control the Planetoid orbiting Tiny World, "
                + "your objective is to block energy meteorites with different color than Tiny World, while you have to permit"
                + " the pass to meteorites with the same energy color than Tiny World.\n\nWhen a meteorite of different color impact"
                + " Tiny World, the planet will be slightly smaller, if is the same color, the planet will be slightly larger."
                + " Be careful, or Tiny World will dissapear.\n\n"
                + "Use the arrow keys LEFT and RIGHT to move your planetoid in orbit and block the meteorites.\n\n"
                + "Use ESC to abort the game and return to Main Menu.\n\n\n"
                + "Good Luck.\n"
                + "a game by Piterlouis";
            txt = new Text(st, 0, 0, {width:600,height:300, wordWrap:true});
            summary = new Entity(50, 80, txt);
            add(summary);
            
            txt = new Text("PRESS ESC TO BACK", 0, 0);
            txt.centerOrigin();
            back = new Entity(FP.width -150, 370, new BloomWrapper(txt));
            add(back);
            _bloom.register(back.graphic as BloomWrapper);
		}
        
        override public function update():void {
            if (Input.pressed(Key.ESCAPE)) {
                FP.world = new MainMenu();
                Main.state = Main.STATE_MENU;
            }
        }
	
	}

}