package com.jeremyhaberman.cab;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MyActivity extends Activity
{
	// This is set by the release.sh build script
	private static final boolean PRODUCTION = false;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

		TextView constantValue = (TextView) findViewById(R.id.production_value);
		constantValue.setText(Boolean.toString(PRODUCTION));
    }
}
