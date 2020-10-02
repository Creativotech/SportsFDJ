//
//  SceneDelegate.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let _ = (scene as? UIWindowScene) else {
			return
		}
		let rootNavigationController = UINavigationController()
		let viewController = TeamSearchCreator.create()
		rootNavigationController.setViewControllers([viewController], animated: false)
		
		window?.rootViewController = rootNavigationController
	}

	func sceneDidDisconnect(_ scene: UIScene) {}

	func sceneDidBecomeActive(_ scene: UIScene) {}

	func sceneWillResignActive(_ scene: UIScene) {}

	func sceneWillEnterForeground(_ scene: UIScene) {}

	func sceneDidEnterBackground(_ scene: UIScene) {}
}

