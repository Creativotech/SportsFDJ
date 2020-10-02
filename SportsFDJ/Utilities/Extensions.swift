//
//  Extensions.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import UIKit
import Kingfisher

// MARK: Storyboards

extension UIStoryboard {
	static let main = UIStoryboard(name: "Main", bundle: nil)
}

// MARK: Getting the classname of an object

protocol NameDescribable {
	var typeName: String { get }
	static var typeName: String { get }
}

extension NameDescribable {
	var typeName: String {
		return String(describing: type(of: self))
	}
	
	static var typeName: String {
		return String(describing: self)
	}
}

extension NSObject: NameDescribable {}

// MARK: Download/cache images

extension UIImageView {
	func loadImage(urlPath: String?, placeHolderImageName: String) {
		let imagePlaceHolder = UIImage(named: placeHolderImageName)
		guard let urlP = urlPath else {
			self.image = imagePlaceHolder
			return
		}
		let processor = DownsamplingImageProcessor(size: self.frame.size)
		let url = URL(string: urlP)
		self.kf.indicatorType = .activity
		self.kf.setImage(
			with: url,
			placeholder: imagePlaceHolder,
			options: [
				.processor(processor),
				.scaleFactor(UIScreen.main.scale),
				.transition(.fade(1.0)),
				.cacheOriginalImage
			])
	}
}
