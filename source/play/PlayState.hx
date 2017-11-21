package play;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import play.BallSize;
import play.HorizontalDirection;
import play.Player;

class PlayState extends FlxState {

    private static inline var TILE_SIZE = 16;

    var map = new FlxTilemap();
    var balls = new FlxTypedGroup<Ball>();
    var projectiles = new FlxTypedGroup<Projectile>();
    var player: Player;


    override public function create(): Void {
        super.create();

        var tiledMap = new TiledMap(AssetPaths.map__tmx);
        var mainLayer: TiledTileLayer = cast tiledMap.getLayer("main");
        var bgLayer: TiledTileLayer = cast tiledMap.getLayer("bg");
        var bg = new FlxTilemap();

        bg.loadMapFromArray(bgLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);
        map.loadMapFromArray(mainLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);

        spawnBall(0.0, true);

        var playerX = (FlxG.width - Player.SIZE) / 2;
        var playerY = FlxG.height - Player.SIZE - TILE_SIZE;
        player = new Player(playerX, playerY);

        add(bg);
        add(projectiles);
        add(player);
        add(balls);
        add(map);
    }

    override public function update(elapsed: Float): Void {
        FlxG.collide(balls, map);
        FlxG.collide(player, map);
        FlxG.collide(projectiles, balls, collideProjectileAndBall);

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

    private inline function randomX(): Int {
        return 30 + Math.floor(Math.random() * FlxG.width - 60);
    }

    private inline function randomDirection(): HorizontalDirection {
        if (Math.random() > .5) {
            return HorizontalDirection.Right;
        }

        return HorizontalDirection.Left;
    }

    private function collideProjectileAndBall(projectile: Projectile, ball: Ball): Void {
        projectile.kill();

        for (newBall in ball.split()) {
            balls.add(newBall);
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
            var projectileX = player.x + Player.SIZE / 2 - Projectile.WIDTH / 2;
            var projectileY = player.y;

            projectiles.add(new Projectile(projectileX, projectileY));
        }
    }

    private inline function canShoot(): Bool {
        return projectiles.countLiving() < 2;
    }
}
