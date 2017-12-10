package tests.damo.ninjapang.play;

import haxe.unit.TestCase;
import io.damo.ninjapang.Env;
import io.damo.ninjapang.play.Ball;
import io.damo.ninjapang.play.Player;
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
        var player: Player = findMemberOfType(Player);

        assertTrue(state.members.length > 0);
        assertEquals(1, findMembersOfType(Ball).length);
        assertEquals("idle", player.animation.name);
    }

    public function testPlayerMoving() {
        var player: Player = findMemberOfType(Player);

        controls.reset();
        controls.mockedLeft = true;
        state.update(0);

        assertEquals(-Player.HORIZONTAL_VELOCITY, player.velocity.x);
        assertEquals("runningLeft", player.animation.name);

        controls.reset();
        controls.mockedRight = true;
        state.update(0);

        assertEquals(Player.HORIZONTAL_VELOCITY, player.velocity.x);
        assertEquals("runningRight", player.animation.name);


        controls.reset();
        controls.mockedStopMoving = true;
        state.update(0);

        assertEquals(0.0, player.velocity.x);
        assertEquals("idle", player.animation.name);
    }


    private function findMemberOfType<T>(type: Class<T>): T {
        return findMembersOfType(type)[0];
    }

    private function findMembersOfType<T>(type: Class<T>): Array<T> {
        var members = new Array<T>();
        state.forEachOfType(type, function(member: T) members.push(member), true);
        return members;
    }
}
