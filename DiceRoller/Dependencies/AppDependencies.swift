//
//  AppDependencies.swift
//  DiceRoller
//
//  Created by Riccardo Cipolleschi on 22/03/2020.
//

import Foundation
import Katana
import Tempura

/// The Container for the dependencies of the App
class AppDependencies:
  SideEffectDependencyContainer,
  NavigationProvider
{

  // The dispatch function that can be used to dispatch
  // SideEffects and State Updater
  let dispatch: PromisableStoreDispatch
  // A closure that returns the most updated version of the state
  let getState: GetState
  // An object that helps to manage the navigation
  let navigator: Navigator

  /// Initializer for the AppDependencies
  /// - parameter dispatch: the dispatch function that the dependencies must use
  /// - parameter getState: the closure that will return the most updated state
  required init(dispatch: @escaping PromisableStoreDispatch, getState: @escaping GetState) {
    self.dispatch = dispatch
    self.getState = getState
    self.navigator = Navigator()
  }
}
