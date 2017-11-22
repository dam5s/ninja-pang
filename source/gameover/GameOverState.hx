package gameover;

using ui.FlxTextExtender;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import menu.MainMenuState;


class GameOverState extends FlxState {

    private var score: Int;
    private var isHighScore: Bool;


    public function new(score: Int, isHighScore: Bool) {
        super();
        this.score = score;
        this.isHighScore = isHighScore;
    }

    override public function create(): Void {
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

        add(gameOver);
        add(scoreText);
    }

    var timeSpent = 0.0;

    override public function update(elapsed: Float): Void {
        timeSpent += elapsed;

        if (FlxG.keys.justPressed.Z && timeSpent > 1) {
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
