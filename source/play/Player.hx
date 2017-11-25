package play;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Player extends FlxSprite {

    public static inline var SIZE = 128;
    private static inline var GRAVITY = 200;
    private static inline var HORIZONTAL_VELOCITY = 200;

    private var immune = false;


    public function new(x: Float, y: Float) {
        super(x, y);
        makeGraphic(SIZE, SIZE, FlxColor.BLACK);
        loadGraphic(AssetPaths.player__png, true, SIZE, SIZE);

        animation.add("normal", [0]);
        animation.add("shooting", [1]);
        animation.add("runningLeft", [2, 3, 4], 12, true, true);
        animation.add("runningRight", [2, 3, 4], 12, true, false);

        setSize(71, 114);
        offset.x = 25;
        offset.y = 13;

        velocity.y = GRAVITY;
        velocity.x = 0;
    }

    override public function update(elapsed: Float) {
        if (x < 0) x = 0;
        if (x + width > FlxG.width) x = FlxG.width - width;

        super.update(elapsed);
    }

    public function moveLeft() {
        velocity.x = -HORIZONTAL_VELOCITY;
        animation.play("runningLeft");
    }

    public function moveRight() {
        velocity.x = HORIZONTAL_VELOCITY;
        animation.play("runningRight");
    }

    public function stopMoving() {
        velocity.x = 0;
        animation.play("normal");
    }

    public function shoot(): Projectile {
        var projectileX = x + 38 - Projectile.WIDTH / 2;
        var projectileY = y + 120;

        animation.play("shooting");
        return new Projectile(projectileX, projectileY);
    }

    public function hit(): Bool {
        if (immune) {
            return false;
        }

        immune = true;

        new FlxTimer().start(2.0, function(_) {
            immune = false;
        });

        return true;
    }
}
