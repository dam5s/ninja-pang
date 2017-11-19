package play;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Projectile extends FlxSprite {

    public static inline var WIDTH = 4;

    public function new(x: Float, y: Float) {
        super(x, y);
        setSize(WIDTH, FlxG.height);
        makeGraphic(WIDTH, FlxG.height, FlxColor.GRAY);

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
