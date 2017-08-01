package com.dawn.buildtypedawn.util3;

import android.util.Log;

/**
 * Created by 90449 on 2017/8/1.
 */

public class ThirdUtil {
    public void log(){
        Log.e("dawn", "third log");
        try{
            String name = null;
            name.toString();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
