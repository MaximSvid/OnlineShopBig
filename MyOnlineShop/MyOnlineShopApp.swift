//
//  MyOnlineShopApp.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.12.24.
//

import SwiftUI
import FirebaseCore
import Firebase
//import AlertToast
//import Toasts
//import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    


  var body: some Scene {
    WindowGroup {
      NavigationView {
          AuthWrapper()
      }
    }
  }
}
