package interactions;

import flixel.FlxG;
import haxe.ds.Option;
import menu.MenuItem;


#if FLX_KEYBOARD
#if FLX_MOUSE
class KeyboardAndMouseInteractions implements Interactions {

    public function new() {}

    public function skip(): Bool {
        var justPressed = FlxG.keys.justPressed;
        return justPressed.Z || justPressed.X || justPressed.ENTER || justPressed.ESCAPE;
    }

    public function accept(): Bool {
        var justPressed = FlxG.keys.justPressed;
        return justPressed.Z || justPressed.ENTER;
    }

    public function up(): Bool {
        return FlxG.keys.justPressed.UP;
    }

    public function down(): Bool {
        return FlxG.keys.justPressed.DOWN;
    }

    public function left(): Bool {
        return FlxG.keys.justPressed.LEFT;
    }

    public function right(): Bool {
        return FlxG.keys.justPressed.RIGHT;
    }

    public function stopMoving(): Bool {
        return FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.LEFT;
    }

    public function shoot(): Bool {
        return FlxG.keys.justPressed.Z;
    }

    public function selectedMenuItem(menuItems: Array<MenuItem>): Option<MenuItem> {
        if (FlxG.mouse.justReleased) {
            var mouseX = FlxG.mouse.x;
            var mouseY = FlxG.mouse.y;

            for (item in menuItems) {
                var xInBounds = item.x <= mouseX && mouseX <= (item.x + item.width);
                var yInBounds = item.y <= mouseY && mouseY <= (item.y + item.height);

                if (xInBounds && yInBounds) {
                    return Option.Some(item);
                }
            }
        }

        return Option.None;
    }
}
#end
#end
