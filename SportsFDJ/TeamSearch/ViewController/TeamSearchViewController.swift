//
//  ViewController.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation
import UIKit

struct TeamSearchCreator {
	static func create() -> UIViewController {
		guard let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: TeamSearchViewController.typeName) as? TeamSearchViewController else {
			fatalError("\(TeamSearchViewController.typeName) not found")
		}
		let interactor = TeamSearchInteractor()
		let presenter = TeamSearchPresenter()
		let router = TeamSeachRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
		return viewController
	}
}

protocol TeamSearchDisplayLogic: class {
	func showLeagues(_ leagues: [teamSearchModel.getLeagues.ViewModel.League])
	func showTeams(_ teams: [teamSearchModel.getTeams.ViewModel.Team])
	func showError(_ error: Error)
}

class TeamSearchViewController: UIViewController, TeamSearchDisplayLogic {
	
	@IBOutlet private weak var completionTableView: UITableView!
	@IBOutlet private weak var teamsCollectionView: UICollectionView!
	
	var searchTeamController = UISearchController(searchResultsController: nil)
	
	var interactor: TeamSearchBusinessLogic?
	var router: (NSObjectProtocol & TeamSearchRoutingLogic & TeamSearchData)?
	
	var leagues: [teamSearchModel.getLeagues.ViewModel.League] = [] {
		didSet {
			DispatchQueue.main.async {
				self.completionTableView.reloadData()
			}
		}
	}
	var teams: [teamSearchModel.getTeams.ViewModel.Team] = [] {
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
	
	private func setupCompletionView() {
		completionTableView.delegate = self
		completionTableView.dataSource = self
		completionTableView.tableFooterView = UIView()
	}
	
	private func setupSearchController() {
		searchTeamController = {
			let search = UISearchController(searchResultsController: nil)
			search.searchBar.placeholder = "Search a soccer league"
			search.searchResultsUpdater = self
			search.obscuresBackgroundDuringPresentation = false
			search.hidesNavigationBarDuringPresentation = false
			return search
		}()
		navigationItem.titleView = searchTeamController.searchBar
		definesPresentationContext = true
	}
	
	private func setupCollectionView() {
		teamsCollectionView.delegate = self
		teamsCollectionView.dataSource = self
		teamsCollectionView.register(UINib(nibName: TeamViewCell.typeName, bundle: nil), forCellWithReuseIdentifier: TeamViewCell.typeName)
	}
	
	// MARK: Logic
	
	func showTeams(_ teams: [TeamList.getTeams.ViewModel.Team]) {
		self.teams = teams
	}
	
	func showLeagues(_ leagues: [TeamList.getLeagues.ViewModel.League]) {
		completionTableView.isHidden = leagues.isEmpty
		self.leagues = leagues
	}
	
	func showError(_ error: Error) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: "An error occured", message: error.localizedDescription, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
				alert.dismiss(animated: true, completion: nil)
			}))
		   self.present(alert, animated: true, completion: nil)
		}
	}
}

extension TeamListViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		interactor?.searchLeagues(request: .init(text: text))
	}
	
}

