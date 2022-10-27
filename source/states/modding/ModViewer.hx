package states.modding;

import lime.utils.Assets;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import Alphabet;

class ModViewer extends FlxState {

    
    


    override public function create() {
        super.create();

        var bg = new FlxSprite().loadGraphic(ModPaths.image('backgrounds/menuBG'));
        add(bg);

        var configStuff:Array<Dynamic> = getModData();

        var modTitle = new Alphabet(13, 40,configStuff[0], true, false);
        add(modTitle);

        var modDescription = new Alphabet(13, 100, configStuff[1], true, false);
        add(modDescription);


        
    }

    public static function getModData() {
        var fullText:String = Assets.getText(ModPaths.config());

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('\n'));
		}

		return swagGoodArray;
    }

    public override function update(elapsed) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE) {
            FlxG.switchState(new states.MainMenuState());
        }
    }
    
}