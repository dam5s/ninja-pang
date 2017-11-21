package gameover;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import menu.MainMenuState;


class GameOverState extends FlxState {

    override public function create(): Void {
        var text = new FlxText(0, FlxG.height / 2 - 32, FlxG.width);
        text.alignment = FlxTextAlign.CENTER;
        text.size = 64;
        text.text = "GAME OVER";

        add(text);
    }

    var timeSpent = 0.0;

    override public function update(elapsed: Float): Void {
        timeSpent += elapsed;

        if (timeSpent > 5) {
            FlxG.switchState(new MainMenuState());
        }
    }
}
