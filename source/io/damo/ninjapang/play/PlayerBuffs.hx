package io.damo.ninjapang.play;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import io.damo.ninjapang.AssetPaths;


class PlayerBuffs extends FlxSprite {

    public var displayingShield(default, null) = false;

    public function new() {
        super();
        hideShield();
    }

    public function displayShield() {
        loadGraphic(AssetPaths.shield__png, false, Player.SIZE, Player.SIZE);
        displayingShield = true;
    }

    public function hideShield() {
        makeGraphic(Player.SIZE, Player.SIZE, FlxColor.TRANSPARENT);
        displayingShield = false;
    }
}
