//
//  DiceRollerVC.swift
//  DiceRoller
//
//  Created by Riccardo Cipolleschi on 29/03/2020.
//

import Foundation
import Tempura

class DiceRollerVC: ViewController<DiceRollerView> {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func setupInteraction() {
    self.rootView.rollDieInteraction = { [unowned self] die in
      self.dispatch(DiceRollerLogic.RollDice(die: die))
    }
  }
}
