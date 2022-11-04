package states;

#if desktop
import Discord.DiscordClient;
#end
import states.CacheState.ImageCache;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
// import states.ModsState;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import flash.display.BitmapData;
import openfl.display.BitmapData as Bitmap;
import states.MusicBeatState;
import others.Config;
import scripting.ui.MMScript;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var curSelected:Int = 0;

	public static var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'story_mode', 
		'freeplay', 
		#if !switch
		'options', 
		'donate', 
        'changelog' #end
	];

	var optionMap:Map<String,MusicBeatState> = [
		'story_mode' => new StoryMenuState(),
		'freeplay' => new FreeplayState(),
		'options' => new OptionsMenuState(),
        'changelog' => new states.AnnouncementState()
	];

	var canSnap:Array<Float> = [];
	var camFollow:FlxObject;
	var newInput:Bool = true;
	public var bg:FlxSprite;
	var lol:String;
	public static var firstStart:Bool = true;

	public static var finishedFunnyMove:Bool = false;

	public static var creditsShit:FlxText;
	public static var versionShit3:FlxText;
	public static var versionShit2:FlxText;

	public static var menuItem:FlxSprite;

    public static var jxjsEngineVersion = "0.45";

	override function create()
	{

		MMScript.onCreate();
		
		//LOAD CUZ THIS SHIT DONT DO IT SOME IN THE CACHESTATE.HX FUCK
		PlayerSettings.player1.controls.loadKeyBinds();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("PreviewMenusIn the Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		#if !MAINMENU
		if (!FlxG.sound.music.playing)FlxG.sound.playMusic(Paths.music('freakymenu'));
		#end

		persistentUpdate = persistentDraw = true; bg = new FlxSprite(-80);

        bg.loadGraphic(Paths.image('menu/menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			menuItem = new FlxSprite(70, (i * 140)  + offset);
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = true;
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.8));
			menuItem.updateHitbox();

		}
		//FlxG.camera.follow(camFollow, null, 0.06);
		


		creditsShit= new FlxText(5, FlxG.height - 19, 0, "Press C to go to credits!", 12);
		creditsShit.scrollFactor.set();
		creditsShit.setFormat(Paths.font("Funkin.otf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(creditsShit);


		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if mobileC
		addVirtualPad(UP_DOWN, A_B);
		#end
		
		super.create();
	}
	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{

		MMScript.onUpdate();
		

		#if !MAINMENU
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		#end

		if (FlxG.keys.justPressed.C) {

			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() {
				MMScript.onNewStateTrigger("CREDITS");
				FlxG.switchState(new CreditState());
			});
		}

		if (FlxG.keys.justPressed.SEVEN) {
			FlxG.switchState(new states.editors.Toolbox());
		}



		if (!selectedSomethin)
		{
			
			
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

            if (controls.BACK) {
                FlxG.switchState(new TitleState());
            }
			
			if (controls.ACCEPT)
			{

				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
					#else
					FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
					#end
				}
				else
				{
					//FlxTween.tween(menuItems, {y: menuItem.y + 1000}, 0.6, {ease: FlxEase.quadInOut, type: ONESHOT});
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.camera.flash(FlxColor.WHITE);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							menuItems.forEach(function(spr:FlxSprite)
								{
									if (curSelected != spr.ID)
									{
										FlxTween.tween(spr, {alpha: 0}, 0.4, {
											ease: FlxEase.quadOut,
											onComplete: function(twn:FlxTween)
											{
												spr.kill();
											}
										});
									}
									else
									{
										FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
										{
											var daChoice:String = optionShit[curSelected];
											FlxG.switchState(optionMap[daChoice]);
										});
									}
								});
						}
					});
				}
			}
		}

		super.update(elapsed);

		/*
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X); 
		}); */
	} 

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		MMScript.onItemChange();

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.offset.y = 0;
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				FlxTween.tween(spr,{x:150},0.45,{ease:FlxEase.elasticInOut});
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
				spr.offset.x = 0.15 * (spr.frameWidth / 2 + 180);
				spr.offset.y = 0.15 * spr.frameHeight;
				FlxG.log.add(spr.frameWidth);
			}
			else
				FlxTween.tween(spr,{x:70},0.45,{ease:FlxEase.elasticInOut});
		});
	}
}