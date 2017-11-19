package play;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite {

    private static inline var GRAVITY = 200;
    private static inline var HORIZONTAL_VELOCITY = 80;


    public function new(x: Float, y: Float) {
        super(x, y);
        setSize(16, 16);
        makeGraphic(16, 16, FlxColor.WHITE);

        velocity.y = GRAVITY;
        velocity.x = 0;
    }

    override public function update(elapsed: Float): Void {
        move();

        super.update(elapsed);
    }


    private inline function move(): Void {
        if (FlxG.keys.pressed.LEFT) velocity.x = -HORIZONTAL_VELOCITY;
        if (FlxG.keys.justReleased.LEFT) velocity.x = 0;
        if (FlxG.keys.pressed.RIGHT) velocity.x = HORIZONTAL_VELOCITY;
        if (FlxG.keys.justReleased.RIGHT) velocity.x = 0;
    }
}
