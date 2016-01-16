//
//  Set.swift
//  MyDeckMTG
//
//  Created by Caio Cezar Lopes dos Santos on 1/16/16.
//  Copyright © 2016 MyDeck MTG. All rights reserved.
//

import RealmSwift

class Set: Object {
    dynamic var code: String? = nil
    dynamic var name: String? = nil
    dynamic var gathererCode: String? = nil
    dynamic var oldCode: String? = nil
    dynamic var releaseDate: String? = nil
    dynamic var border: String? = nil
    dynamic var type: String? = nil
    dynamic var block: String? = nil
    let onlineOnly = RealmOptional<Bool>()
    let cardCount = RealmOptional<Int>()
    let icons = List<SetIcon>()

    func cardCountFormatted() -> String {
        return "\(cardCount.value!) cards"
    }
    
    func urlIconLigamagic(rarity: String) -> String {
        return "http://www.ligamagic.com.br/images/emot/ed/\(code!)_\(rarity).gif"
    }
}
