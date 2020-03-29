//
//  DiceRollerView.swift
//  DiceRoller
//
//  Created by Riccardo Cipolleschi on 29/03/2020.
//

import Foundation
import Tempura

struct DiceRollerVM: ViewModelWithState {

  private let currentResults: [AppState.DiceState.Die: Int]

  init(state: AppState) {
    self.currentResults = state.diceState.currentResults
  }

  func result(for die: AppState.DiceState.Die) -> String {
    guard let result = self.currentResults[die] else {
      return "-"
    }
    return "\(result)"
  }
}

class DiceRollerView: UIView, ViewControllerModellableView {
  typealias VM = DiceRollerVM

  // MARK: - Helper Class
  /// Small helper class that simplify the logic
  private class DieButton: UIButton {
    let die: AppState.DiceState.Die
    required init(die: AppState.DiceState.Die) {
      self.die = die
      super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
      fatalError("Do not use this method")
    }
  }

/// Small helper class that simplify the logic
  private class DieLabel: UILabel {
    let die: AppState.DiceState.Die
    required init(die: AppState.DiceState.Die) {
      self.die = die
      super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
      fatalError("Do not use this method")
    }
  }

  // MARK: - Variable Declaration
  /// The buttons the user can press to roll a specific die
  private var buttons = [DieButton(die: .d4),
                         DieButton(die: .d6),
                         DieButton(die: .d8),
                         DieButton(die: .d10),
                         DieButton(die: .d12),
                         DieButton(die: .d20),
                         DieButton(die: .d100)]

  /// The labels where we will render the results
  private var labels = [DieLabel(die: .d4),
                        DieLabel(die: .d6),
                        DieLabel(die: .d8),
                        DieLabel(die: .d10),
                        DieLabel(die: .d12),
                        DieLabel(die: .d20),
                        DieLabel(die: .d100)]

  var rollDieInteraction: CustomInteraction<AppState.DiceState.Die>?

  // MARK: - Setup

  func setup() {
    self.buttons.forEach {
      self.addSubview($0)
      $0.addTarget(self, action: #selector(self.userDidTapRollDie(_:)), for: .touchUpInside)
    }
    self.labels.forEach { self.addSubview($0) }
  }

  @objc func userDidTapRollDie(_ sender: UIControl) {
    guard let dieButton = sender as? DieButton else {
      return
    }
    self.rollDieInteraction?(dieButton.die)
  }

  // MARK: - Style

  func style() {
    self.backgroundColor = .white
    self.buttons.forEach { self.styleDieButton($0) }
  }

  private func styleDieButton(_ button: DieButton) {
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.setTitle("Roll a d\(button.die.rawValue)", for: .normal)
    button.layer.cornerRadius = 5
  }

  // MARK: - Update

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }
    self.labels.forEach { self.styleResultLabel($0, with: model.result(for: $0.die))}
    self.setNeedsLayout()
  }

  private func styleResultLabel(_ label: DieLabel, with text: String) {
    label.textAlignment = .center
    label.textColor = .label
    label.text = text
    label.font = UIFont.systemFont(ofSize: 18)
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    // Variables for Layout
    let buttonSize = CGSize(width: 150, height: 40)
    let xOrigin: CGFloat = 20
    let ySpacing: CGFloat = 10

    // Layout the buttons
    for (index, button) in self.buttons.enumerated() {
      if index == 0 {
        button.frame = CGRect(origin: CGPoint(x: xOrigin, y: self.safeAreaInsets.top + ySpacing),
                              size: buttonSize)

      } else {
        let previousButton = self.buttons[index - 1]
        let y = previousButton.frame.maxY + ySpacing
        button.frame = CGRect(origin: CGPoint(x: xOrigin, y: y),
                              size: buttonSize)
      }

      // Layout the labels

      let label = self.labels[index]
      label.frame = .zero
      label.sizeToFit() // after resetting the frame to zero, it computes the label size
      let labelOrigin = CGPoint(x: self.bounds.width - xOrigin - label.frame.width,
                                y: button.frame.minY)
      label.frame = CGRect(origin: labelOrigin,
                           size: label.frame.size)
    }
  }
}

