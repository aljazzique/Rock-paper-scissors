//
//  FinishedGameState.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import GameKit

class EndGameState:GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayGameState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("Enter EndGameState")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
