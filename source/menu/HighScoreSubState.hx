package menu;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import save.SaveService;
import ui.AssetsSupport;


class HighScoreSubState extends FlxSubState {

    public function new(saveService: SaveService) {
        super(FlxColor.BLACK);

        var score = saveService.loadHighScore();
        add(AssetsSupport.buildBgSprite());
        add(new MenuItem(0, 1, 'HIGHSCORE ${lpad(score, 6)}'));
    }

    override public function update(elapsed: Float): Void {
        if (FlxG.keys.justPressed.X) close();
        if (FlxG.keys.justPressed.Z) close();
    }


    private inline function lpad(number: Int, padding: Int): String {
        return StringTools.lpad(Std.string(number), "0", padding);
    }
}
