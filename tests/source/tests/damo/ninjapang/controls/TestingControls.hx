package tests.damo.ninjapang.controls;

import haxe.ds.Option;
import io.damo.ninjapang.controls.Controls;
import io.damo.ninjapang.menu.MenuItem;


class TestingControls implements Controls {

    public function new() {}

    public function skip(): Bool { return false; }

    public function accept(): Bool { return false; }

    public function up(): Bool { return false; }

    public function down(): Bool { return false; }

    public function left(): Bool { return false; }

    public function right(): Bool { return false; }

    public function stopMoving(): Bool { return false; }

    public function shoot(): Bool { return false; }

    public function selectedMenuItem(menuItems: Array<MenuItem>): Option<MenuItem> { return Option.None; }
}
