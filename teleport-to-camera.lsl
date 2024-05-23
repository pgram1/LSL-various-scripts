// Teleport to Camera Location
//
// Instructions:
// Insert this script in a small prim.
// Attach the prim to any convenient HUD position.
// Touch the prim to teleport to the current camera location.  
default {     
    attach(key id) { 
        // If we're attaching, initialize
        if (id) { 
          llRequestPermissions(llGetOwner(), PERMISSION_ATTACH | PERMISSION_TRACK_CAMERA );
          llSetColor(<1.0, 1.0, 1.0>,ALL_SIDES);
        } 
    }
    
    // Sort through required permissions.
    run_time_permissions(integer perm) { 
        if (perm & PERMISSION_ATTACH | PERMISSION_TRACK_CAMERA) { 
            llOwnerSay("Camera enabled.");
        }
        else {
            llOwnerSay("Camera refused.  Detaching.");
            llDetachFromAvatar();
        }
    }
    
    // Teleport!
    touch_start(integer total_number) {
        llSetColor(<1.0, 1.0, 1.0>,ALL_SIDES);
        
        vector CamPos = llGetCameraPos();
        rotation CamRot = llGetCameraRot();
        vector CamFoc = CamPos + llRot2Fwd(CamRot);
        
        llOwnerSay("Teleporting to camera position on " + llGetRegionName() + ": " + (string) CamPos);
        llMapDestination(llGetRegionName(), CamPos, CamFoc);
        llSetColor(<1.0, 1.0, 1.0>,ALL_SIDES);
    }
}
