integer channel;
integer price = 1;
default {
    // reset script when the object is rezzed
    on_rez(integer start_param) {
        llResetScript();
    }
    changed(integer change) {
        // reset script when the owner or the inventory changed
        if (change & (CHANGED_OWNER | CHANGED_INVENTORY)) llResetScript();
    }
    state_entry() {
        vector COLOR_GREEN = < 0.0, 1.0, 0.0 > ;
        float OPAQUE = 1.0;
        llSetText(llGetObjectDesc(), COLOR_GREEN, OPAQUE);
        llSetPayPrice(PAY_HIDE, [PAY_HIDE, PAY_HIDE, PAY_HIDE, PAY_HIDE]);
        llRequestPermissions(llGetOwner(), PERMISSION_DEBIT);
        llSetClickAction(CLICK_ACTION_PAY);
    }
    run_time_permissions(integer perm) {
        if (perm & PERMISSION_DEBIT) llSetPayPrice(PAY_HIDE, [price]);
        state cash;
    }
}
state cash {
    collision(integer num_detected) {
        channel = llRound(llFrand(10000));
        llDialog(llDetectedKey(0), "If you roll 6 I'll give you back 2 Lindens, pay me L$1 and watch the chat.", ["Ok"], channel);
    }
    touch_start(integer num_detected) {
        channel = llRound(llFrand(10000));
        llDialog(llDetectedKey(0), "If you roll 6 I'll give you back 2 Lindens, pay me L$1 and watch the chat.", ["Ok"], channel);
    }
    money(key id, integer amount) {
        if (amount < price) { // Customer has not paid enough
            llInstantMessage(id, "That's not enough money.");
            llGiveMoney(id, amount); // Refund the money they paid
            return;
        }
        if (amount > price) { // Customer paid too much. Refund the excess
            integer change = amount - price;
            llInstantMessage(id, "You paid more than L$" + (string) price + "  your change is L$" + (string) change);
            llGiveMoney(id, change);
        }
        // Customer has paid at least the right amount. Proceed with the roll.
        llInstantMessage(id, "Rolling!");
        integer result = llRound(llFrand(5)) + 1;
        llInstantMessage(id, "You rolled " + (string) result);
        if (result == 6) {
            llInstantMessage(id, "You won!");
            llGiveMoney(id, 2);
        } else {
            llInstantMessage(id, "Sorry, try again");
        }
    }
}
