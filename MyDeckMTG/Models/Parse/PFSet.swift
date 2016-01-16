//
//  Set.swift
//  MyDeckMTG
//
//  Created by Caio Cezar Lopes dos Santos on 1/16/16.
//  Copyright © 2016 MyDeck MTG. All rights reserved.
//

import Parse
import RealmSwift

class PFSet : PFObject, PFSubclassing {
    @NSManaged var code: String?
    @NSManaged var name: String?
    @NSManaged var gathererCode: String?
    @NSManaged var oldCode: String?
    @NSManaged var releaseDate: String?
    @NSManaged var border: String?
    @NSManaged var type: String?
    @NSManaged var block: String?
    @NSManaged var onlineOnly: Bool
    @NSManaged var cardCount: Int
    
    func saveInRealm() {
        let set = Set()
        set.code = code
        set.name = name
        set.gathererCode = gathererCode
        set.oldCode = oldCode
        set.releaseDate = releaseDate
        set.border = border
        set.type = type
        set.block = block
        set.onlineOnly.value = onlineOnly
        set.cardCount.value = cardCount
        
        let letters = ["C", "U", "R", "M"]
        let realm = try! Realm()
        
        for letter in letters {
            if let url = NSURL(string: set.urlIconLigamagic(letter)) {
                if let data = NSData(contentsOfURL: url) {
                    let icon = SetIcon()
                    icon.rarity = letter
                    icon.image = data
                    
                    try! realm.write {
                        realm.add(icon)
                        print("Addind icon \(letter) of \(code!) set.")
                    }
                    
                    set.icons.append(icon)
                }
            }
        }
        
        try! realm.write {
            realm.add(set)
        }
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Set"
    }
}