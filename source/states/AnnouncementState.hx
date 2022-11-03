package states;

import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import Alphabet;
import flixel.util.FlxColor;

class AnnouncementState extends FlxState {
    public var background:FlxSprite;

    public var announcementText:FlxText;

    override public function create() {
        background = new FlxSprite().loadGraphic(Paths.image('menu/menuDesat'));
        add(background);

        var http = new haxe.Http("https://raw.githubusercontent.com/JXJS-Team/JXJS-Engine/main/AnnouncerStuff.txt");

        http.onData = function(data:String) {
            if (data == "") {
                announcementText = new FlxText(0,0,0,"There are no new announcements. \n Press SPACE to recheck.",30);
                announcementText.color = FlxColor.BLACK;
                announcementText.screenCenter();
                add(announcementText);
            } else {
                announcementText = new FlxText(0,0,0,data,30);
                announcementText.screenCenter();
                announcementText.color = FlxColor.BLACK;
                add(announcementText);
            }


        }

        http.onError = function(error)
        {
            trace('error: $error');
            FlxG.camera.fade(FlxColor.BLACK, 0.6, false, function() {
                FlxG.switchState(new systems.error.InternetError());
            });
        }

        http.request();
    }

    override public function update(elapsed) {
        if (FlxG.keys.justPressed.SPACE) {
            remove(announcementText);
            var http = new haxe.Http("https://raw.githubusercontent.com/JXJS-Team/JXJS-Engine/main/AnnouncerStuff.txt");

            http.onData = function(data:String) {
                if (data == "") {
                    announcementText = new FlxText(0,0,0,"There are no new announcements. \n Press SPACE to recheck.",30);
                    announcementText.color = FlxColor.BLACK;
                    announcementText.screenCenter();
                    add(announcementText);
                } else {
                    announcementText = new FlxText(0,0,0,data,30);
                    announcementText.screenCenter();
                    announcementText.color = FlxColor.BLACK;
                    add(announcementText);
                }
    
    
            }
    
            http.request();
        }

        if (FlxG.keys.justPressed.ESCAPE) {
            FlxG.camera.fade(FlxColor.BLACK, 0.6, false, function() {
                FlxG.switchState(new states.MainMenuState());
            });
        }
    }
}