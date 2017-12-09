package tests.damo.ninjapang;

import flash.system.System;
import tests.damo.ninjapang.play.GameTest;


class Main {

    public static function main() {
        var runner = new haxe.unit.TestRunner();

        runner.add(new GameTest());
        var result = runner.run();

        if (result) {
            System.exit(0);
        }

        System.exit(1);
    }
}
