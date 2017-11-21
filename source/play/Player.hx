package play;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Player extends FlxSprite {

    public static inline var SIZE = 32;
    private static inline var GRAVITY = 200;
    private static inline var HORIZONTAL_VELOCITY = 120;

    private var immune = false;


    public function new(x: Float, y: Float) {
        super(x, y);
        loadGraphic(AssetPaths.player_sheet__png, true, 32, 32);

        animation.add("normal", [0]);
        animation.add("hit", [0, 1], 12);
        animation.play("normal");

        setSize(SIZE, SIZE);

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

    public function hit(): Bool {
        if (immune) {
            return false;
        }

        immune = true;
        animation.play("hit");

        new FlxTimer().start(2.0, function(_) {
            immune = false;
            animation.play("normal");
        });

        return true;
    }
}
