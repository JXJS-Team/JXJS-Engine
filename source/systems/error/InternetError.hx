package systems.error;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import states.MusicBeatState;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import Alphabet;

class InternetError extends MusicBeatState {
    public var bg:FlxSprite;

    public var logoBl:FlxSprite;

    public var error:Alphabet;
    public var instructions:Alphabet;

    override public function create() {
        // new FlxTimer().start(0.01, function(tmr:FlxTimer)
        //     {
        //         if(logoBl.angle == -4) 
        //             FlxTween.angle(logoBl, logoBl.angle, 4, 4, {ease: FlxEase.quartInOut});
        //         if (logoBl.angle == 4) 
        //             FlxTween.angle(logoBl, logoBl.angle, -4, 4, {ease: FlxEase.quartInOut});
        //     }, 0);

        bg = new FlxSprite().loadGraphic(Paths.image('menu/menuDesat'));
        add(bg);
        
        error = new Alphabet(0,0,"We were unable to\n connect to our\n servers!");
        error.y = 200;
        error.screenCenter(X);
        add(error);

        instructions = new Alphabet(0,0,"To return the the Main Menu, press Enter.");
        instructions.y = 600;
        instructions.screenCenter(X);
        add(instructions);
        
    }

    override public function update(elapsed) {

            if (FlxG.keys.justPressed.SPACE) {
                FlxTween.tween(FlxG.camera, {zoom:1.02}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
            }
    }
}