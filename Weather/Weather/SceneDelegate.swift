//
//  SceneDelegate.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = scene
        let navigationController = UINavigationController(rootViewController: MainRouter.createModule())
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.layoutIfNeeded()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

