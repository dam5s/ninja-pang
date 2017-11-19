package play;

import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxObject;
import flixel.util.FlxColor;

class Ball extends FlxShapeCircle {

    private static inline var GRAVITY = 200;
    private static inline var FALLING_SPEED = 300;

    private var pixelSize: Float;
    private var horizontalVelocity: Float;
    private var weight: Float;


    public function new(x: Float, y: Float, size: BallSize, direction: HorizontalDirection, color: FlxColor) {
        loadSize(size);

        super(x, y, pixelSize / 2.0, { color: FlxColor.TRANSPARENT }, color);
        setSize(pixelSize, pixelSize);

        acceleration.y = weight;
        maxVelocity.set(0, FALLING_SPEED);
        velocity.y = GRAVITY;
        velocity.x = horizontalVelocity;

        if (direction == HorizontalDirection.Left) {
            velocity.x = -horizontalVelocity;
        }
    }

    override public function update(elapsed: Float): Void {
        if (justTouched(FlxObject.FLOOR)) {
            velocity.y = -GRAVITY;
        }

        if (justTouched(FlxObject.LEFT)) {
            velocity.x = horizontalVelocity;
        }

        if (justTouched(FlxObject.RIGHT)) {
            velocity.x = -horizontalVelocity;
        }

        super.update(elapsed);
    }


    private inline function loadSize(size: BallSize) {
        switch(size) {
            case BallSize.Big:
                pixelSize = 64;
                weight = 80;
                horizontalVelocity = 60;
            case BallSize.Medium:
                pixelSize = 32;
                weight = 100;
                horizontalVelocity = 50;
            case BallSize.Small:
                pixelSize = 16;
                weight = 140;
                horizontalVelocity = 40;
        }
    }
}
