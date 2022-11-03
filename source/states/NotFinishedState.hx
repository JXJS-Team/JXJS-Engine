package states;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import Alphabet;

class NotFinishedState extends FlxState {

    public var bg:FlxSprite;
    
    public var notFinishedText:Alphabet;
    public var esctoexit:FlxText;

    override public function create() {
        super.create();

        notFinishedText = new Alphabet(0,0,"This menu isnt finished!", true,false);
        notFinishedText.screenCenter();
        add(notFinishedText);
    }

}