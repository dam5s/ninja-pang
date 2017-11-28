package menu;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import play.PlayState;
import save.SaveService;
import ui.AssetsSupport;


class MainMenuState extends FlxState {

    private var saveService = new SaveService();
    private var items = ["START", "HIGHSCORE", "EXIT"];
    private var selectedIndex = 0;

    override public function create(): Void {
        add(AssetsSupport.buildBgSprite());

        for (i in 0...items.length) {
            add(new MenuItem(i, items.length, items[i]));
        }
    }

    override public function update(elapsed: Float): Void {
        if (FlxG.mouse.justReleased) {
            var mouseX = FlxG.mouse.x;
            var mouseY = FlxG.mouse.y;

            forEachOfType(MenuItem, function(item: MenuItem) {
                var xInBounds = item.x <= mouseX && mouseX <= (item.x + item.width);
                var yInBounds = item.y <= mouseY && mouseY <= (item.y + item.height);


                if (xInBounds && yInBounds) {
                    selectedIndex = items.indexOf(item.text);
                    selectMenuItem();
                    new FlxTimer().start(.3, function(_) launchItem(item.text));
                }
            });

            return;
        }

        if (FlxG.keys.justPressed.Z || FlxG.keys.justPressed.ENTER) {
            launchItem(items[selectedIndex]);
            return;
        }

        if (FlxG.keys.justPressed.DOWN) selectedIndex += 1;
        if (FlxG.keys.justPressed.UP) selectedIndex -= 1;

        if (selectedIndex >= items.length) selectedIndex = items.length - 1;
        if (selectedIndex < 0) selectedIndex = 0;

        selectMenuItem();

        super.update(elapsed);
    }

    private inline function selectMenuItem() {
        var selectedText = items[selectedIndex];

        forEachOfType(MenuItem, function(item: MenuItem) {
            if (selectedText == item.text) {
                item.select();
            } else {
                item.deselect();
            }
        });
    }

    private inline function launchItem(text: String) {
        switch (text) {
            case "START": FlxG.switchState(new PlayState(saveService));
            case "HIGHSCORE": openSubState(new HighScoreSubState(saveService));
            case "RESET": saveService.resetHighScore();
            case "EXIT": openfl.Lib.close();
        }
    }
}
