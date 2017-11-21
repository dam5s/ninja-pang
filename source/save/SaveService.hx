package save;

import flixel.util.FlxSave;


class SaveService {

    private static inline var GLOBAL_SAVE_DATA: String = "OpenPangGlobalSave";
    private var save = new FlxSave();


    public function new() {}

    public function saveHighScore(score: Int) {
        if (save.bind(GLOBAL_SAVE_DATA)) {
            if (save.data.highScore == null || save.data.highScore < score) {
                save.data.highScore = score;
            }
        }

        save.flush();
    }

    public function loadHighScore(): Int {
        if (save.bind(GLOBAL_SAVE_DATA)) {
            if (save.data != null && save.data.highScore != null) {
                return save.data.highScore;
            }
        }

        return 0;
    }
}
