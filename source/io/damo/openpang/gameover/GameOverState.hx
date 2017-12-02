package io.damo.openpang.gameover;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import io.damo.openpang.interactions.Interactions;
import io.damo.openpang.menu.MainMenuState;
import io.damo.openpang.ui.AssetsSupport;

using io.damo.openpang.ui.FlxTextExtender;


class GameOverState extends FlxState {

    private var interactions: Interactions;
    private var score: Int;
    private var isHighScore: Bool;


    public function new(interactions: Interactions, score: Int, isHighScore: Bool) {
        super();
        this.interactions = interactions;
        this.score = score;
        this.isHighScore = isHighScore;
    }

    override public function create() {
        super.create();

        var gameOver = new FlxText(0, FlxG.height / 2 - 64 - 32, FlxG.width).defaultStyle();
        gameOver.size = 64;
        gameOver.text = "GAME OVER";
        gameOver.borderStyle = FlxTextBorderStyle.OUTLINE;

        var scoreText = new FlxText(0, FlxG.height / 2 + 32, FlxG.width).defaultStyle();
        scoreText.size = 32;

        if (isHighScore) {
            scoreText.text = 'NEW HIGHSCORE! ${lpad(score, 6)}';
        } else {
            scoreText.text = 'YOUR SCORE: ${lpad(score, 6)}';
        }

        add(AssetsSupport.buildBgSprite());
        add(gameOver);
        add(scoreText);

        FlxG.sound.play(AssetPaths.game_over__ogg);
    }

    var timeSpent = 0.0;

    override public function update(elapsed: Float): Void {
        timeSpent += elapsed;

        if (interactions.skip() && timeSpent > 1) {
            FlxG.switchState(new MainMenuState());
        }

        if (timeSpent > 5) {
            FlxG.switchState(new MainMenuState());
        }

        super.update(elapsed);
    }


    private inline function lpad(number: Int, padding: Int): String {
        return StringTools.lpad(Std.string(number), "0", padding);
    }
}
