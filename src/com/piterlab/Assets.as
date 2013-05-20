package com.piterlab {
    import flash.media.Sound;
    import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author piterlouis
	 */
	public class Assets {
		
		// Sounds
		[Embed(source="/assets/Explosion.mp3")]
		private static const explosionFx:Class;
        
        [Embed(source="/assets/Shield.mp3")]
		private static const shieldFx:Class;

        [Embed(source="/assets/Shoot.mp3")]
		private static const shootFx:Class;
        
        [Embed(source="/assets/Ping.mp3")]
		private static const pingFx:Class;

        [Embed(source="/assets/Change.mp3")]
		private static const changeFx:Class;
		
		private static var sSounds:Dictionary = new Dictionary();
		
		
		public static function getSound(name:String):Sound {
			var sound:Sound = sSounds[name] as Sound;
			if (sound)
				return sound;
			else
				throw new ArgumentError("Sound not found: " + name);
		}
        
   		public static function prepareSounds():void {
			sSounds["ExplosionFx"] = new explosionFx();
            sSounds["ShieldFx"] = new shieldFx();
            sSounds["ShootFx"] = new shootFx();
            sSounds["PingFx"] = new pingFx();
            sSounds["ChangeFx"] = new changeFx();
		}
	
	}

}