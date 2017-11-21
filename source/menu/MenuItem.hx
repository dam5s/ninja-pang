package menu;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class MenuItem extends FlxText {

    private static inline var SIZE = 32;
    public var index(default, null): Int;


    public function new(index: Int, totalItems: Int, text: String) {
        var menuHeight = totalItems * SIZE;
        var y = (FlxG.height - menuHeight) / 2 + index * SIZE;

        super(0, y, FlxG.width);

        this.index = index;
        this.alignment = FlxTextAlign.CENTER;
        this.size = SIZE;
        this.text = text;
        this.borderStyle = FlxTextBorderStyle.NONE;
        this.borderColor = FlxColor.PURPLE;
        this.borderSize = 1;
    }
}
