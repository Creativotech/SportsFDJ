//
//  TeamSearchPresenter.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import UIKit

typealias TeamsResponse = TeamSearchModel.getTeams.Response
typealias LeaguesResponse = TeamSearchModel.getLeagues.Response

protocol TeamSearchPresentationLogic {
	func showError(_ error: Error)
	func showLeagues(response: LeaguesResponse)
	func showTeams(response: TeamsResponse)
}

class TeamSearchPresenter: TeamSearchPresentationLogic {
	
	weak var viewController: TeamSearchDisplayLogic?
	
	func showTeams(response: TeamsResponse) {
		let teams = response.teams.map {
			TeamSearchModel.getTeams.ViewModel.Team(name: $0.teamName, urlLogo: $0.teamBadge)
		}
		viewController?.showTeams(teams)
	}
	
	func showError(_ error: Error) {
		viewController?.showError(error)
	}
	
	func showLeagues(response: LeaguesResponse) {
		let leagues = response.leagues.map {
			TeamSearchModel.getLeagues.ViewModel.League(name: $0.strLeague)
		}
		viewController?.showLeagues(leagues)
		if leagues.isEmpty {
			viewController?.showTeams([])
		}
	}
}
