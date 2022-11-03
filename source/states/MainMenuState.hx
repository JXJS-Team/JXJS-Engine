package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import Alphabet;
import flixel.util.FlxColor;


class MainMenuState extends MusicBeatState {

    public var pisspoop = [
		"Story Mode",
		"Freeplay",
		"Credits",
        "Awards",
		"Options",
		"Changelog",
		"Donate"
    ];

    public static var jxjsEngineVersion = "1.02";

    public var debug = false;

    public var curSelected = 1;

    public var yShit = 40;
    public var addBy = 60;
    public var timeBy = 0;

    public var id = 1;

    public var fC = true;

    public var credGroup = new FlxSpriteGroup();

    public var bg:FlxSprite;
    
    public function loadState() {
        var daChoice = pisspoop[curSelected-1];

        switch(daChoice) {
            case "Story Mode":
                FlxG.switchState(new states.StoryMenuState());
            case "Freeplay":
                FlxG.switchState(new states.FreeplayState());
            case "Credits":
                FlxG.switchState(new states.CreditState());
            case "Awards":
                FlxG.switchState(new states.awards.AwardsState());
            case "Options":
                FlxG.switchState(new states.OptionsMenuState());
            case "Changelog":
                // FlxG.switchState(new states.AnnouncementState());
                FlxG.switchState(new states.AnnouncementState());
            case "Donate":
                #if linux
                Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
                #else
                FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
                #end
        }
    }

    override public function create() {

        FlxG.camera.fade(FlxColor.BLACK, 0.6, true, function() {
            return true;
        });

        bg = new FlxSprite().loadGraphic(Paths.image("menu/menuBG"));
        add(bg);

        for (i in pisspoop) {
            if (fC) {
                var Option = new Alphabet(13, yShit, i, true, false);
                Option.ID = id;

                FlxTween.tween(Option, {x: 100}, 0.45, {ease: FlxEase.quadOut});

                Option.color = FlxColor.GREEN;

                add(Option);
                credGroup.add(Option);

                // Add da shit
                id++;
                timeBy++;
                fC = false;
            } else {
                var Option = new Alphabet(13, yShit+addBy*timeBy, i, true, false);
                Option.ID = id;

                add(Option);
                credGroup.add(Option);

                // Add da shit
                id++;
                timeBy++;
            }
        }

        if (debug == true) {
            debugIds();
        }
    }

    public function debugIds() {
        credGroup.forEach(function(spr:FlxSprite) {
            trace("ID : " + spr.ID);
        });
    }

    override public function update(elapsed) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.DOWN) {
            changeItem("DOWN");
        }

        if (FlxG.keys.justPressed.UP) {
            changeItem("UP");
        }

        if (FlxG.keys.justPressed.ENTER)
        {
            loadState();
		}

        if (FlxG.keys.justPressed.ESCAPE) {
            FlxG.switchState(new states.TitleState());
        }

        if (FlxG.keys.justPressed.ESCAPE) {
            FlxG.switchState(new states.MainMenuState());
        }

        // credGroup.screenCenter(X);

    
    }



    public function changeItem(way:String) {
        if (way == "DOWN") {
            if (curSelected == pisspoop.length) {
                curSelected = 1;
            } else {
                curSelected++;
            }
        }

        if (way == "UP") {
            if (curSelected == 1) {
                curSelected = pisspoop.length;
            } else {
                curSelected = curSelected - 1;
            }
        }

        credGroup.forEach(function(spr:FlxSprite) {
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
