package states.awards;

import states.modding.USure;
import flixel.*;
import flixel.group.*;
import flixel.util.*;
import Alphabet;
import flixel.tweens.*;
#if sys
import sys.FileSystem;
#end

class AwardsState extends FlxState {
    public static var awards = [
        ["Secret Award", "username"]
    ];

    public static function unlockAward(key:String){
        checkReward(key);
    } 

    public static function checkReward(reward:String) {
        switch (reward) {
            case "username":
                FlxG.save.data.usernameAward = true;
                
        }
    }

    public static function resetAwards() {
        // Put your FlxG save data var and set it to false in this function.
        FlxG.save.data.usernameAward = false; 
        
    }




    public var bg:FlxSprite;

    public var fC = true;
    public var timeBy = 0;

    public var id = 1;

    public var curSelected = 1;

    public var awardGroup = new FlxSpriteGroup();
    


    override public function create() {

        bg = new FlxSprite().loadGraphic(Paths.image("menu/menuDesat"));
        add(bg);

        for (i in awards) {
            if (fC) {
                var Person = new Alphabet(13, 40, i[0], true, false);
                Person.ID = id;

                FlxTween.tween(Person, {x: 100}, 0.45, {ease: FlxEase.quadOut});

                Person.color = FlxColor.GREEN;

                add(Person);
                awardGroup.add(Person);

                // Add da shit
                id++;
                timeBy++;
                fC = false;
            } else {
                var Person = new Alphabet(13, 40+60*timeBy, i[0], true, false);
                Person.ID = id;

                add(Person);
                awardGroup.add(Person);

                // Add da shit
                id++;
                timeBy++;
            }
        }
    }

    override public function update(elapsed) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.DOWN) {
            changeItem("DOWN");
        }

        if (FlxG.keys.justPressed.UP) {
            changeItem("UP");
        }

        if (FlxG.keys.justPressed.SHIFT) {
            USure.setStates(new states.awards.ClearState(), new states.awards.AwardsState());
        }

        // if (FlxG.keys.justPressed.ENTER) {
        //     var daChoice = curSelected - 1;
        //     CreditsDescriptionState.Description = descs[daChoice];
        //     FlxG.switchState(new states.CreditsDescriptionState());
        // }

        if (FlxG.keys.justPressed.ESCAPE) {
            FlxG.switchState(new states.MainMenuState());
        }

        // credGroup.screenCenter(X);
    }

    public function changeItem(way:String) {
        if (way == "DOWN") {
            if (curSelected == awards.length) {
                curSelected = 1;
            } else {
                curSelected++;
            }
        }

        if (way == "UP") {
            if (curSelected == 1) {
                curSelected = awards.length;
            } else {
                curSelected = curSelected - 1;
            }
        }

        awardGroup.forEach(function(spr:FlxSprite) {
            if (spr.ID == curSelected) {
                FlxTween.tween(spr, {x: 100}, 0.45, {ease: FlxEase.quadOut});
                spr.color = FlxColor.GREEN;
                // FlxG.camera.follow(bg, FlxCameraFollowStyle.TOPDOWN);
            } else {
                FlxTween.tween(spr, {x: 13}, 0.45, {ease: FlxEase.quadIn});
                spr.color = FlxColor.WHITE;

            }
        });
    }

}