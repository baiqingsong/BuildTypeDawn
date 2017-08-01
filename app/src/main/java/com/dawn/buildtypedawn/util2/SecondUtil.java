package com.dawn.buildtypedawn.util2;

import android.util.Log;

/**
 * Created by 90449 on 2017/8/1.
 */

public class SecondUtil {
    public void log(){
        Log.e("dawn", "second log");
        try{
            String name = null;
            name.toString();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
