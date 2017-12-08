package io.damo.ninjapang.menu;

import flixel.FlxSubState;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxColor;
import io.damo.ninjapang.controls.Controls;
import io.damo.ninjapang.ui.AssetsSupport;
import io.damo.ninjapang.ui.FlxTextExtender;


class HighScoreSubState extends FlxSubState {

    private var controls: Controls;
    private var saveService: SaveService;

    public function new() {
        super(FlxColor.BLACK);
    }

    override public function create(): Void {
        super.create();

        this.controls = Env.instance.controls;
        this.saveService = Env.instance.saveService;


        add(AssetsSupport.buildBgSprite());

        var score = saveService.loadHighScore();
        var text = new MenuItem(0, 1, 'HIGHSCORE ${lpad(score, 6)}');
        text.borderStyle = FlxTextBorderStyle.OUTLINE;
        text.color = FlxTextExtender.DEFAULT_TEXT_COLOR;
        add(text);
    }

    override public function update(elapsed: Float): Void {
        if (controls.skip())
            close();
    }


    private inline function lpad(number: Int, padding: Int): String {
        return StringTools.lpad(Std.string(number), "0", padding);
    }
}
