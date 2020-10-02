//
//  TeamDetailsViewController.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 30/09/2020.
//

import Foundation
import UIKit

class TeamDetailsViewController: UIViewController {
	
	@IBOutlet private weak var imageViewTeamBanner: UIImageView!
	@IBOutlet private weak var labelTeamCountry: UILabel!
	@IBOutlet private weak var labelTeamLeagueName: UILabel!
	@IBOutlet private weak var textViewTeamDescription: UITextView!
	
	var team: Team?
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	private func setupView() {
		title = team?.teamName
		imageViewTeamBanner.loadImage(urlPath: team?.teamBanner, placeHolderImageName: "placeholder_teambanner")
		labelTeamCountry.text = team?.teamCountry
		labelTeamLeagueName.text = team?.leagueName
		textViewTeamDescription.text = team?.teamDescription
	}
	
}
