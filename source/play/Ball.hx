package play;

import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxObject;
import flixel.util.FlxColor;

class Ball extends FlxShapeCircle {

    private static inline var GRAVITY = 200;
    private static inline var FALLING_SPEED = 300;

    private var size: BallSize;
    private var pixelSize: Float;
    private var horizontalVelocity: Float;
    private var weight: Float;

    public var score(default, null): Int;


    public function new(x: Float, y: Float, size: BallSize, direction: HorizontalDirection) {
        loadSize(size);

        super(x, y, pixelSize / 2.0, { color: FlxColor.TRANSPARENT }, FlxColor.RED);
        setSize(pixelSize, pixelSize);

        acceleration.y = weight;
        maxVelocity.set(0, FALLING_SPEED);
        velocity.y = -GRAVITY / 3;
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
                pixelSize = 64;
                weight = 80;
                horizontalVelocity = 60;
                score = 10;
            case BallSize.Medium:
                pixelSize = 32;
                weight = 100;
                horizontalVelocity = 50;
                score = 40;
            case BallSize.Small:
                pixelSize = 16;
                weight = 140;
                horizontalVelocity = 40;
                score = 80;
        }
    }
}
