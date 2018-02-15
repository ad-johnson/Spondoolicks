//
//  AppDelegate.swift
//  Spondoolicks
//
//  Created by Andrew Johnson on 17/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // TODO: - Will need something a little more complex here in future.  To cover
    // migration
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        NotificationCenter.default.addObserver(self, selector: #selector(coreDataRollback), name: Global.Notifications.CORE_DATA_ROLLBACK, object: nil)
        configureNavigationButton()

        // These two lines force app into first use mode.  Uncomment for testing
        // purposes
//        var userDefaults = UserDefaultsHelper()
//        userDefaults.isFirstUse = true

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)

        let homeVC = (window?.rootViewController as? UINavigationController)?.childViewControllers.first as? HomeViewController
        CoreDataManager.instance.initialiseStack {
            homeVC?.appInitialised()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        persistCoreData()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        persistCoreData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        persistCoreData()
    }

    // MARK: - Helper methods
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        persistCoreData()
    }

    func configureNavigationButton() {
        let fontName = FontHelper.fullFontName(for: .semibold)
        let fontSize = FontHelper.MinSize.medium.rawValue
        if let font = UIFont(name: fontName, size: fontSize) {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes(
                    [NSAttributedStringKey.font : font,
                     NSAttributedStringKey.foregroundColor : UIColor(named: "sp Grey") ?? UIColor.lightGray
                    ], for: .normal)
        }
    }
    
    // Errors in Core Data to be flagged back to Home VC
    @objc func coreDataRollback(notification: Notification) {
        let navigationController = window?.rootViewController as? UINavigationController
        let homeVC = navigationController?.childViewControllers.first as? HomeViewController
        navigationController?.popToRootViewController(animated: true)
        homeVC?.handleCoreDataRollback(notification)
    }
    
    // TODO - This may change to just refreshAllObjects() as app dev progresses.  Saving should
    // be occurring at point of need and not deferred.
    func persistCoreData() {
        try! CoreDataManager.instance.privateManagedContext().save()
        CoreDataManager.instance.privateManagedContext().refreshAllObjects()
    }
}

