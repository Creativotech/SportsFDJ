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
	let strLeague: String
	let strSport: String
	
	enum CodingKeys: String, CodingKey {
		case strLeague = "strLeague"
		case strSport = "strSport"
	}
}
