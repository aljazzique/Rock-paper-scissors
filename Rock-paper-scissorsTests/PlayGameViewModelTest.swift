//
//  PlayGameViewModelTest.swift
//  Rock-paper-scissorsTests
//
//  Created by alexandre ulas on 16/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import XCTest

class PlayGameViewModelTest: XCTestCase {
    
    // En temps normal les tests unitaires sont plus organisés et complets. Mais vu le tempds impartie j'ai tout réuni dans un seul fichier

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitPlayGameViewModel() {
        let viewModel = PlayGameViewModel()
        XCTAssertNotNil(viewModel)
    }
    
    func testInitPlayers() {
        let player0 = Player(kindOf: .human)
        XCTAssertNotNil(player0)
        XCTAssertTrue(player0.kindOf == .human)
        XCTAssertTrue(player0.score == 0)
        let player1 = Player(kindOf: .computer)
        XCTAssertNotNil(player1)
        XCTAssertTrue(player1.kindOf == .computer)
        XCTAssertTrue(player1.score == 0)
    }
    
    func testInitGameSettings() {
        let gameSettings = GameSettings(actionNumber: 2, playersChoice: .humanVsComputer)
        XCTAssertNotNil(gameSettings)
        XCTAssertTrue(gameSettings.actionNumber == 2)
        XCTAssertTrue(gameSettings.playersChoice == .humanVsComputer)
        XCTAssertTrue(gameSettings.players.count == 2)
        XCTAssertTrue(gameSettings.players[0].kindOf == .human)
        XCTAssertTrue(gameSettings.players[1].kindOf == .computer)
    }
    
    func testPlayHumanVsComputer() {
        let viewModel = PlayGameViewModel(with: GameSettings(actionNumber: 1, playersChoice: .humanVsComputer))
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.gameSettings.actionNumber == 1)
        XCTAssertTrue(viewModel.gameSettings.playersChoice == .humanVsComputer)
        XCTAssertTrue(viewModel.gameSettings.players.count == 2)
        XCTAssertTrue(viewModel.gameSettings.players[0].kindOf == .human)
        XCTAssertTrue(viewModel.gameSettings.players[1].kindOf == .computer)
        
        let expectation = self.expectation(description: "testPlayHumanVsComputer")
        viewModel.playRound(1) { (playShape:Shape?) in
            XCTAssertNil(playShape)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testPlay2RoundsHumanVsComputer() {
        let viewModel = PlayGameViewModel(with: GameSettings(actionNumber: 2, playersChoice: .humanVsComputer))
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.gameSettings.actionNumber == 2)
        let expectation = self.expectation(description: "testPlay2RoundsHumanVsComputer")
        viewModel.playRound(2) { (playShape:Shape?) in
            XCTAssertNotNil(playShape)
            viewModel.playRound(1) { (playShape:Shape?) in
                XCTAssertNil(playShape)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
    
    
    
    func testPlay2RoundsComputerVsComputer() {
        let viewModel = PlayGameViewModel(with: GameSettings(actionNumber: 2, playersChoice: .computerVsComputer))
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.gameSettings.actionNumber == 2)
        XCTAssertTrue(viewModel.gameSettings.playersChoice == .computerVsComputer)
        XCTAssertTrue(viewModel.gameSettings.players.count == 2)
        XCTAssertTrue(viewModel.gameSettings.players[0].kindOf == .computer)
        XCTAssertTrue(viewModel.gameSettings.players[1].kindOf == .computer)
        let expectation = self.expectation(description: "testPlay2RoundsComputerVsComputer")
        viewModel.playRound(2) { (playShape:Shape?) in
            XCTAssertNotNil(playShape)
            viewModel.playRound(1) { (playShape:Shape?) in
                XCTAssertNil(playShape)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }

}
