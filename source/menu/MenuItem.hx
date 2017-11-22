package menu;

using ui.FlxTextExtender;

import flixel.text.FlxText;
import flixel.FlxG;


class MenuItem extends FlxText {

    private static inline var SIZE = 32;

    public var index(default, null): Int;

    public function new(index: Int, totalItems: Int, text: String) {
        var menuHeight = totalItems * SIZE;
        var y = (FlxG.height - menuHeight) / 2 + index * SIZE;

        super(0, y, FlxG.width);
        defaultStyle();

        this.index = index;
        this.alignment = FlxTextAlign.CENTER;
        this.size = SIZE;
        this.text = text;
    }
}
