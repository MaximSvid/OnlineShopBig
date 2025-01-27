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
    
//    func application(_ application: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url)
//    }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // dark mode
    


  var body: some Scene {
    WindowGroup {
      NavigationView {
          AuthWrapper()
      }
      .preferredColorScheme(isDarkMode ? .dark : .light) // dark mode
    }
  }
}
