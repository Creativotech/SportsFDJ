//
//  ViewController.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import UIKit

class TeamViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var logo: UIImageView!
    
    func setup(_ team: TeamSearchModel.getTeams.ViewModel.Team) {
        name.text = team.name
		logo.loadImage(urlPath: team.urlLogo, placeHolderImageName: "placeholder_teamlogo")
    }
}
