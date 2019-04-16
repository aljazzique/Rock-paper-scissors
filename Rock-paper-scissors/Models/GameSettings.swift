//
//  GameSettings.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import Foundation

enum PlayersChoice:Int {
    case humanVsComputer, computerVsComputer
}

struct GameSettings {
    var actionNumber:Int
    var players:[Player]
    var playersChoice:PlayersChoice
    
    init(actionNumber:Int, playersChoice:PlayersChoice) {
        self.actionNumber = actionNumber
        self.playersChoice = playersChoice
        self.players = GameSettings.settingPlayer(playersChoice)
    }
}

extension GameSettings {
    fileprivate static func settingPlayer(_ choice:PlayersChoice)->[Player] {
        var players = [Player]()
        
        switch choice {
        case .humanVsComputer:
            players.append(Player(kindOf: .human))
            players.append(Player(kindOf: .computer))
        case .computerVsComputer:
            players.append(Player(kindOf: .computer))
            players.append(Player(kindOf: .computer))
        }
        
        return players
    }
}
