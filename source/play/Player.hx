package play;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite {

    public static inline var SIZE = 16;
    private static inline var GRAVITY = 200;
    private static inline var HORIZONTAL_VELOCITY = 120;


    public function new(x: Float, y: Float) {
        super(x, y);
        setSize(SIZE, SIZE);
        makeGraphic(SIZE, SIZE, FlxColor.WHITE);

        velocity.y = GRAVITY;
        velocity.x = 0;
    }

    public function moveLeft(): Void {
        velocity.x = -HORIZONTAL_VELOCITY;
    }

    public function moveRight(): Void {
        velocity.x = HORIZONTAL_VELOCITY;
    }

    public function stopMoving(): Void {
        velocity.x = 0;
    }
}
