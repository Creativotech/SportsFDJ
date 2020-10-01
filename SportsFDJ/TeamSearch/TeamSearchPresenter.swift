//
//  TeamSearchPresenter.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import UIKit

protocol TeamSearchPresentationLogic {
	func showError(_ error: Error)
	func showLeagues(response: teamSearchModel.getLeagues.Response)
	func showTeams(response: teamSearchModel.getTeams.Response)
}

class TeamSearchPresenter: TeamSearchPresentationLogic {
	
	weak var viewController: TeamSearchDisplayLogic?
	
	func showTeams(response: teamSearchModel.getTeams.Response) {
		let teams = response.teams.map { teamSearchModel.getTeams.ViewModel.Team(name: $0.teamName, urlLogo: $0.teamBadge)}
		viewController?.showTeams(teams)
	}
	
	func showError(_ error: Error) {
		viewController?.showError(error)
	}
	
	func showLeagues(response: teamSearchModel.getLeagues.Response) {
		let leagues = response.leagues.map { teamSearchModel.getLeagues.ViewModel.League(name: $0.strLeague) }
		viewController?.showLeagues(leagues)
	}
}
