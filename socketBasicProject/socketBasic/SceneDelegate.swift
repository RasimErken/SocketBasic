//
//  SceneDelegate.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
        
        let storyboard = UIStoryboard(name: "chat", bundle: nil)
        let joinChatViewController = storyboard.instantiateViewController(withIdentifier: "JoinChatViewController")
        let nav = UINavigationController(rootViewController: joinChatViewController)
        window.rootViewController = nav
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        SocketHelper.shared.closeConnection()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        SocketHelper.shared.establishConnection()
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        SocketHelper.shared.closeConnection()
    }


}

