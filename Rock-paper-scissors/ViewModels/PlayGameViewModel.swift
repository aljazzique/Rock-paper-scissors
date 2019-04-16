//
//  PlayGameViewModel.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 11/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import Foundation

protocol PlayGameViewModelProtocol {
    var gameSettings:GameSettings { get }
    var computerShape:Shape { get }
    var roundsPlayed:Int { get }
    var shapes:[String] { get }
}

class PlayGameViewModel:PlayGameViewModelProtocol {
    typealias PlayGameCallback = (_ playedShape:Shape?)->()
    
    var gameSettings: GameSettings
    var computerShape:Shape = .rock
    var roundsPlayed = 0
    var shapes = [String]()
    
    fileprivate var playGameCallback:PlayGameCallback?
    fileprivate var gameTimer: Timer?
    fileprivate static let autoplayTimeInterval:TimeInterval = 3
    
    var kindOfGame:PlayersChoice {
        get {
            return gameSettings.playersChoice
        }
    }
    
    init() {
        gameSettings = GameSettings(actionNumber: 1, playersChoice: .humanVsComputer)
        setupShapes()
    }
    
    init(with gameSettings:GameSettings) {
        self.gameSettings = gameSettings
        setupShapes()
    }
    
    deinit {
        gameTimer = nil
    }
    
    private func setupShapes() {
        Shape.allCases.forEach { (shape:Shape) in
            shapes.append(shape.stringValue())
        }
    }
    
}

extension PlayGameViewModel {
    func calculateIfPlayer1Win()->GameStatus {
        let score1 = gameSettings.players[0].score
        let score2 = gameSettings.players[1].score
        
        if score1 > score2 {
            return .win
        } else if score2 == score1 {
            return .exAequo
        } else {
            return .lost
        }
    }
    
    func determinateRound(_ shape:Shape)->GameStatus {
        computerShape = Shape.newRandomShape
        var result:GameStatus = .exAequo
        switch shape {
        case .paper:
            switch computerShape {
            case .paper:
                result = .exAequo
            case .rock:
                result = .win
            case .scissors:
                result = .lost
            }
        case .rock:
            switch computerShape {
            case .paper:
                result = .lost
            case .rock:
                result = .exAequo
            case .scissors:
                result = .win
            }
        case .scissors:
            switch computerShape {
            case .paper:
                result = .win
            case .rock:
                result = .lost
            case .scissors:
                result = .exAequo
            }
        }
        return result
    }
    
    func autoPlayingGame(callback:@escaping PlayGameCallback) {
        playGameCallback = callback
        playRound(callback: playGameCallback!)
        gameTimer = Timer.scheduledTimer(timeInterval: PlayGameViewModel.autoplayTimeInterval, target: self, selector: #selector(runAutoPlaying), userInfo: nil, repeats: true)
    }
    
    @objc func runAutoPlaying(_ timer:Timer) {
        if let callback = playGameCallback {
            playRound(callback: callback)
        }
        
    }
    
    func playRound(_ playedValue:Int = -1, callback:PlayGameCallback) {
        guard let playedShape =  playedValue == -1 ? Shape.newRandomShape : Shape(rawValue: playedValue) else {
            return
        }
        
        switch determinateRound(playedShape) {
        case .win:
            gameSettings.players[0].score += 1
        case .lost:
            gameSettings.players[1].score += 1
        case .exAequo:
            break
        }
        
        roundsPlayed += 1
        
        
        
        if roundsPlayed == gameSettings.actionNumber {
            gameTimer?.invalidate()
            gameTimer = nil
            callback(nil)
        } else {
            callback(playedShape)
        }
    }
    
}
