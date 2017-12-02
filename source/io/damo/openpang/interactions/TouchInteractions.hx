package io.damo.openpang.interactions;

import flixel.FlxG;
import haxe.ds.Option;
import io.damo.openpang.menu.MenuItem;

#if FLX_TOUCH
class TouchInteractions implements Interactions {

    public function new() {}

    public function skip(): Bool {
        return FlxG.touches.justReleased().length > 0;
    }

    public function accept(): Bool { return false; }

    public function up(): Bool { return false; }

    public function down(): Bool { return false; }

    public function left(): Bool {
        var touches = FlxG.touches.list;

        if (touches.length == 1) {
            return touches[0].x <= FlxG.width / 2;
        }

        return false;
    }

    public function right(): Bool {
        var touches = FlxG.touches.list;

        if (touches.length == 1) {
            return touches[0].x > FlxG.width / 2;
        }

        return false;
    }

    public function stopMoving(): Bool {
        return FlxG.touches.list.length == 0;
    }

    public function shoot(): Bool {
        var startedTouches = FlxG.touches.justStarted();
        var touches = FlxG.touches.list;

        return startedTouches.length == 1 && touches.length == 2;
    }

    public function selectedMenuItem(menuItems: Array<MenuItem>): Option<MenuItem> {
        var touches = FlxG.touches.justReleased();

        if (touches.length > 0) {
            var touchX = touches[0].x;
            var touchY = touches[0].y;

            for (item in menuItems) {
                var xInBounds = item.x <= touchX && touchX <= (item.x + item.width);
                var yInBounds = item.y <= touchY && touchY <= (item.y + item.height);

                if (xInBounds && yInBounds) {
                    return Option.Some(item);
                }
            }
        }

        return Option.None;
    }
}
#end
