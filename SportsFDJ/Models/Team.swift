//
//  Team.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation

struct Teams: Codable {
	let teams: [Team]
}

struct Team: Codable {

	let leagueName: String
	let teamName: String
	let teamBadge: String
	let teamCountry: String
	let teamDescription: String?
	let teamBanner: String?
	
	enum CodingKeys: String, CodingKey {
		case leagueName = "strLeague"
		case teamName = "strTeam"
		case teamBadge = "strTeamBadge"
		case teamCountry = "strCountry"
		case teamDescription = "strDescriptionEN"
		case teamBanner = "strTeamBanner"
	}
}
