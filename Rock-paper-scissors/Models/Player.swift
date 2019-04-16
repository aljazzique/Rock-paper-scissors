//
//  Player.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 10/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import Foundation

enum KindOfPlayer {
    case computer, human
}


struct Player {
    var score:Int = 0
    var kindOf:KindOfPlayer
    
    init(kindOf:KindOfPlayer) {
        self.kindOf = kindOf
    }
}
