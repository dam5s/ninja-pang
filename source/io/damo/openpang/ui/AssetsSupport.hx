package io.damo.openpang.ui;

import flixel.FlxSprite;


class AssetsSupport {

    public static function buildBgSprite(): FlxSprite {
        return new FlxSprite(0, 0, AssetPaths.mini_ninja_bg__png);
    }
}
