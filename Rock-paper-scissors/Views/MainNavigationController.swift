//
//  MainNavigationController.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 11/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import UIKit

class MainNavigationController:UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStateMachine()
    }
    
    private func initStateMachine() {
        StateMachineManager.shared.navigationController = self
        StateMachineManager.shared.stateMachine?.enter(ChooseRulesState.self)
    }
    
}
