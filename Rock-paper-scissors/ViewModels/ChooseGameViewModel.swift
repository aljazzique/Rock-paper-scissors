//
//  ChooseGameViewModel.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 11/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import Foundation

protocol ChooseGameViewModelProtocol {
    var gameSettings:GameSettings? { get }
}

class ChooseGameViewModel:ChooseGameViewModelProtocol {
    var gameSettings:GameSettings?
    
    func feedViewModel(_ gameSettings:GameSettings) {
        self.gameSettings = gameSettings
        if StateMachineManager.shared.navigationController?.topViewController is ChooseGamePlayViewController,
            let currentState = StateMachineManager.shared.stateMachine?.currentState as? ChooseRulesState {
            currentState.gameIsSet = true
        }
    }
    
    func resetGameSettings() {
        gameSettings = nil
    }
    
    
    
}
