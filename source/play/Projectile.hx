package play;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Projectile extends FlxSprite {

    public static inline var WIDTH = 4;
    private var startingPoint: Float;

    public function new(x: Float, y: Float) {
        super(x, y);
        setSize(WIDTH, 0);
        makeGraphic(WIDTH, 0, FlxColor.BLUE);

        startingPoint = y;
        velocity.y = -300;
    }

    override public function update(elapsed: Float): Void {
        if (y < 0) {
            kill();
            return;
        }

        setSize(WIDTH, startingPoint - y);
        makeGraphic(WIDTH, Math.floor(startingPoint - y), FlxColor.BLUE);

        super.update(elapsed);
    }
}
