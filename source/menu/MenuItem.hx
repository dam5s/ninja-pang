package menu;

using ui.FlxTextExtender;

import flixel.FlxG;
import flixel.text.FlxText;


class MenuItem extends FlxText {

    private static inline var SIZE = 32;
    private static inline var MARGIN = 8;

    public var index(default, null): Int;

    public function new(index: Int, totalItems: Int, text: String) {
        var menuHeight = totalItems * SIZE + (totalItems - 1) * MARGIN;
        var marginBeforeMenu = (400 - menuHeight) / 2;

        var y = marginBeforeMenu + index * (SIZE + MARGIN);

        super(0, y, FlxG.width);
        defaultStyle();

        this.index = index;
        this.alignment = FlxTextAlign.CENTER;
        this.size = SIZE;
        this.text = text;
    }
}
