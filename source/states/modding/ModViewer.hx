package states.modding;

import lime.utils.Assets;
import flixel.FlxState;
import flixel.FlxSprite;
import Alphabet;

class ModViewer extends FlxState {

    
    


    override public function create() {
        super.create();

        var bg = new FlxSprite().loadGraphic(ModPaths.image('backgrounds/menuBG'));
        add(bg);

        var configStuff = getModData();


        
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

    public static function enableModTitle() {

    }
    
}