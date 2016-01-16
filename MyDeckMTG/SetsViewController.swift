//
//  SetsViewController.swift
//  MyDeckMTG
//
//  Created by Caio Cezar Lopes dos Santos on 1/15/16.
//  Copyright © 2016 MyDeck MTG. All rights reserved.
//

import UIKit
import Parse
import RealmSwift

class SetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var sets = Results<Set>?()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        sets = realm.objects(Set).sorted("name")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! SetCell
        let set = sets![indexPath.row]
        
        if set.icons.count > 0 {
            cell.iconImageView.image = UIImage(data: set.icons[0].image!)
        } else {
            cell.iconImageView.hidden = true
        }
        
        cell.nameLabel.text = set.name
        cell.quantityCardsLabel.text = set.cardCountFormatted()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
