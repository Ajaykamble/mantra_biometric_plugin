package com.ajaykamble.mantra_biometric;


import static org.json.JSONObject.wrap;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import org.json.*;

/** MantraBiometricPlugin */
public class MantraBiometricPlugin implements FlutterPlugin, MethodCallHandler , ActivityAware, PluginRegistry.ActivityResultListener{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private Activity act;
  private Result result;

  @Override
  public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mantra_biometric");
    channel.setMethodCallHandler(this);
  }


  @Override
  public void onMethodCall(MethodCall call, Result result) {
    this.result=result;
    switch(call.method)
    {
      case "getDeviceInfo":
        try {
          Intent intent = new Intent();
          intent.setAction("in.gov.uidai.rdservice.fp.INFO");
          act.startActivityForResult(intent, 1);
        }catch (Exception e){
          result.error( "ClientNotFound", e.getMessage(), "Install Client Application");
        }
        break;
      case "capture":
        try {
          String arguments=call.argument("pidOptions");
          Intent intent2 = new Intent();
          intent2.setAction("in.gov.uidai.rdservice.fp.CAPTURE");
          intent2.putExtra("PID_OPTIONS", arguments);
          act.startActivityForResult(intent2, 2);
        }catch (Exception e){
          result.error( "ClientNotFound", e.getMessage(), "Install Client Application");
        }
        break;
      default:
        result.notImplemented();
        break;
    }
  }
  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }



  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    act = activityPluginBinding.getActivity();
    activityPluginBinding.addActivityResultListener(this);
    context=activityPluginBinding.getActivity().getApplicationContext();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    act=null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    act = activityPluginBinding.getActivity();
    activityPluginBinding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivity() {

  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {

    switch (requestCode){
      case 1:
        if (resultCode == Activity.RESULT_OK) {
          try {
            String device_info = data.getStringExtra("DEVICE_INFO");
            String rdService = data.getStringExtra("RD_SERVICE_INFO");
            String display = "";

            if(device_info==null || rdService==null)
            {
              result.error("Error", "Unable to fetch device Information", "Unable to fetch device Information");
            }
            else {
              result.success(rdService);
            }
          } catch (Exception e) {
            result.error( "Error","Something Went Wrong", e.getMessage());
          }
        }
        break;
      case 2:
        if (resultCode == Activity.RESULT_OK) {
          try {
            if (data != null) {
              String intentResult = data.getStringExtra("PID_DATA");
              if (intentResult != null) {
                result.success(intentResult);
              }
              else{
                result.error( "Error", "Received Data Null", "PID DATA IS NULL");
              }
            }
            else{
              result.error("Error", "Unable to fetch device Information", "Unable to fetch device Information");
            }
          } catch (Exception e) {
            result.error( "Error", "Something Went Wrong", "Something Went Wrong");
          }
        }
        break;
    }

    return false;
  }
  public static JSONObject mapToJson(Map<?, ?> data)
  {
    JSONObject object = new JSONObject();

    for (Map.Entry<?, ?> entry : data.entrySet())
    {
      /*
       * Deviate from the original by checking that keys are non-null and
       * of the proper type. (We still defer validating the values).
       */
      String key = (String) entry.getKey();
      if (key == null)
      {
        throw new NullPointerException("key == null");
      }
      try
      {
        object.put(key, wrap(entry.getValue()));
      }
      catch (JSONException e)
      {
        e.printStackTrace();
      }
    }

    return object;
  }
}
