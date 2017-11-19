package play;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import play.Ball.BallDirection;
import play.Ball.BallSize;

class PlayState extends FlxState {

    var map = new FlxTilemap();
    var balls = new FlxTypedGroup<Ball>();

    override public function create(): Void {
        super.create();

        var tiledMap = new TiledMap(AssetPaths.map__tmx);
        var mainLayer: TiledTileLayer = cast tiledMap.getLayer("main");
        var bgLayer: TiledTileLayer = cast tiledMap.getLayer("bg");
        var bg = new FlxTilemap();

        bg.loadMapFromArray(bgLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);
        map.loadMapFromArray(mainLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);

        balls.add(new Ball(30, 30,  BallSize.Big, BallDirection.Right, FlxColor.RED));
        balls.add(new Ball(100, 30, BallSize.Medium, BallDirection.Left, FlxColor.GREEN));
        balls.add(new Ball(100, 30, BallSize.Small, BallDirection.Right, FlxColor.YELLOW));

        add(bg);
        add(map);
        add(balls);
    }

    override public function update(elapsed: Float): Void {
        FlxG.collide(balls, map);
        super.update(elapsed);
    }
}
