package io.damo.openpang.interactions;


class InteractionsFactory {

    public static function create(): Interactions {
        #if FLX_KEYBOARD
        #if FLX_MOUSE
        return new KeyboardAndMouseInteractions();
        #end
        #end

        return new NoOpInteractions();
    }
}
