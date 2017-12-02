package io.damo.openpang.menu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;
import haxe.ds.Option;
import io.damo.openpang.interactions.Interactions;
import io.damo.openpang.play.PlayState;


class MainMenuState extends FlxState {


    private var saveService: SaveService;
    private var interactions: Interactions;
    private var menuTexts: Array<String>;
    private var menuItems: Array<MenuItem>;
    private var selectedIndex: Int;

    override public function create() {
        super.create();

        saveService = Env.instance.saveService;
        interactions = Env.instance.interactions;

        add(new FlxSprite(0, 0, AssetPaths.mini_ninja_bg__png));

        selectedIndex = 0;
        menuTexts = ["START", "HIGHSCORE", "EXIT"];
        menuItems = [];

        for (i in 0...menuTexts.length) {
            var menuItem = new MenuItem(i, menuTexts.length, menuTexts[i]);
            menuItems.push(menuItem);
            add(menuItem);
        }
    }

    override public function update(elapsed: Float): Void {
        switch (interactions.selectedMenuItem(menuItems)) {
            case Option.Some(selectedItem):
                selectedIndex = menuTexts.indexOf(selectedItem.text);
                selectMenuItem();
                new FlxTimer().start(.3, function(_) launchItem(selectedItem.text));
            case Option.None:
            // do nothing;
        }

        if (interactions.accept()) {
            launchItem(menuTexts[selectedIndex]);
            return;
        }

        if (interactions.down()) selectedIndex += 1;
        if (interactions.up()) selectedIndex -= 1;

        if (selectedIndex >= menuTexts.length) selectedIndex = menuTexts.length - 1;
        if (selectedIndex < 0) selectedIndex = 0;

        selectMenuItem();

        super.update(elapsed);
    }

    private inline function selectMenuItem() {
        var selectedText = menuTexts[selectedIndex];

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
            case "START": FlxG.switchState(new PlayState());
            case "HIGHSCORE": openSubState(new HighScoreSubState());
            case "RESET": saveService.resetHighScore();
            case "EXIT": openfl.Lib.close();
        }
    }
}
