package source.states;

import flixel.FlxState;
import flixel.FlxG;


class CoolUtilities {

    public static function newState(state:FlxState) {
        FlxG.switchState(state);
    } 
}