/*Requests the Agent ID for the agent identified by name from the dataserver. The name given may be either the current name of an avatar or a historical name that has been used in the past. If no agent can be found with the supplied name this function returns the value NULL_KEY.

More info here: http://wiki.secondlife.com/wiki/LlRequestUserKey
*/

//Global Variables//
integer listen_handle;
key wowQuery;
integer channel;

//Default State//
default {
    //Touch_Start event for when the item is touched//
    touch_start(integer total_number) {
        //random number channel
        channel = llRound(llFrand(10000));
        //set the llListen function to listen on channel for message from the key of the detected toucher
        listen_handle = llListen(channel, "", llDetectedKey(0), "");
        //Show the text box for them to put a message into
        llTextBox(llDetectedKey(0), "Name to find ID for (provided in the form \"First[ Last]\" or \"first[.last]\" (first name with an optional last name.))", channel);
    }
    //listen event which is a result of the llListen
    listen(integer channel, string name, key id, string message) {
        //remove the listener to help reduce lag
        llListenRemove(listen_handle);
        //query
        wowQuery = llRequestUserKey(message);


    }
    //query processing
    dataserver(key queryid, string data) {
        if (wowQuery == queryid) {
            //dialog
            llDialog(llDetectedKey(0), data, ["Done"], channel);
        }
    }
    //exiting script
    state_exit() {
        llOwnerSay("leaving default state");
    }
}
