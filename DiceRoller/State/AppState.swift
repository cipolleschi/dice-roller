//
//  AppState.swift
//  firstKT
//
//  Created by Riccardo Cipolleschi on 15/03/2020.
//

import Foundation
import Katana

/// The definition state of the app
struct AppState: State {
  /// Slice of the state for the Dice
  var diceState = DiceState()
}

extension AppState {
  /// Definition of the state of our dice rolls
  struct DiceState {
    /// Definition of the possible dice
    enum Die: Int {
      case d4 = 4
      case d6 = 6
      case d8 = 8
      case d10 = 10
      case d12 = 12
      case d20 = 20
      case d100 = 100
    }

    /// Map with the last roll of our dice
    var currentResults: [Die: Int] = [:]

    /// Map with the history of the rolls for every die
    var rollHistory: [Die: [Int]] = [:]
  }
}
