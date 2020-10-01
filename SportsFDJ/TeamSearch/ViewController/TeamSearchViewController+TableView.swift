//
//  TeamSearchViewController+TableView.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import Foundation
import UIKit

extension TeamSearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return leagues.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "leagueCell")
		cell.textLabel?.text = leagues[indexPath.row].name
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}

extension TeamSearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let name = leagues[indexPath.row].name
		interactor?.getTeams(request: .init(nameLeague: name))
		searchTeamController.searchBar.text = name
		searchTeamController.isActive = false
		tableView.isHidden = true
	}
}
