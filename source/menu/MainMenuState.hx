package menu;

import flixel.FlxG;
import flixel.FlxState;
import play.PlayState;
import save.SaveService;
import ui.AssetsSupport;


class MainMenuState extends FlxState {

    private var saveService = new SaveService();
    private var items = ["START", "HIGHSCORE", "EXIT"];
    private var selectedItem = 0;

    override public function create(): Void {
        add(AssetsSupport.buildBgSprite());

        for (i in 0...items.length) {
            add(new MenuItem(i, items.length, items[i]));
        }
    }

    override public function update(elapsed: Float): Void {
        if (FlxG.keys.justPressed.Z) {
            launchItem();
            return;
        }

        if (FlxG.keys.justPressed.DOWN) selectedItem += 1;
        if (FlxG.keys.justPressed.UP) selectedItem -= 1;

        if (selectedItem < 0) selectedItem = 0;
        if (selectedItem >= items.length) selectedItem = items.length - 1;

        forEachOfType(MenuItem, function(item: MenuItem) {
            if (selectedItem == item.index) {
                item.select();
            } else {
                item.deselect();
            }
        });

        super.update(elapsed);
    }


    private inline function launchItem() {
        switch (items[selectedItem]) {
            case "START": FlxG.switchState(new PlayState(saveService));
            case "HIGHSCORE": openSubState(new HighScoreSubState(saveService));
            case "RESET": saveService.resetHighScore();
            case "EXIT": openfl.Lib.close();
        }
    }
}
