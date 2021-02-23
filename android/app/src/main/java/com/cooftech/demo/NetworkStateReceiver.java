package com.cooftech.demo;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import io.flutter.plugin.common.EventChannel;

public class NetworkStateReceiver extends BroadcastReceiver {
    public static boolean internet_status = false;

    public static void checkInternetConenction(Context context) {
        internet_status = false;
        ConnectivityManager check = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (check != null) {
            NetworkInfo[] info = check.getAllNetworkInfo();
            if (info != null)
                for (int i = 0; i < info.length; i++)
                {
                    if (info[i].getState() == NetworkInfo.State.CONNECTED) {

                        internet_status = true;
                    }
                }
            if(internet_status)
            {
                // Log.d("networkInfo", "Connected");
                sendData(context, "Connected");
            } else {
                // Log.d("networkInfo", "Not Connected");
                sendData(context, "Not Connected");
            }
        }
    }

    @Override
    public void onReceive(Context context, Intent intent)
    {
        try {
            checkInternetConenction(context);
        }catch(Exception e){
            Log.d("Error Tag", e.getMessage());
        }
    }

    private static void sendData(Context context, String data) {
        Intent local = new Intent();
        local.setAction("service.to.activity.transfer");
        local.putExtra("data", data);
        context.sendBroadcast(local);
    }

}
