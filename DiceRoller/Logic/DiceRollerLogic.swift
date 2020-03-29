//
//  DiceRollerLogic.swift
//  DiceRoller
//
//  Created by Riccardo Cipolleschi on 29/03/2020.
//

import Foundation
import Hydra
import Katana

enum DiceRollerLogic {
  struct RollDice: AnySideEffect {
    let die: AppState.DiceState.Die

    func sideEffect(_ context: AnySideEffectContext) throws {
      let extreme = die.rawValue
      let result = Int.random(in: 1...extreme)
      _ = try await(context.dispatch(UpdateCurrentResult(die: die, result: result)))
    }
  }

  fileprivate struct UpdateCurrentResult: StateUpdater {
    let die: AppState.DiceState.Die
    let result: Int

    func updateState(_ state: inout AppState) {
      // Update the history
      if let latestResult = state.diceState.currentResults[self.die] {
        if state.diceState.rollHistory[self.die] != nil {
          state.diceState.rollHistory[self.die]?.append(latestResult)
        } else {
          state.diceState.rollHistory[self.die] = [latestResult]
        }
      }

      // update the current result
      state.diceState.currentResults[self.die] = self.result
    }
  }
}
