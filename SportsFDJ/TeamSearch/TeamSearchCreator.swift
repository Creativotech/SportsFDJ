//
//  TeamSearchCreator.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import Foundation
import UIKit

struct TeamSearchCreator {
	static func create() -> UIViewController {
		guard let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: TeamSearchViewController.typeName) as? TeamSearchViewController else {
			fatalError("\(TeamSearchViewController.typeName) not found")
		}
		
		let interactor = TeamSearchInteractor()
		let presenter = TeamSearchPresenter()
		let router = TeamSeachRouter()
		
		router.viewController = viewController
		router.dataStore = interactor
		
		viewController.interactor = interactor
		viewController.router = router
		
		interactor.presenter = presenter
		
		presenter.viewController = viewController
		
		return viewController
	}
}
