package io.damo.ninjapang.controls;


class ControlsFactory {

    public static function create(): Controls {
        #if FLX_KEYBOARD
        #if FLX_MOUSE
        return new KeyboardAndMouseControls();
        #end
        #end

        #if FLX_TOUCH
        return new TouchControls();
        #end

        return new NoOpControls();
    }
}
