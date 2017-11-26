package play;

import AssetPaths;
import flixel.FlxSprite;

class Projectile extends FlxSprite {

    private var startingPoint: Float;

    public function new(x: Float, y: Float) {
        super(x, y);

        loadGraphic(AssetPaths.grappling__png, 6, 400);

        setSize(2, 400);
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
