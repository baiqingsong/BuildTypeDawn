package com.dawn.buildtypedawn.util;

import android.util.Log;

/**
 * Created by 90449 on 2017/8/1.
 */

public class FirstUtil {
    public void log(String message){
        Log.e("dawn", "first log " + message);
        try{
            String name = null;
            name.toString();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
