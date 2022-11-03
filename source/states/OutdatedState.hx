package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import states.TitleState;
#if sys
import sys.FileSystem;
#end

class OutdatedState extends MusicBeatState
{
	public static var betaVersion = false;

	public static var version = MainMenuState.jxjsEngineVersion;
	public static var versionNeeded:Dynamic = null;

	public var text:FlxText;

	override public function create() {

		if (betaVersion) {
			text = new FlxText(0,0,0,"Your version of JXJS Engine is a beta version." 
			+ "\nCurrent Version : " + version
			+ "\nIf there is any bugs with this build please report these bugs to the developers."
			+ "\n\nPress Space to check for the lastest build, Press ESC to ignore this message."
			, 16);
			
		} else {
			text = new FlxText(0,0,0,"Your version of JXJS Engine is outdated." 
			+ "\nCurrent Version : " + version
			+ "\nMost Recent Version : " + versionNeeded
			+ "\n\nPress Space to check for the lastest build, Press ESC to ignore this message."
			, 16);
		}

		text.screenCenter();
		add(text);

	}

	override public function update(elapsed) {
		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.switchState(new states.MainMenuState());
		}

		if (FlxG.keys.justReleased.SPACE) {
			#if linux
			Sys.command('/usr/bin/xdg-open', ["https://github.com/JXJS-Team/JXJS-Engine/releases/latest", "&"]);
			#else
			FlxG.openURL('https://github.com/JXJS-Team/JXJS-Engine/releases/latest');
			#end
		}
	}

}
