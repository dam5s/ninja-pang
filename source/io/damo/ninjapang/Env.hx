package io.damo.ninjapang;


import io.damo.ninjapang.interactions.Interactions;
import io.damo.ninjapang.interactions.InteractionsFactory;

class Env {

    public static var instance(default, null) = new Env();

    public var saveService(default, null) = new SaveService();
    public var scoreBoard(default, null) = new ScoreBoard();
    public var interactions(default, null) = InteractionsFactory.create();


    public function new(?saveService: SaveService, ?interactions: Interactions) {
        this.saveService = saveService;
        this.interactions = interactions;
        this.scoreBoard = new ScoreBoard();

        if (saveService == null) {
            this.saveService = new SaveService();
        }
        if (interactions == null) {
            this.interactions = InteractionsFactory.create();
        }
    }

    public function resetScoreBoard(): ScoreBoard {
        scoreBoard = new ScoreBoard();
        return scoreBoard;
    }
}
