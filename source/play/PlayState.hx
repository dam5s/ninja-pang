package play;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import gameover.GameOverState;
import play.BallSize;
import play.HorizontalDirection;
import play.Player;
import save.SaveService;

class PlayState extends FlxState {

    private static inline var TILE_SIZE = 16;
    private static inline var BALL_MAX_X = 640 - 16;
    private static inline var BALL_MIN_X = 16;

    private var saveService: SaveService;
    private var floor = new FlxSprite();
    private var balls = new FlxTypedGroup<Ball>();
    private var projectiles = new FlxTypedGroup<Projectile>();
    private var player: Player;
    private var scoreBoard: ScoreBoard;
    private var hud: HUD;

    public function new(saveService: SaveService) {
        super();
        this.saveService = saveService;
    }

    override public function create(): Void {
        super.create();

        var bg = new FlxSprite(0, 0);
        bg.immovable = true;
        bg.setSize(FlxG.width, FlxG.height);
        bg.loadGraphic(AssetPaths.bg__png);

        floor = new FlxSprite(0, FlxG.height - TILE_SIZE);
        floor.immovable = true;
        floor.setSize(FlxG.width, TILE_SIZE);
        floor.makeGraphic(FlxG.width, TILE_SIZE, FlxColor.TRANSPARENT);

        spawnBall(0.0, true);

        var playerX = (FlxG.width - Player.SIZE) / 2;
        var playerY = FlxG.height - Player.SIZE - TILE_SIZE;
        player = new Player(playerX, playerY);

        add(bg);
        add(projectiles);
        add(player);
        add(balls);
        add(floor);

        scoreBoard = new ScoreBoard();
        hud = new HUD(scoreBoard);
        add(hud);
    }

    override public function update(elapsed: Float): Void {
        FlxG.collide(balls, floor);
        FlxG.collide(player, floor);
        FlxG.collide(projectiles, balls, collideProjectileAndBall);
        FlxG.overlap(player, balls, hitPlayer);

        spawnBall(elapsed);
        movePlayer();
        shoot();

        super.update(elapsed);
    }


    private var timeSinceLastSpawn: Float = 0;
    private var spawnFrequency: Float = 5;

    private function spawnBall(elapsed: Float, force: Bool = false) {
        timeSinceLastSpawn += elapsed;

        if (timeSinceLastSpawn > spawnFrequency || force) {
            var x = randomX();
            var direction = randomDirection();

            balls.add(new Ball(x, 30, BallSize.Big, direction));
            timeSinceLastSpawn = 0;
        }
    }

    private function collideProjectileAndBall(projectile: Projectile, ball: Ball): Void {
        projectile.kill();
        scoreBoard.score += ball.score;

        for (newBall in ball.split()) {
            newBall.x = xWithinBoundaries(newBall.x);
            balls.add(newBall);
        }
    }

    private function hitPlayer(player: Player, ball: Ball) {
        if (player.hit()) {
            scoreBoard.lives -= 1;

            if (scoreBoard.lives < 0) {
                var isHighScore = saveService.saveHighScore(scoreBoard.score);
                FlxG.switchState(new GameOverState(scoreBoard.score, isHighScore));
            }
        }
    }


    private inline function movePlayer(): Void {
        if (FlxG.keys.pressed.LEFT) player.moveLeft();
        if (FlxG.keys.justReleased.LEFT) player.stopMoving();
        if (FlxG.keys.pressed.RIGHT) player.moveRight();
        if (FlxG.keys.justReleased.RIGHT) player.stopMoving();
    }

    private inline function shoot(): Void {
        if (FlxG.keys.justPressed.Z && canShoot()) {
            var projectile = player.shoot();

            projectiles.add(projectile);
        }
    }

    private inline function canShoot(): Bool {
        return projectiles.countLiving() < 2;
    }

    private inline function randomX(): Int {
        return 128 + Math.floor(Math.random() * FlxG.width - 256);
    }

    private inline function randomDirection(): HorizontalDirection {
        if (Math.random() > .5) {
            return HorizontalDirection.Right;
        }

        return HorizontalDirection.Left;
    }

    private inline function xWithinBoundaries(x: Float): Float {
        if (x < BALL_MIN_X) return BALL_MIN_X;
        if (x > BALL_MAX_X) return BALL_MAX_X;
        return x;
    }
}
