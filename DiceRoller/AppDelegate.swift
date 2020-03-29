//
//  AppDelegate.swift
//  firstKT
//
//  Created by Riccardo Cipolleschi on 15/03/2020.
//

import UIKit
import Katana
import Tempura

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RootInstaller {

  var window: UIWindow?
  var store: Store<AppState, AppDependencies>?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Initialize the store
    self.store = Store<AppState, AppDependencies>(
      interceptors: [],
      stateInitializer: AppState.init)

    // create the window
    let window = UIWindow()
    self.window = window

    // Start the navigation
    self.store?.dependencies?.navigator.start(
      using: self,
      in: self.window!,
      at: "initialScreen"
    )

    window.makeKeyAndVisible()

    return true
  }

  // Required by the RootInstaller. It's the function invoked
  // by Tempura when it has to replace the rootViewController
  // It's the first step of the navigation.
  func installRoot(identifier: RouteElementIdentifier, context: Any?, completion: @escaping Navigator.Completion) -> Bool {
    if identifier == "initialScreen" {
      let vc = DiceRollerVC(store: self.store!, connected: true)
      self.window?.rootViewController = vc
      completion()
      return true
    }
    return false
  }
}

