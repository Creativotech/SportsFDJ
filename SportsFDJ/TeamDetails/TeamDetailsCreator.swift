//
//  TeamDetailsCreator.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import Foundation
import UIKit

struct TeamDetailsCreator {
	static func create(team: Team) -> UIViewController {
		guard let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: TeamDetailsViewController.typeName) as? TeamDetailsViewController else {
			fatalError("\(TeamDetailsViewController.typeName) not found")
		}
		viewController.team = team
		return viewController
	}
}
