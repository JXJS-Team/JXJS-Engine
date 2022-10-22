package states;

import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.util.*;
import flixel.*;
import flixel.tweens.*;
import Alphabet;
import flixel.effects.FlxFlicker;

class MainMenuState extends FlxState {
	public var options = [
        "Story Mode",
        "Freeplay",
        #if desktop "Mods", #end
        "Credits",
        "Options",
        "Donate",
        #if desktop "Toolbox" #end
    ];

	// Don't change this

    public var curSelected = 1;

    public var id = 1;

    public var yShit = 40;
    public var addBy = 60;
    public var timeBy = 0;

    public var menuItems = new FlxSpriteGroup();


    public function loadStateShit() {
        menuItems.forEach(function(spr:FlxSprite) {
            if (spr.ID == curSelected) {
                FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker){
                    FlxG.sound.play(Paths.sound('confirmMenu'));
                    loadState();
                });
            } else {
                spr.kill();
            }
        });
    }

    public function loadState() {
        var daChoice = options[curSelected-1];
		others.Config.sectionCurSelected = 1;

        switch(daChoice) {
            case "Story Mode":
                FlxG.switchState(new states.StoryMenuState());
            case "Freeplay":
                FlxG.switchState(new states.FreeplayState());
            case "Mods":
                FlxG.switchState(new states.ModsState());
            case "Credits":
                FlxG.switchState(new states.CreditState());
            case "Options":
                FlxG.switchState(new states.OptionsMenuState());
            case "Donate":
                #if linux
                Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
                #else
                FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
                #end
            case "Toolbox":
                FlxG.switchState(new states.editors.Toolbox());

        }
    }
    override public function create() {
        super.create();

        var bg = new FlxSprite().loadGraphic(Paths.image("menu/menuBG"));
        add(bg);

        for (i in options) {
            if (id == 1) {
                var Option = new Alphabet(13, yShit, i, true, false);
                Option.color = FlxColor.GREEN;
                FlxTween.tween(Option, {x: 100}, 0.45, {ease: FlxEase.quadOut});
                add(Option);
                Option.ID = id;
                menuItems.add(Option);

                id++;
                timeBy++;
            } else {
                var Option = new Alphabet(13, yShit+addBy*timeBy, i, true, false);
                add(Option);
                Option.ID = id;
                menuItems.add(Option);

                id++;
                timeBy++;
            }
        }
    }

    override public function update(elapsed) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.DOWN) {
            changeItem("D");
        }

        if (FlxG.keys.justPressed.UP) {
            changeItem("U");
        }

        if (FlxG.keys.justPressed.ENTER) {
            loadStateShit();
        }
    }

    public function changeItem(way:String) {
        way = way.toLowerCase();

        FlxG.sound.play(Paths.sound('scrollMenu'));

        if (way == "d") {

			if (curSelected == options.length) {
                curSelected = 1;
            } else {
                curSelected++;
            }
        } 

        if (way == "u") {
			if (curSelected == 1) {
                curSelected = options.length;
            } else {
                curSelected = curSelected - 1;
            }

		
        }

        menuItems.forEach(function(spr:FlxSprite) {
            if (spr.ID == curSelected) {
                FlxTween.tween(spr, {x: 100}, 0.45, {ease: FlxEase.quadOut});
                spr.color = FlxColor.GREEN;
            } else {
                FlxTween.tween(spr, {x: 13}, 0.45, {ease: FlxEase.quadIn});
                spr.color = FlxColor.WHITE;
            }
        });
    }
}