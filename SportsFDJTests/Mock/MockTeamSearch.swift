//
//  MockTeams.swift
//  SportsFDJTests
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import Foundation

struct Seeds {
	struct Teams {
		
		static let teamOne = Team(leagueName: "League1",
							  teamName: "Team1",
							  teamBadge: "urlBadge",
							  teamCountry: "Country1",
							  teamDescription: "DescriptionTeam1",
							  teamBanner: nil)
		
		static let teamTwo = Team(leagueName: "League1",
							  teamName: "Team2",
							  teamBadge: "urlBadge",
							  teamCountry: "Country1",
							  teamDescription: nil,
							  teamBanner: nil)
		
		static let teamThree = Team(leagueName: "League1",
							  teamName: "Team3",
							  teamBadge: "urlBadge",
							  teamCountry: "Country2",
							  teamDescription: nil,
							  teamBanner: "urlBanner")
		
		static let teamFour = Team(leagueName: "League1",
							  teamName: "Team4",
							  teamBadge: "BadgeTeam3",
							  teamCountry: "Country2",
							  teamDescription: "Description",
							  teamBanner: "urlBanner")
		
		
		static let all: [Team] = [teamOne, teamTwo, teamThree, teamFour]
	}
	
	struct Leagues {
		
		static let LeagueOne = League(strLeague: "League1", strSport: "Soccer")
		
		static let LeagueTwo = League(strLeague: "League2", strSport: "Basketball")
		
		static let LeagueThree = League(strLeague: "League3", strSport: "Soccer")
		
		static let LeagueFour = League(strLeague: "League4", strSport: "Soccer")
		
		static let all: [League] = [LeagueOne, LeagueTwo, LeagueThree, LeagueFour]
	}
}
