//
//  SetIcon.swift
//  MyDeckMTG
//
//  Created by Caio Cezar Lopes dos Santos on 1/16/16.
//  Copyright © 2016 MyDeck MTG. All rights reserved.
//

import RealmSwift

class SetIcon: Object {
    dynamic var rarity: String = ""
    dynamic var image: NSData?
}