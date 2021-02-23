package com.cooftech.demo;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import java.util.concurrent.TimeUnit;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;


public class MainActivity extends FlutterActivity {
    public static final String TAG = "eventchannelsample";
    public static final String STREAM = "eventchannelsample";
    private NetworkStateReceiver mNetworkReceiver;
    private BroadcastReceiver updateUIReciver;
    private Disposable timerSubscription;
    private Handler mainHandler = new Handler(Looper.getMainLooper());
    private EventChannel.EventSink events;



    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), STREAM).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, EventChannel.EventSink events) {
                        MainActivity.this.events = events;
                        Log.w(TAG, "adding listener");
//                        timerSubscription = Observable
//                                .interval(0, 1, TimeUnit.SECONDS)
//                                .observeOn(AndroidSchedulers.mainThread())
//                                .subscribe(
//                                        (Long timer) -> {
//                                            Log.w(TAG, "emitting timer event " + timer);
//                                            events.success(timer);
//                                        },
//                                        (Throwable error) -> {
//                                            Log.e(TAG, "error in emitting timer", error);
//                                            events.error("STREAM", "Error in processing observable", error.getMessage());
//                                        },
//                                        () -> Log.w(TAG, "closing the timer observable")
//                                );
                    }

                    @Override
                    public void onCancel(Object args) {
                        Log.w(TAG, "cancelling listener");
                        if (timerSubscription != null) {
                            timerSubscription.dispose();
                            timerSubscription = null;
                        }
                    }
                }
        );

        mNetworkReceiver = new NetworkStateReceiver();
        IntentFilter filter = new IntentFilter();
        filter.addAction("service.to.activity.transfer");
        updateUIReciver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (intent != null) {
                    Toast.makeText(context, intent.getStringExtra("data"), Toast.LENGTH_LONG).show();
                    if(MainActivity.this.events != null){
                        sendEvent(intent.getStringExtra("data"));
                    }
                }
            }
        };
        registerReceiver(updateUIReciver, filter);


    }


    private void sendEvent(String data) {
        Runnable runnable =
                new Runnable() {
                    @Override
                    public void run() {
                        MainActivity.this.events.success(data);
                    }
                };
        mainHandler.post(runnable);
    }

    @Override
    protected void onPause() {
        super.onPause();
        try {
            if (mNetworkReceiver != null) {
                unregisterReceiver(mNetworkReceiver);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        registerReceiver(mNetworkReceiver, new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));
    }


}
