//
//  AppDelegate.swift
//  MyDeckMTG
//
//  Created by Caio Cezar Lopes dos Santos on 1/14/16.
//  Copyright © 2016 MyDeck MTG. All rights reserved.
//

import UIKit
import Parse
import Bolts
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        PFSet.registerSubclass()
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("dapK6bgNNzIS3PfLMgxGt5L9cQqWjOvniRv4IawT", clientKey: "qYa4rrP2SxF73kRwtRpU1PtketuZmLIn3bgnAyK0")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        if setsIsUpToDate() == false {
            updateLocalSets()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.

    }
    
    func setsIsUpToDate() -> Bool {
        let error: NSErrorPointer = nil
        let quantitySetsInParse = PFSet.query()!.countObjects(error)
        
        if error == nil {
            let realm = try! Realm()
            
            let quantitySetsInRealm = realm.objects(Set).count
            
            if quantitySetsInParse == quantitySetsInRealm {
                return true
            } else {
                let setsInRealm = realm.objects(Set)
                
                for set in setsInRealm {
                    try! realm.write {
                        realm.delete(set)
                    }
                }
            }
        }
        return false
    }
    
    func updateLocalSets() {
        do {
            let query = PFSet.query()!
            query.limit = 1000
            
            if let sets = try query.findObjects() as? [PFSet] {
                for set in sets {
                    set.saveInRealm()
                }
            }
        } catch {
            print(error)
        }
    }
}

