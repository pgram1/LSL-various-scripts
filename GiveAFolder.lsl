list inventory = [];
default { 
    state_entry() {
        integer i;
        for ( i = 0; i < llGetInventoryNumber(INVENTORY_ALL); i++) {
            string item = llGetInventoryName(INVENTORY_ALL, i);
            if (llGetInventoryPermMask(item, MASK_OWNER) & PERM_COPY) {
                inventory += [item];
            }
        }
        integer index =  llListFindList(inventory, [llGetScriptName()]);
        inventory = llDeleteSubList(inventory, index, index);
    }
    touch_start(integer total_number) { 
        llGiveInventoryList(llDetectedKey(0), llGetObjectName(), inventory); 
    } 
}
