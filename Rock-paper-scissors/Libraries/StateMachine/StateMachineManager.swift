//
//  StateMachineManager.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import GameKit

class StateMachineManager:NSObject {
    static let shared = StateMachineManager()
    
    var stateMachine: GKStateMachine?
    
    weak var navigationController:UINavigationController?
    
    
    private override init() {
        super.init()
        setupStateMachine()
        
    }
    
    private func setupStateMachine() {
        // Create the states
        let chooseRulesState = ChooseRulesState()
        let playGameState = PlayGameState()
        let endGameState = EndGameState()
        
        // Initialize the state machine
        stateMachine = GKStateMachine(states: [chooseRulesState, playGameState, endGameState])
    }
    
    
}
