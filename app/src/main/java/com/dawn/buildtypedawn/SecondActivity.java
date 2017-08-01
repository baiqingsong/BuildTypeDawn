package com.dawn.buildtypedawn;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;

import com.dawn.buildtypedawn.util2.SecondUtil;

/**
 * Created by 90449 on 2017/8/1.
 */

public class SecondActivity extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        new SecondUtil().log();
    }
}
