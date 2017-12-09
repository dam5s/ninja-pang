package io.damo.ninjapang;


import io.damo.ninjapang.controls.Controls;
import io.damo.ninjapang.controls.ControlsFactory;

class Env {

    public static var instance(default, null) = new Env();

    public var saveService(default, null) = new SaveService();
    public var scoreBoard(default, null) = new ScoreBoard();
    public var controls(default, null) = ControlsFactory.create();


    public function new(?saveService: SaveService, ?controls: Controls) {
        this.saveService = saveService;
        this.controls = controls;
        this.scoreBoard = new ScoreBoard();

        if (saveService == null) {
            this.saveService = new SaveService();
        }
        if (controls == null) {
            this.controls = ControlsFactory.create();
        }
    }

    #if FLX_UNIT_TEST

    public static function loadEnv(saveService: SaveService, controls: Controls) {
        instance = new Env(saveService, controls);
    }
    #end

    public function resetScoreBoard(): ScoreBoard {
        scoreBoard = new ScoreBoard();
        return scoreBoard;
    }
}
