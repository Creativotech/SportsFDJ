//
//  TeamSearchListModels.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

enum TeamSearchModel
{
	// MARK: Use cases
	
	enum getLeagues {
		
		struct Request {
			var searchText: String
		}
		
		struct Response {
			var leagues: [League]
		}
		
		struct ViewModel {
			let leagues: [League]
			
			struct League {
				var name: String
			}
		}
	}
	
	enum getTeams {
		
		struct Request {
			var nameLeague: String
		}
		
		struct Response {
			var teams: [Team]
		}
		
		struct ViewModel {
			let teams: [Team]
			
			struct Team {
				let name: String
				let urlLogo: String
			}
		}
	}
	
	
}
