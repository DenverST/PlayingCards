//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Denver Stove on 10/10/18.
//  Copyright © 2018 Denver Stove. All rights reserved.
//

import Foundation

struct PlayingCard
{
    var suit: Suit
    var rank: Rank
    
    //Making enum with :Int makes the raw value of spades 0, hears 1 ...etc
    //Can do it as a string, which takes the value of the word
    
    enum Suit: String {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        static var all = [Suit.spades,.hearts,.diamonds,.clubs]
    }
    
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"),.face("Q"),.face("K")]
            return allRanks
        }
    }
}
