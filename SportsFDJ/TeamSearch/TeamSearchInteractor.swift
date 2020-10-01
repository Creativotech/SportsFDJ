//
//  TeamSearchBusinessLogic.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

protocol TeamSearchBusinessLogic {
	func getLeagues()
	func searchLeagues(request: teamSearchModel.getLeagues.Request)
	func getTeams(request: teamSearchModel.getTeams.Request)
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
	private let worker = TeamSearchWorkerAPI()
	
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
	
	func searchLeagues(request: teamSearchModel.getLeagues.Request) {
		let text = request.searchText.lowercased()
		let leaguesSearch = leagues.filter { $0.strLeague.lowercased().contains(text) }
		let response = teamSearchModel.getLeagues.Response(leagues: leaguesSearch)
		presenter?.showLeagues(response: response)
	}
	
	func getTeams(request: teamSearchModel.getTeams.Request) {
		worker.getTeams(for: request.nameLeague) { [weak self] (result) in
			guard let self = self else { return }
			switch result {
			case .success(let teams):
				let response = teamSearchModel.getTeams.Response(teams: teams)
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
