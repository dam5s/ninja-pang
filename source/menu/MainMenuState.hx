package menu;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import haxe.ds.Option;
import interactions.InteractionsFactory;
import play.PlayState;
import save.SaveService;
import ui.AssetsSupport;


class MainMenuState extends FlxState {

    private var saveService = new SaveService();
    private var interactions = InteractionsFactory.create();

    private var menuItems: Array<MenuItem> = [];
    private var items = ["START", "HIGHSCORE", "EXIT"];
    private var selectedIndex = 0;

    override public function create(): Void {
        add(AssetsSupport.buildBgSprite());

        for (i in 0...items.length) {
            var menuItem = new MenuItem(i, items.length, items[i]);
            menuItems.push(menuItem);
            add(menuItem);
        }
    }

    override public function update(elapsed: Float): Void {
        switch (interactions.selectedMenuItem(menuItems)) {
            case Option.Some(selectedItem):
                selectedIndex = items.indexOf(selectedItem.text);
                selectMenuItem();
                new FlxTimer().start(.3, function(_) launchItem(selectedItem.text));
            case Option.None:
            // do nothing;
        }

        if (interactions.accept()) {
            launchItem(items[selectedIndex]);
            return;
        }

        if (interactions.down()) selectedIndex += 1;
        if (interactions.up()) selectedIndex -= 1;

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
            case "START": FlxG.switchState(new PlayState(saveService, interactions));
            case "HIGHSCORE": openSubState(new HighScoreSubState(saveService, interactions));
            case "RESET": saveService.resetHighScore();
            case "EXIT": openfl.Lib.close();
        }
    }
}
