//
//  TeamSearchViewController+CollectionView.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import Foundation
import UIKit

extension TeamSearchViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return teams.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamViewCell.typeName, for: indexPath) as? TeamViewCell else {
			fatalError("\(TeamViewCell.typeName) ERROR")
		}
		cell.setup(teams[indexPath.row])
		return cell
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
}

extension TeamSearchViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		interactor?.setSelectedTeam(at: indexPath.row)
		router?.showTeamDetail()
	}
}

extension TeamSearchViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let padding: CGFloat =  20
		let collectionViewSize = collectionView.frame.size.width - padding
		
		return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
	}
}
