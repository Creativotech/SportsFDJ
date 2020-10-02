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
		guard let selectedTeam = dataStore?.teamSelected else {
			return
		}
		let teamDetailsVC = TeamDetailsCreator.create(team: selectedTeam)
		viewController?.navigationController?.pushViewController(teamDetailsVC, animated: true)
	}
}
