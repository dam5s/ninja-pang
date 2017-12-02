package io.damo.ninjapang.interactions;


class InteractionsFactory {

    public static function create(): Interactions {
        #if FLX_KEYBOARD
        #if FLX_MOUSE
        return new KeyboardAndMouseInteractions();
        #end
        #end

        #if FLX_TOUCH
        return new TouchInteractions();
        #end

        return new NoOpInteractions();
    }
}
