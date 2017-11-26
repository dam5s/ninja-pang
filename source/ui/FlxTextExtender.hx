package ui;

import flixel.text.FlxText;


class FlxTextExtender {

    public static function defaultStyle(self: FlxText): FlxText {
        self.alignment = FlxTextAlign.CENTER;
        self.borderSize = 3;
        self.borderStyle = FlxTextBorderStyle.NONE;
        self.color = 0xFFe3db35;
        self.borderColor = 0xFF403912;
        self.font = AssetPaths.prstart__ttf;

        return self;
    }
}
