package ui;

import flixel.FlxG;
import flixel.FlxSprite;

class AssetsSupport {

    public static function buildBgSprite(): FlxSprite {
        var bg = new FlxSprite(0, 0);
        bg.immovable = true;
        bg.setSize(FlxG.width, FlxG.height);
        bg.loadGraphic(AssetPaths.mini_ninja_bg__png);
        return bg;
    }
}
