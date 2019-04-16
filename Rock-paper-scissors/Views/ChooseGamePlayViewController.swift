//
//  ViewController.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import UIKit

fileprivate struct Consts {
    struct ContainerView {
        static let conerRadius:CGFloat = 10
        struct Shadow {
            struct Offset {
                static let width = 0
                static let height = 2
            }
            static let radius:CGFloat = 0.9
            static let opacity:Float = 0.2
        }
    }
    
    static let defaultStepperDisplayValue = "1"
}

class ChooseGamePlayViewController: UIViewController {
    
    @IBOutlet weak var choosePlayerView: UIView!
    @IBOutlet weak var choosePlayerLabel: UILabel!
    @IBOutlet weak var choosePlayerPicker: UIPickerView!
    
    @IBOutlet weak var chooseGamePlayView: UIView!
    @IBOutlet weak var chooseGamePlayLabel: UILabel!
    @IBOutlet weak var stepperView: UIStepper!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    fileprivate var pickerRowsLabel:[String] = []
    fileprivate let viewModel = ChooseGameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupTexts()
        setupPicker()
        setupStepper()
        setupStart()
    }
    
    private func setupUI() {
        // Player part
        designPods(choosePlayerView)
        
        // Game play part
        designPods(chooseGamePlayView)
        numberOfRoundsLabel.text = Consts.defaultStepperDisplayValue
        
        designPods(startButton)
    }
    
    private func designPods(_ views:UIView) {
        views.layer.cornerRadius = Consts.ContainerView.conerRadius
        views.layer.shadowOffset = CGSize(width: Consts.ContainerView.Shadow.Offset.width, height: Consts.ContainerView.Shadow.Offset.height)
        views.layer.shadowRadius = Consts.ContainerView.Shadow.radius
        views.layer.shadowOpacity = Consts.ContainerView.Shadow.opacity
        views.layer.shadowColor = UIColor.black.cgColor
    }

    private func setupTexts() {
        // Player part
        choosePlayerLabel.text = NSLocalizedString("choose-player",value: "Choose the player", comment: "")
        
        
        pickerRowsLabel.append(NSLocalizedString("player-vs-computer",value: "Player vs Player", comment: ""))
        pickerRowsLabel.append(NSLocalizedString("computer-vs-computer",value: "Computer vs Computer", comment: ""))
        
        // Game play part
        chooseGamePlayLabel.text = NSLocalizedString("choose-gameplay",value: "Choose the game play", comment: "")
        startButton.titleLabel?.text = NSLocalizedString("start-game",value: "Start", comment: "")
    }
}

// MARK: Picker control
extension ChooseGamePlayViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    fileprivate func setupPicker() {
        choosePlayerPicker.delegate = self
        choosePlayerPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerRowsLabel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerRowsLabel[row]
    }
}

// MARK: step control
extension ChooseGamePlayViewController {
    fileprivate func setupStepper() {
        stepperView.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
    }
    
    @objc func stepperChanged(_ sender:UIStepper) {
        numberOfRoundsLabel.text = "\(Int(sender.value))"
    }
}

// MARK: start control
extension ChooseGamePlayViewController {
    fileprivate func setupStart() {
        startButton.addTarget(self, action: #selector(startPressed), for: .touchDown)
    }
    
    @objc func startPressed(_ sender:UIButton) {
        // get settings
        let selectedRow = choosePlayerPicker.selectedRow(inComponent: 0)
        guard selectedRow > -1 else {
            return
        }
        
        viewModel.feedViewModel(settingGame(stepperView.value, selectedRow:selectedRow))
        
        if let stm = StateMachineManager.shared.stateMachine {
            stm.enter(PlayGameState.self)
        }
        
    }
    
    private func settingGame(_ numberOfRounds:Double, selectedRow:Int)->GameSettings {
        let playersChoice = PlayersChoice(rawValue:selectedRow) ?? PlayersChoice.humanVsComputer
        return GameSettings(actionNumber: Int(numberOfRounds),
                            playersChoice: playersChoice)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "playGame"),
            let vc = segue.destination as? PlayGameViewController {
            if let gameSettings = viewModel.gameSettings {
                vc.addViewModel(with: gameSettings)
            }
        }
    }
    
    
}

