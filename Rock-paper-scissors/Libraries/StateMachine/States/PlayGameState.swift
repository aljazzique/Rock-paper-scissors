//
//  StatePlayGame.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import GameKit

class PlayGameState:GKState {
    
    var gameSettings:GameSettings?
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is EndGameState.Type ||  stateClass is ChooseRulesState.Type)
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        if let previousViewController = StateMachineManager.shared.navigationController?.topViewController as? ChooseGamePlayViewController {
            previousViewController.performSegue(withIdentifier: "playGame", sender: previousViewController)
        }
        
        if let newViewController = StateMachineManager.shared.navigationController?.topViewController as? PlayGameViewController {
            newViewController.needToGenerateInterface = true
            print("didEnter PlayGameViewController")
        }
        
        print("didEnter PlayGameState")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        print("update PlayGameState")
    }
    
    override func willExit(to nextState: GKState) {
        if nextState is ChooseRulesState {
            gameSettings = nil
        }
        super.willExit(to: nextState)
    }
}
