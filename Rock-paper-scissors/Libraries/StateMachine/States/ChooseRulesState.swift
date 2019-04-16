//
//  ChooseRulesState.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import GameKit

class ChooseRulesState:GKState {
    
    var gameIsSet:Bool = false
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass is PlayGameState.Type {
            return gameIsSet
        }
        
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("didEnter ChooseRulesState")
        if let previousViewController = StateMachineManager.shared.navigationController?.topViewController as? PlayGameViewController {
            previousViewController.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        print("update ChooseRulesState")
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        gameIsSet = false
        print("willExit ChooseRulesState")
    }
}
