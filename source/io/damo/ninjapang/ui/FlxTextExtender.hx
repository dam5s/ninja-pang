package io.damo.ninjapang.ui;

import flixel.text.FlxText;


class FlxTextExtender {

    public static inline var DEFAULT_TEXT_COLOR = 0xFFe3db35;

    public static function defaultStyle(self: FlxText): FlxText {
        self.alignment = FlxTextAlign.CENTER;
        self.borderSize = 3;
        self.borderStyle = FlxTextBorderStyle.NONE;
        self.color = DEFAULT_TEXT_COLOR;
        self.borderColor = 0xFF403912;
        self.font = AssetPaths.prstart__ttf;

        return self;
    }
}
