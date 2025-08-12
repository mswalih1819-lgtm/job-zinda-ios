import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?
  private var initialLink: String?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: "app.channel.shared.data", binaryMessenger: controller.binaryMessenger)
    
    // Set up method channel handler
    methodChannel?.setMethodCallHandler({ [weak self] (call, result) in
      guard let self = self else { return }
      
      if call.method == "getInitialLink" {
        result(self.initialLink)
        self.initialLink = nil
      } else if call.method == "getSharedData" {
        result(nil) // No shared data in this context
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    
    // Check if app was launched from a deep link
    if let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL {
      self.initialLink = url.absoluteString
    } else if let userActivity = launchOptions?[UIApplication.LaunchOptionsKey.userActivity] as? NSUserActivity {
      if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
        self.initialLink = url.absoluteString
      }
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle Universal Links
  override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
      let deepLink = url.absoluteString
      methodChannel?.invokeMethod("getSharedData", arguments: deepLink)
    }
    return true
  }
  
  // Handle Custom URL Schemes
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    let deepLink = url.absoluteString
    methodChannel?.invokeMethod("getSharedData", arguments: deepLink)
    return true
  }
}
