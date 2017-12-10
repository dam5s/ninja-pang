package tests.damo.ninjapang.controls;

import haxe.ds.Option;
import io.damo.ninjapang.controls.Controls;
import io.damo.ninjapang.menu.MenuItem;


class TestingControls implements Controls {

    public var mockedSkip: Bool;
    public var mockedAccept: Bool;
    public var mockedUp: Bool;
    public var mockedDown: Bool;
    public var mockedLeft: Bool;
    public var mockedRight: Bool;
    public var mockedStopMoving: Bool;
    public var mockedShoot: Bool;
    public var mockedSelectedMenuItem: Option<MenuItem>;

    public function new() {
        reset();
    }

    public function skip(): Bool { return mockedSkip; }

    public function accept(): Bool { return mockedAccept; }

    public function up(): Bool { return mockedUp; }

    public function down(): Bool { return mockedDown; }

    public function left(): Bool { return mockedLeft; }

    public function right(): Bool { return mockedRight; }

    public function stopMoving(): Bool { return mockedStopMoving; }

    public function shoot(): Bool { return mockedShoot; }

    public function selectedMenuItem(menuItems: Array<MenuItem>): Option<MenuItem> { return mockedSelectedMenuItem; }


    public function reset() {
        mockedSkip = false;
        mockedAccept = false;
        mockedUp = false;
        mockedDown = false;
        mockedLeft = false;
        mockedRight = false;
        mockedStopMoving = false;
        mockedShoot = false;
        mockedSelectedMenuItem = Option.None;
    }
}
