package io.damo.ninjapang.play;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import io.damo.ninjapang.AssetPaths;


class PlayerBuffs extends FlxSprite {

    private var player: Player;
    private var displayingShield = false;


    public function new(player: Player) {
        this.player = player;

        super(getX(), getY());

        hideShield();
    }

    override public function update(elapsed: Float) {
        x = getX();
        y = getY();

        if (player.shielded && !displayingShield) displayShield();

        if (!player.shielded && displayingShield) hideShield();
    }


    private inline function getX(): Float { return player.x - 10; }

    private inline function getY(): Float { return player.y - 3; }

    private inline function displayShield() {
        loadGraphic(AssetPaths.shield__png, false, Player.SIZE, Player.SIZE);
        displayingShield = true;
    }

    private inline function hideShield() {
        makeGraphic(Player.SIZE, Player.SIZE, FlxColor.TRANSPARENT);
        displayingShield = false;
    }
}
