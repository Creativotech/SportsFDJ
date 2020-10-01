//
//  TeamSearchRouter.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import UIKit

protocol TeamSearchData
{
	var dataStore: TeamSearchDataStore? { get }
}

protocol TeamSearchRoutingLogic {
	func showTeamDetail()
}

class TeamSeachRouter: NSObject, TeamSearchRoutingLogic, TeamSearchData
{
	weak var viewController: TeamSearchViewController?
	var dataStore: TeamSearchDataStore?
	
	// MARK: Routing
	
	func showTeamDetail() {
		guard let team = dataStore?.teamSelected else {
			return
		}
		
	}
}
