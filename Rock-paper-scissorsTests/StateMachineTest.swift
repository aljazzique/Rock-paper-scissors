//
//  StateMachineTest.swift
//  Rock-paper-scissorsTests
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import XCTest

class StateMachineTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: basic state machine manager tests

    func testGetStateMachineManagerSingelton() {
        let stm = StateMachineManager.shared
        XCTAssertNotNil(stm)
    }
    
    func testGetStateMachine() {
        let stm = StateMachineManager.shared.stateMachine
        XCTAssertNotNil(stm)
    }

    func testAddState() {
        StateMachineManager.shared.stateMachine?.enter(ChooseRulesState.self)
        let currentTest = StateMachineManager.shared.stateMachine?.currentState
        XCTAssertNotNil(currentTest)
        XCTAssertTrue(currentTest is ChooseRulesState)
    }
    
    // MARK: ChooseRulesState tests
    
    func testChangeState() {
        StateMachineManager.shared.stateMachine?.enter(ChooseRulesState.self)
        let state = StateMachineManager.shared.stateMachine?.currentState as? ChooseRulesState
        state?.gameIsSet = true
        StateMachineManager.shared.stateMachine?.enter(PlayGameState.self)
        let currentTest = StateMachineManager.shared.stateMachine?.currentState
        XCTAssertNotNil(currentTest)
        XCTAssertTrue(currentTest is PlayGameState)
    }
    
    func testCannotGoToOthersStatesWithoutSettingGame() {
        StateMachineManager.shared.stateMachine?.enter(ChooseRulesState.self)
        StateMachineManager.shared.stateMachine?.enter(PlayGameState.self)
        var currentTest = StateMachineManager.shared.stateMachine?.currentState
        XCTAssertNotNil(currentTest)
        XCTAssertTrue(currentTest is ChooseRulesState)
        StateMachineManager.shared.stateMachine?.enter(EndGameState.self)
        currentTest = StateMachineManager.shared.stateMachine?.currentState
        XCTAssertNotNil(currentTest)
        XCTAssertTrue(currentTest is ChooseRulesState)
    }
    
    

}
