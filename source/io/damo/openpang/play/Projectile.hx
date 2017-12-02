package io.damo.openpang.play;

import flixel.FlxG;
import flixel.FlxSprite;
import io.damo.openpang.AssetPaths;


class Projectile extends FlxSprite {

    private var startingPoint: Float;

    public function new(x: Float, y: Float) {
        super(x, y);

        loadGraphic(AssetPaths.grappling__png, 6, FlxG.height);

        setSize(2, FlxG.height);
        offset.x = 2;

        startingPoint = y;
        velocity.y = -300;
    }

    override public function update(elapsed: Float): Void {
        if (y < 0) {
            kill();
            return;
        }

        super.update(elapsed);
    }
}
