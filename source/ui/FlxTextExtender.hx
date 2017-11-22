package ui;

import flixel.text.FlxText;
import flixel.util.FlxColor;


class FlxTextExtender {

    public static function defaultStyle(self: FlxText): FlxText {
        self.alignment = FlxTextAlign.CENTER;
        self.borderSize = 2;
        self.borderStyle = FlxTextBorderStyle.NONE;
        self.borderColor = FlxColor.PURPLE;
        self.font = AssetPaths.manaspc__ttf;

        return self;
    }
}
