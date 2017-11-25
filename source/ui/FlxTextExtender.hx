package ui;

import flixel.text.FlxText;
import flixel.util.FlxColor;


class FlxTextExtender {

    public static function defaultStyle(self: FlxText): FlxText {
        self.alignment = FlxTextAlign.CENTER;
        self.borderSize = 2;
        self.borderStyle = FlxTextBorderStyle.NONE;
        self.color = FlxColor.WHITE;
        self.borderColor = FlxColor.BLACK;
        self.font = AssetPaths.manaspc__ttf;

        return self;
    }
}
