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
    private var saveService: SaveService;
    private var scoreBoard: ScoreBoard;

    override public function create() {
        super.create();

        interactions = Env.instance.interactions;
        saveService = Env.instance.saveService;
        scoreBoard = Env.instance.scoreBoard;

        var gameOver = new FlxText(0, FlxG.height / 2 - 64 - 32, FlxG.width).defaultStyle();
        gameOver.size = 64;
        gameOver.text = "GAME OVER";
        gameOver.borderStyle = FlxTextBorderStyle.OUTLINE;

        var scoreText = new FlxText(0, FlxG.height / 2 + 32, FlxG.width).defaultStyle();
        scoreText.size = 32;

        var isHighScore = saveService.saveHighScore(scoreBoard.score);
        if (isHighScore) {
            scoreText.text = 'NEW HIGHSCORE! ${lpad(scoreBoard.score, 6)}';
        } else {
            scoreText.text = 'YOUR SCORE: ${lpad(scoreBoard.score, 6)}';
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
