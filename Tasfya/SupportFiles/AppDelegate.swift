//
//  AppDelegate.swift
//  Tasfya
//
//  Created by Elsaadany on 04/04/2021.
//

import UIKit
import IQKeyboardManagerSwift
import LanguageManager_iOS
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        setNavBar()
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        LanguageManager.shared.defaultLanguage = .deviceLanguage
        UITextField.appearance().textAlignment = LanguageManager.shared.currentLanguage == .ar ? .right : .left
        UILabel.appearance().textAlignment = LanguageManager.shared.currentLanguage == .ar ? .right : .left
        
        self.window = UIWindow()
        window?.rootViewController = setRootVC(to: HomeScreenVC())
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    private func setNavBar() {
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
    }
}
