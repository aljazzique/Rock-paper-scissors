//
//  GameShape.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 12/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import GameplayKit

enum GameStatus {
    case win, lost , exAequo
}

enum Shape:Int, CaseIterable {
    case rock, paper, scissors
}

extension Shape {
    func stringValue()->String {
        switch self.rawValue {
        case 0:
            return "👊"
        case 1:
            return "✋"
        case 2:
            return "✌️"
        default:
            return "👊"
        }
    }
    
    static private let randomGenerator = GKRandomDistribution(lowestValue: 0, highestValue: Shape.allCases.count)
    
    static var newRandomShape:Shape {
        get {
            return Shape(rawValue: randomGenerator.nextInt()) ?? .rock
        }
    }
}




