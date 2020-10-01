//
//  TeamSearchAPI.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

private let baseUrl: String = "https://www.thesportsdb.com/api/v1/json/1/"

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
