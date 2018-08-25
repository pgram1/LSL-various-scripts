default {
    money(key giver, integer amount) {
        string donor = llKey2Name(giver);
        llInstantMessage(giver, "Thank you, "+donor+", for your donation of "+(string)amount+"L$ !");
        llInstantMessage(llGetOwner(),donor + " has donated " + (string)amount + "L$ to you.");
    } 
}
