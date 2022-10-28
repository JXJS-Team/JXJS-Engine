package states.modding;

import flixel.FlxState;
import states.CacheState.ImageCache;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import states.MusicBeatState;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.addons.display.shapes.FlxShapeArrow;
import flixel.math.FlxPoint;
#if sys
import sys.FileSystem;
#end
import openfl.utils.Assets as OpenflAssets;


class USure extends states.MusicBeatSubstate
{
	var wasPressed:Bool = false;
	var areYouSure:FlxText = new FlxText();
	var ye:FlxText = new FlxText();
	var NO:FlxText = new FlxText();
	var marker:FlxShapeArrow;

	var theText:Array<FlxText> = [];
	var selected:Int = 0;

	var blackBox:FlxSprite;
	var restart:Bool;

	override function create()
	{
		super.create();

		blackBox = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,FlxColor.BLACK);
        add(blackBox);

		marker = new FlxShapeArrow(0, 0, FlxPoint.weak(0, 0), FlxPoint.weak(0, 1), 24, {color: FlxColor.WHITE});

		areYouSure.setFormat(Paths.font("Funkin.otf"), 36, FlxColor.WHITE, FlxTextAlign.CENTER);
		areYouSure.text = "Are you sure you wanna to load this mod?";
		areYouSure.y = 176;
		areYouSure.screenCenter(X);
		add(areYouSure);

		theText.push(ye);
		theText.push(NO);
		ye.text = "Yes";
		NO.text = "No";

		for (i in 0...theText.length)
		{
			theText[i].setFormat(Paths.font("Funkin.otf"), 24, FlxColor.WHITE, FlxTextAlign.CENTER);
			theText[i].screenCenter(Y);
			theText[i].x = (i * FlxG.width / theText.length + FlxG.width / theText.length / 2) - theText[i].width / 2;
			add(theText[i]);
		}

		add(marker);

		blackBox.alpha = 0;
		ye.alpha = 0;
		NO.alpha = 0;
		areYouSure.alpha = 0;
		FlxTween.tween(blackBox, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});
		FlxTween.tween(ye, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
		FlxTween.tween(NO, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
		FlxTween.tween(areYouSure, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
	}

    public static var onAccept:FlxState;
    public static var onDecline:FlxState;

    public static function setStates(yes:FlxState, no:FlxState) {
        onAccept = yes;
        onDecline = no;

    }

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER && !wasPressed)
		{
			wasPressed = true;
			switch (selected)
			{
				case 0:
					FlxG.switchState(onAccept);

				case 1:
					FlxG.state.closeSubState();
			}
		}

		if (FlxG.keys.justPressed.LEFT)
		{
			changeSelection(-1);
		}

		if (FlxG.keys.justPressed.RIGHT)
		{
			changeSelection(1);
		}

		marker.x = theText[selected].x + theText[selected].width / 2 - marker.width / 2;
		marker.y = theText[selected].y - marker.height - 5;
	}

	function changeSelection(direction:Int = 0)
	{
		if (wasPressed)
			return;

		selected = selected + direction;
		if (selected < 0)
			selected = theText.length - 1;
		else if (selected >= theText.length)
			selected = 0;
	}
}