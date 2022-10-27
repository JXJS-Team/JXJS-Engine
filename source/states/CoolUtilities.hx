package source.states;

import flixel.FlxState;
import flixel.FlxG;


class CoolUtilities {

    public static function newState(state:FlxState) {
        FlxG.switchState(state);
    }
    
    public static function userName():String {
	
		var env = Sys.environment();
		if (!env.exists("USERNAME")) {
			return "Guest";
		}
		return env["USERNAME"];
	}
}