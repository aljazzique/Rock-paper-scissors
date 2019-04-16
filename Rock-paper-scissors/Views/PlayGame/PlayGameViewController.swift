//
//  PlayGameViewController.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 11/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import UIKit

fileprivate struct Consts {
    struct ResetButton {
        static let conerRadius:CGFloat = 40
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

class PlayGameViewController:UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var userButtonsView: UIView!
    @IBOutlet weak var userbuttonsHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var viewModel = PlayGameViewModel()
    fileprivate var endGameTimer: Timer?
    
    var needToGenerateInterface = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResetButton()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        generatePlayerInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func addViewModel(with gameSettings:GameSettings) {
        viewModel = PlayGameViewModel(with: gameSettings)
    }
}

// MARK: Generate interface according to selected rules
extension PlayGameViewController {
    
    fileprivate func generatePlayerInterface() {
        guard needToGenerateInterface == true else {
            return
        }
        
        defer {
            userButtonsView.layoutIfNeeded()
        }
        
        needToGenerateInterface = false
        
        setupTitle()
        
        if viewModel.kindOfGame == .humanVsComputer {
            generatePlayerVsComputerInterface()
        } else {
            userbuttonsHeightConstraint.constant = 0.0
            userButtonsView.isHidden = true
            viewModel.autoPlayingGame(callback: finishRoundCallback)
        }
    }
    
    private func setupTitle() {
        var title:String?
        let choice = viewModel.gameSettings.playersChoice
        switch choice {
        case .humanVsComputer:
            title = NSLocalizedString("player-vs-computer", comment: "")
        case .computerVsComputer:
            title = NSLocalizedString("computer-vs-computer", comment: "")
        }
        
        titleLabel.text = title
    }
}

// MARK: reset button part
extension PlayGameViewController {
    fileprivate func setupResetButton() {
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchDown)
        
        resetButton.layer.cornerRadius = Consts.ResetButton.conerRadius
        resetButton.layer.shadowOffset = CGSize(width: Consts.ResetButton.Shadow.Offset.width, height: Consts.ResetButton.Shadow.Offset.height)
        resetButton.layer.shadowRadius = Consts.ResetButton.Shadow.radius
        resetButton.layer.shadowOpacity = Consts.ResetButton.Shadow.opacity
        resetButton.layer.shadowColor = UIColor.black.cgColor
    }
    
    @objc func resetButtonPressed(_ sender:UIButton) {
        let alert = UIAlertController(title: NSLocalizedString("reset-title",value: "Reset", comment: ""),
                                      message: NSLocalizedString("reset-message",value: "Reset", comment: ""),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("reset-ok",value: "Reset", comment: ""),
                                      style: .destructive,
                                      handler: { action in
                                        if let stm = StateMachineManager.shared.stateMachine {
                                            stm.enter(ChooseRulesState.self)
                                        }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("reset-cancel",value: "Reset", comment: ""),
                                      style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// Gamer buttons part in collection view
extension PlayGameViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let uiNib = UINib(nibName: ShapeCollectionCell.nibName, bundle: nil)
        
        collectionView.register(uiNib, forCellWithReuseIdentifier: ShapeCollectionCell.reusableIdentifier)
        
        collectionView.reloadData()
    }
    
    private func generatePlayerVsComputerInterface() {
        userbuttonsHeightConstraint.constant = 150.0
        userButtonsView.isHidden = false
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShapeCollectionCell.reusableIdentifier, for: indexPath) as! ShapeCollectionCell
        cell.fillUI(viewModel.shapes[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.playRound(indexPath.item, callback: finishRoundCallback)
    }
}

// MARK: Handeling Game playing result
extension PlayGameViewController {
    
     fileprivate func finishRoundCallback(_ playedShape:Shape?) {
        
        guard let shape = playedShape else {
            finishGame()
            return
        }
        displayResult(shape)
        
    }
    
    
    fileprivate func displayResult(_ userShape:Shape) {
        resultLabel.text = "\(userShape.stringValue()) / \(viewModel.computerShape.stringValue())"
        roundLabel.text = "round \(viewModel.roundsPlayed+1)"
    }
    
    private func finishGame() {
        print("finishGame")
        
        // determinate if player 1 status
        resultLabel.text = "player 1 \(viewModel.calculateIfPlayer1Win())"
    }
    
    
}
