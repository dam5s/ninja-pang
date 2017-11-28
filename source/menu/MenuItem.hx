package menu;

using ui.FlxTextExtender;

import flixel.FlxG;
import flixel.text.FlxText;
import ui.FlxTextExtender;


class MenuItem extends FlxText {

    private static inline var DESELECTED_COLOR = 0xffa09701;
    private static inline var SELECTED_COLOR = FlxTextExtender.DEFAULT_TEXT_COLOR;

    private static inline var DESELECTED_SIZE = 28;
    private static inline var SELECTED_SIZE = 32;

    private static inline var MARGIN = 16;

    public var index(default, null): Int;

    public function new(index: Int, totalItems: Int, text: String) {
        var menuHeight = totalItems * SELECTED_SIZE + (totalItems - 1) * MARGIN;
        var marginBeforeMenu = (400 - menuHeight) / 2;

        var y = marginBeforeMenu + index * (SELECTED_SIZE + MARGIN);

        super(0, y, FlxG.width);
        defaultStyle();

        this.color = DESELECTED_COLOR;
        this.index = index;
        this.alignment = FlxTextAlign.CENTER;
        this.size = DESELECTED_SIZE;
        this.text = text;
    }

    public function select() {
        borderStyle = FlxTextBorderStyle.OUTLINE;
        color = FlxTextExtender.DEFAULT_TEXT_COLOR;
        size = SELECTED_SIZE;
    }

    public function deselect() {
        borderStyle = FlxTextBorderStyle.NONE;
        color = DESELECTED_COLOR;
        size = DESELECTED_SIZE;
    }
}
