//
//  ViewController.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation
import UIKit

protocol TeamSearchDisplayLogic: class {
	func showError(_ error: Error)
	func showLeagues(_ leagues: [TeamSearchModel.getLeagues.ViewModel.League])
	func showTeams(_ teams: [TeamSearchModel.getTeams.ViewModel.Team])
}

class TeamSearchViewController: UIViewController, TeamSearchDisplayLogic {
	
	@IBOutlet private weak var completionTableView: UITableView!
	@IBOutlet private weak var teamsCollectionView: UICollectionView!
	
	var searchTeamController = UISearchController(searchResultsController: nil)
	
	var interactor: TeamSearchBusinessLogic?
	var router: (NSObjectProtocol & TeamSearchRoutingLogic & TeamSearchData)?
	
	var leagues: [TeamSearchModel.getLeagues.ViewModel.League] = [] {
		didSet {
			DispatchQueue.main.async {
				self.completionTableView.reloadData()
			}
		}
	}
	var teams: [TeamSearchModel.getTeams.ViewModel.Team] = [] {
		didSet {
			DispatchQueue.main.async {
				self.teamsCollectionView.reloadData()
			}
		}
	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchController()
		setupCompletionView()
		setupCollectionView()
		interactor?.getLeagues()
	}
	
	private func setupSearchController() {
		searchTeamController = {
			let search = UISearchController(searchResultsController: nil)
			search.searchBar.placeholder = "Search a league.."
			search.searchResultsUpdater = self
			search.obscuresBackgroundDuringPresentation = false
			search.hidesNavigationBarDuringPresentation = false
			return search
		}()
		navigationItem.titleView = searchTeamController.searchBar
		definesPresentationContext = true
	}
	
	private func setupCompletionView() {
		completionTableView.delegate = self
		completionTableView.dataSource = self
		completionTableView.tableFooterView = UIView()
	}

	private func setupCollectionView() {
		teamsCollectionView.delegate = self
		teamsCollectionView.dataSource = self
		teamsCollectionView.register(UINib(nibName: TeamViewCell.typeName, bundle: nil), forCellWithReuseIdentifier: TeamViewCell.typeName)
	}
	
	// MARK: Logic
	
	func showLeagues(_ leagues: [TeamSearchModel.getLeagues.ViewModel.League]) {
		completionTableView.isHidden = leagues.isEmpty
		self.leagues = leagues
	}
	
	func showTeams(_ teams: [TeamSearchModel.getTeams.ViewModel.Team]) {
		self.teams = teams
	}
	
	func showError(_ error: Error) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
				alert.dismiss(animated: true, completion: nil)
			}))
		   self.present(alert, animated: true, completion: nil)
		}
	}
}

// MARK: Search

extension TeamSearchViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		interactor?.searchLeagues(request: .init(searchText: text))
	}
}
