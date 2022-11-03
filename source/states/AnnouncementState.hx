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
        background = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        add(background);

        var http = new haxe.Http("https://raw.githubusercontent.com/JXJS-Team/JXJS-Engine/main/AnnouncerStuff.txt");
        var returnedData:Array<String> = [];

        http.onData = function(data:String) {
            if (data == "") {
                announcementText = new FlxText(0,0,0,"There are no new announcements.",16);
                announcementText.screenCenter();
                add(announcementText);
            } else {
                announcementText = new FlxText(0,0,0,data,16);
                announcementText.screenCenter();
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
}