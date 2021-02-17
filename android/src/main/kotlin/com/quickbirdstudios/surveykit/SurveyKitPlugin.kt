package com.quickbirdstudios.surveykit

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin

class SurveyKitPlugin: FlutterPlugin {

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
   //We dont net to attach something 
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    //We dont need to detach something
  }
}