//
//  TeamSearchWorkerAPI.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

private let baseUrl: String = "https://www.thesportsdb.com/api/v1/json/1/"

typealias LeagueFetcher 	= TeamSearchAPI<Leagues>
typealias LeagueResult 		= Result<[League], Error>
typealias TeamsFetcher 		= TeamSearchAPI<Teams>
typealias TeamsResult 		= Result<[Team], Error>

enum TeamSearchURLBuilder {
	case leagues
	case teams(_ search: String)
	
	func url() -> URL {
		switch self {
		case .leagues:
			return URL(string: "\(baseUrl)all_leagues.php")!
		case .teams(let search):
			return URL(string: "\(baseUrl)search_all_teams.php?l=\(search.replacingOccurrences(of: " ", with: "%20"))")!
		}
	}
}

class TeamSearchAPI<T: Codable> {
	
	private let session: URLSession = .shared
	
	func fetchData(_ urlBuilder: TeamSearchURLBuilder, completion: @escaping (Result<T, Error>) -> ()) {
		session.dataTask(with: urlBuilder.url()) { (data, response, error) in
			
			guard let data = data else {
				completion(.failure(error!))
				return
			}
			
			let decoder = JSONDecoder()
			do {
				let result = try decoder.decode(T.self, from: data)
				completion(.success(result))
			} catch let error {
				completion(.failure(error))
			}
		}.resume()
	}
}

class TeamSearchWorkerAPI
{
	lazy var leagueFetcher = LeagueFetcher()
	lazy var teamsFetcher = TeamsFetcher()
	
	func getLeagues(completion: @escaping (LeagueResult) -> ()) {
		leagueFetcher.fetchData(.leagues) { result in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let leagues):
				completion(.success(leagues.leagues))
			}
		}
	}
	
	func getTeams(for text: String, completion: @escaping (TeamsResult) -> ()) {
		teamsFetcher.fetchData(.teams(text)) { result in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let teams):
				completion(.success(teams.teams))
			}
		}
	}
}
