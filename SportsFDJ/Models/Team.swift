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

	let leagueIdentifier: String
	let teamIdentifier: String
	let leagueName: String
	let teamName: String
	let teamBadge: String
	let teamCountry: String
	let teamPresentation: String
	
	enum CodingKeys: String, CodingKey {
		case leagueIdentifier = "idLeague"
		case teamIdentifier = "idTeam"
		case leagueName = "strLeague"
		case teamName = "strTeam"
		case teamBadge = "strTeamBadge"
		case teamCountry = "strCountry"
		case teamPresentation = "strDescriptionFR"
	}
}
