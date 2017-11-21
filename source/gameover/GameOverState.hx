package gameover;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import menu.MainMenuState;


class GameOverState extends FlxState {

    private var score: Int;


    public function new(score: Int) {
        super();
        this.score = score;
    }

    override public function create(): Void {
        var gameOver = new FlxText(0, FlxG.height / 2 - 64 - 32, FlxG.width);
        gameOver.alignment = FlxTextAlign.CENTER;
        gameOver.size = 64;
        gameOver.text = "GAME OVER";

        var scoreText = new FlxText(0, FlxG.height / 2 + 32, FlxG.width);
        scoreText.alignment = FlxTextAlign.CENTER;
        scoreText.size = 32;
        scoreText.text = 'YOUR SCORE: ${lpad(score, 6)}';

        add(gameOver);
        add(scoreText);
    }

    var timeSpent = 0.0;

    override public function update(elapsed: Float): Void {
        timeSpent += elapsed;

        if (timeSpent > 5) {
            FlxG.switchState(new MainMenuState());
        }
    }


    private inline function lpad(number: Int, padding: Int): String {
        return StringTools.lpad(Std.string(number), "0", padding);
    }
}
