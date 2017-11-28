package menu;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxColor;
import save.SaveService;
import ui.AssetsSupport;
import ui.FlxTextExtender;


class HighScoreSubState extends FlxSubState {

    public function new(saveService: SaveService) {
        super(FlxColor.BLACK);

        add(AssetsSupport.buildBgSprite());

        var score = saveService.loadHighScore();
        var text = new MenuItem(0, 1, 'HIGHSCORE ${lpad(score, 6)}');
        text.borderStyle = FlxTextBorderStyle.OUTLINE;
        text.color = FlxTextExtender.DEFAULT_TEXT_COLOR;
        add(text);
    }

    override public function update(elapsed: Float): Void {
        var justPressed = FlxG.keys.justPressed;

        if (justPressed.X || justPressed.ESCAPE || justPressed.Z || justPressed.ENTER)
            close();
    }


    private inline function lpad(number: Int, padding: Int): String {
        return StringTools.lpad(Std.string(number), "0", padding);
    }
}
