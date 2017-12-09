package tests.damo.ninjapang.play;

import haxe.unit.TestCase;
import io.damo.ninjapang.Env;
import io.damo.ninjapang.play.Ball;
import io.damo.ninjapang.play.PlayState;
import io.damo.ninjapang.SaveService;
import tests.damo.ninjapang.controls.TestingControls;


class GameTest extends TestCase {

    var saveService: SaveService;
    var controls: TestingControls;
    var state: PlayState;

    public function new() {
        super();
    }

    override public function setup(): Void {
        saveService = new SaveService();
        controls = new TestingControls();

        Env.loadEnv(saveService, controls);

        state = new PlayState();
        state.create();
    }


    public function testCreation() {
        assertTrue(state.members.length > 0);
        assertEquals(1, findMembersOfType(Ball).length);
    }


    private function findMembersOfType<T>(type: Class<T>): Array<T> {
        var members = new Array<T>();
        state.forEachOfType(type, function(member: T) members.push(member), true);
        return members;
    }
}
