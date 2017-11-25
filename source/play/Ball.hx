package play;

import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;

class Ball extends FlxShapeCircle {

    private static inline var GRAVITY = 400;
    private static inline var FALLING_SPEED = 500;

    private var size: BallSize;
    private var pixelSize: Float;
    private var horizontalVelocity: Float;
    private var initialVerticalVelocity: Float;
    private var weight: Float;

    public var score(default, null): Int;


    public function new(x: Float, y: Float, size: BallSize, direction: HorizontalDirection) {
        loadSize(size);

        super(x, y, pixelSize / 2.0, { color: FlxColor.TRANSPARENT }, FlxColor.RED);
        setSize(pixelSize, pixelSize);

        acceleration.y = weight;
        maxVelocity.set(0, FALLING_SPEED);

        velocity.y = initialVerticalVelocity;
        velocity.x = horizontalVelocity;

        if (direction == HorizontalDirection.Left) {
            velocity.x = -horizontalVelocity;
        }
    }

    override public function update(elapsed: Float): Void {
        if (justTouched(FlxObject.FLOOR)) {
            velocity.y = -GRAVITY;
        }

        if (x <= 0) {
            velocity.x = horizontalVelocity;
        }

        if (x + width >= FlxG.width) {
            velocity.x = -horizontalVelocity;
        }

        super.update(elapsed);
    }

    public function split(): Array<Ball> {
        var newBalls: Array<Ball>;

        switch(size) {
            case BallSize.Big:
                newBalls = [
                    new Ball(x - 10, y, BallSize.Medium, HorizontalDirection.Left),
                    new Ball(x + 10, y, BallSize.Medium, HorizontalDirection.Right)
                ];
            case BallSize.Medium:
                newBalls = [
                    new Ball(x - 10, y, BallSize.Small, HorizontalDirection.Left),
                    new Ball(x + 10, y, BallSize.Small, HorizontalDirection.Right)
                ];
            case BallSize.Small:
                newBalls = [];
        }

        kill();
        return newBalls;
    }


    private inline function loadSize(size: BallSize) {
        this.size = size;

        switch(size) {
            case BallSize.Big:
                pixelSize = 32;
                weight = GRAVITY;
                horizontalVelocity = 40;
                initialVerticalVelocity = -GRAVITY / 2;
                score = 10;
            case BallSize.Medium:
                pixelSize = 16;
                weight = GRAVITY * 1.5;
                horizontalVelocity = 60;
                initialVerticalVelocity = -GRAVITY / 3;
                score = 40;
            case BallSize.Small:
                pixelSize = 8;
                weight = GRAVITY * 2;
                horizontalVelocity = 80;
                initialVerticalVelocity = -GRAVITY / 4;
                score = 80;
        }
    }
}
