package io.damo.ninjapang.play;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Ball extends FlxSprite {

    private static inline var GRAVITY = 200;
    private static inline var FALLING_SPEED = 250;

    private var size: BallSize;
    private var hitBoxSize: Float;
    private var graphicSize: Int;
    private var asset: FlxGraphicAsset;
    private var horizontalVelocity: Float;
    private var weight: Float;

    public var score(default, null): Int;


    public function new(x: Float, y: Float, size: BallSize, direction: HorizontalDirection) {
        super(x, y);

        loadSize(size);
        loadGraphic(asset, true, graphicSize, graphicSize);
        setSize(hitBoxSize, hitBoxSize);
        offset.x = 2;
        offset.y = 2;

        animation.add("idle", [0]);
        animation.add("bounce", [1, 0], 12, false);
        animation.play("idle");

        acceleration.y = weight;
        maxVelocity.set(0, FALLING_SPEED);

        velocity.y = -GRAVITY / 2;
        velocity.x = horizontalVelocity;

        if (direction == HorizontalDirection.Left) {
            velocity.x = -horizontalVelocity;
        }
    }

    override public function update(elapsed: Float): Void {
        if (justTouched(FlxObject.FLOOR)) {
            velocity.y = -GRAVITY;
            animation.play("bounce");
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
                hitBoxSize = 32;
                graphicSize = 36;
                asset = AssetPaths.big_ball__png;

                weight = GRAVITY;
                horizontalVelocity = 20;

                score = 50;

            case BallSize.Medium:
                hitBoxSize = 16;
                graphicSize = 20;
                asset = AssetPaths.medium_ball__png;

                weight = GRAVITY * 1.5;
                horizontalVelocity = 40;

                score = 100;

            case BallSize.Small:
                hitBoxSize = 8;
                graphicSize = 12;
                asset = AssetPaths.small_ball__png;

                weight = GRAVITY * 2;
                horizontalVelocity = 60;

                score = 200;
        }
    }
}
