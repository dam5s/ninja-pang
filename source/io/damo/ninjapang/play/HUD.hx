package io.damo.ninjapang.play;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

using io.damo.ninjapang.ui.FlxTextExtender;


class HUD extends FlxSpriteGroup {

    private static inline var PADDING = 16;

    private var scoreBoard: ScoreBoard;
    private var livesText: FlxText;
    private var scoreText: FlxText;

    public function new(scoreBoard: ScoreBoard) {
        super();

        this.scoreBoard = scoreBoard;

        livesText = new FlxText(PADDING * 2, PADDING, FlxG.width - PADDING * 4).defaultStyle();
        livesText.alignment = FlxTextAlign.RIGHT;
        scoreText = new FlxText(PADDING * 2, PADDING).defaultStyle();
        scoreText.alignment = FlxTextAlign.LEFT;

        styleText(livesText);
        styleText(scoreText);

        add(livesText);
        add(scoreText);
    }

    override public function update(elapsed: Float): Void {
        livesText.text = '${scoreBoard.lives} LIVES';
        scoreText.text = 'SCORE ${lpad(scoreBoard.score, 6)}';

        super.update(elapsed);
    }


    private static function styleText(flxText: FlxText) {
        flxText.borderStyle = FlxTextBorderStyle.NONE;
        flxText.size = 12;
    }

    private inline function lpad(number: Int, padding: Int): String {
        return StringTools.lpad(Std.string(number), "0", padding);
    }
}
