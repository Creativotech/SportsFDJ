//
//  TeamSearchBusinessLogic.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

typealias LeaguesRequest = TeamSearchModel.getLeagues.Request
typealias TeamsRequest = TeamSearchModel.getTeams.Request

protocol TeamSearchBusinessLogic {
	func getLeagues()
	func searchLeagues(request: LeaguesRequest)
	func getTeams(request: TeamsRequest)
	func setSelectedTeam(at index: Int)
}

protocol TeamSearchDataStore {
	var teamSelected: Team? { get set }
	var leagues: [League] { get set }
	var teams: [Team] { get set }
}

class TeamSearchInteractor: TeamSearchBusinessLogic, TeamSearchDataStore
{
	var presenter: TeamSearchPresentationLogic?
	var worker = TeamSearchWorkerAPI()
	
	var leagues: [League] = []
	var teams: [Team] = []
	var teamSelected: Team?
	
	func getLeagues() {
		worker.getLeagues { [weak self ] (result) in
			guard let self = self else { return }
			switch result {
			case .success(let leagues):
				self.leagues = leagues.filter { $0.strSport == "Soccer" }
			case .failure(let error):
				self.presenter?.showError(error)
			}
		}
	}
	
	func searchLeagues(request: LeaguesRequest) {
		let text = request.searchText.lowercased()
		let leaguesSearch = leagues.filter { $0.strLeague.lowercased().contains(text) }
		let response = LeaguesResponse(leagues: leaguesSearch)
		presenter?.showLeagues(response: response)
	}
	
	func getTeams(request: TeamsRequest) {
		worker.getTeams(for: request.nameLeague) { [weak self] (result) in
			guard let self = self else { return }
			switch result {
			case .success(let teams):
				let response = TeamsResponse(teams: teams)
				self.teams = teams
				self.presenter?.showTeams(response: response)
			case .failure(let error):
				self.presenter?.showError(error)
			}
		}
	}
	
	func setSelectedTeam(at index: Int) {
		teamSelected = teams[index]
	}
}
