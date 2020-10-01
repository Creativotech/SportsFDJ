//
//  TeamSearchWorkerAPI.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

typealias LeagueFetcher 	= TeamSearchAPI<Leagues>
typealias LeagueResult 		= Result<[League], Error>
typealias TeamsFetcher 		= TeamSearchAPI<Teams>
typealias TeamsResult 		= Result<[Team], Error>

class TeamSearchWorkerAPI
{
	lazy var leagueFetcher = LeagueFetcher()
	lazy var teamsFetcher = TeamsFetcher()
	
	func getLeagues(completion: @escaping (LeagueResult) -> ()) {
		leagueFetcher.fetchData(.leagues) { result in
			switch result {
			case .failure(let error): completion(.failure(error))
			case .success(let leagues): completion(.success(leagues.leagues))
			}
			
		}
	}
	
	func getTeams(for text: String, completion: @escaping (TeamsResult) -> ()) {
		teamsFetcher.fetchData(.teams(text)) { result in
			switch result {
			case .failure(let error): completion(.failure(error))
			case .success(let teams): completion(.success(teams.teams))
			}
		}
	}
}
