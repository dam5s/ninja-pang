package io.damo.ninjapang;

import flixel.FlxGame;
import openfl.display.Sprite;


class Main extends Sprite {

    public function new() {
        super();
        addChild(new FlxGame(640, 360, io.damo.ninjapang.menu.MainMenuState, 1, 60, 60, true));
    }
}
