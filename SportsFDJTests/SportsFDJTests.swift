//
//  SportsFDJTests.swift
//  SportsFDJTests
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import XCTest
@testable import SportsFDJ

class SportsFDJTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	class WorkerSpy: TeamSearchWorkerAPI {
		var fetchLeaguesCalled = false
		var fetchTeamsCalled = false
		
		override func getLeagues(completion: @escaping (LeagueResult) -> ()) {
			fetchLeaguesCalled = true
			completion(.success(Seeds.Leagues.all))
		}
		
		override func getTeams(for text: String, completion: @escaping (TeamsResult) -> ()) {
			fetchTeamsCalled = true
			completion(.success(Seeds.Teams.all))
		}
	}
	
	class PresenterSpy: TeamSearchPresentationLogic {
		var presentLeaguesCalled = false
		var presentTeamsCalled = false
		var presentErrorCalled = false
		
		var leagues: [League]?
		var teams: [Team]?
				
		func showError(_ error: Error) {
			presentErrorCalled = true
		}
		
		func showLeagues(response: LeaguesResponse) {
			presentLeaguesCalled = true
			self.leagues = response.leagues
		}
		
		func showTeams(response: TeamsResponse) {
			presentTeamsCalled = true
			self.teams = response.teams
		}
	}
	
	class ViewControllerSpy: TeamSearchDisplayLogic {
		var displayFetchedLeaguesCalled = false
		var displayFetchedTeamsCalled = false
		var displayError = false
		
		var displayedLeagues: [TeamSearchModel.getLeagues.ViewModel.League] = []
		var displayedTeams: [TeamSearchModel.getTeams.ViewModel.Team] = []
		
		func showError(_ error: Error) {
			displayError = true
		}
		
		func showLeagues(_ leagues: [TeamSearchModel.getLeagues.ViewModel.League]) {
			displayFetchedLeaguesCalled = true
			displayedLeagues = leagues
		}
		
		func showTeams(_ teams: [TeamSearchModel.getTeams.ViewModel.Team]) {
			displayFetchedTeamsCalled = true
			displayedTeams = teams
		}
	}
	
	// MARK: Test the Interactor
	
	func testFetchLeaguesCallsPresenterToFormatLeagues() {
		
		// Given
		let sut = TeamSearchInteractor()
		let presenter = PresenterSpy()
		sut.worker = WorkerSpy()
		sut.presenter = presenter
		
		// When
		sut.searchLeagues(request: .init(searchText: "testLeague"))
		
		// Then
		XCTAssert(presenter.presentLeaguesCalled, "fetchLeagues() should ask the presenter to format the leagues")
	}
	
	func testFetchLeaguesCallsWorkerToFetch() {
		// Given
		let sut = TeamSearchInteractor()
		let worker = WorkerSpy()
		sut.worker = worker
		sut.presenter = PresenterSpy()
		
		// When
		sut.getLeagues()
		
		// Then
		XCTAssert(worker.fetchLeaguesCalled, "getLeagues() should ask the worker to fetch leagues")
	}

	func testFetchTeamsCallsWorkerToFetch() {
		// Given
		let sut = TeamSearchInteractor()
		let worker = WorkerSpy()
		let leagueName = Seeds.Leagues.LeagueOne.strLeague
		sut.worker = worker
		sut.presenter = PresenterSpy()
		
		// When
		sut.getTeams(request: .init(nameLeague: leagueName))
		
		// Then
		XCTAssert(worker.fetchTeamsCalled, "getTeams() should ask the worker to fetch teams")
	}
	
	//More tests upcoming (showing the error cases, empty search text = empty teams table)
	
	// MARK: Test the Presenter
	
	func testDisplayFetchedLeaguesCalledByPresenter() {
		// Given
		let viewControllerSpy = ViewControllerSpy()
		let sut = TeamSearchPresenter()
		sut.viewController = viewControllerSpy
		
		// When
		sut.showLeagues(response: .init(leagues: Seeds.Leagues.all))
		// Then
		XCTAssert(viewControllerSpy.displayFetchedLeaguesCalled, "presentFetchedLeagues() should ask the view controller to display them")
	}
	
	func testDisplayFetchedTeamsCalledByPresenter() {
		// Given
		let viewControllerSpy = ViewControllerSpy()
		let sut = TeamSearchPresenter()
		sut.viewController = viewControllerSpy
		
		// When
		sut.showTeams(response: .init(teams: Seeds.Teams.all))
		
		// Then
		XCTAssert(viewControllerSpy.displayFetchedTeamsCalled, "presentFetchedTeams() should ask the view controller to display them")
	}
	
	func testPresentShouldFormatFetchedTeamsForDisplay() {
		
		// Given
		let viewControllerSpy = ViewControllerSpy()
		let sut = TeamSearchPresenter()
		sut.viewController = viewControllerSpy
		let teams = Seeds.Teams.all
		
		// When
		sut.showTeams(response: .init(teams: teams))
		
		// Then
		let displayedTeams = viewControllerSpy.displayedTeams
		
		XCTAssertEqual(displayedTeams.count, teams.count, "presentFetchedTeams() should ask the view controller to display same amount of teams it receive")
		
		for (index, displayedTeam) in displayedTeams.enumerated() {
			XCTAssertEqual(displayedTeam.name, "Team\(index+1)")
		}
	}
	
	//More tests upcoming (test the model with different cases and values)
}
