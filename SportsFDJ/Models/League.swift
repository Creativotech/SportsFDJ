//
//  League.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

struct Leagues: Codable {
	let leagues: [League]
}

struct League: Codable {
	let idLeague: String
	let strLeague: String
	let strSport: String
	
	var teams: [Team] = []
	
	enum CodingKeys: String, CodingKey {
		case idLeague = "idLeague"
		case strLeague = "strLeague"
		case strSport = "strSport"
	}
}
