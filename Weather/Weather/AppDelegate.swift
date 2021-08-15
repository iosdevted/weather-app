//
//  AppDelegate.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: 5, // Set the new schema version.
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 5 {
                    // The enumerateObjects(ofType:_:) method iterates over
                    // every Person object stored in the Realm file
                    migration.enumerateObjects(ofType: LocalWeather.className()) { oldObject, newObject in
                        newObject!["locationName"] = String()
                    }
                    migration.enumerateObjects(ofType: LocalWeather.className()) { oldObject, newObject in
                        newObject!["latitude"] = Double()
                    }
                    migration.enumerateObjects(ofType: LocalWeather.className()) { oldObject, newObject in
                        newObject!["longitude"] = Double()
                    }
                    migration.enumerateObjects(ofType: LocalWeather.className()) { oldObject, newObject in
                        newObject!["lastRefreshedDate"] = Date()
                    }
                }
            }
        )
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let _ = try! Realm()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

