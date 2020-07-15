integer channel;
default {

    touch_start(integer num_detected) {
        llResetTime();
        channel = llRound(llFrand(10000));
        llSetTimerEvent(0);
        llDialog(llDetectedKey(0), "Touch me for more than 2 seconds to start, else I'll stop", ["Ok"], channel);
    }
    touch_end(integer num_detected) {
        if (llGetTime() >= 2) {
            llSetTimerEvent(2);
        }
    }

    timer() {
        llSetLinkPrimitiveParamsFast(-4, [PRIM_SIZE, < 10.0, 10.0, 10.0 > ]);
        llSleep(1.0);
        llSetLinkPrimitiveParamsFast(-4, [PRIM_SIZE, < 1.0, 1.0, 1.0 > ]);
    }
}
