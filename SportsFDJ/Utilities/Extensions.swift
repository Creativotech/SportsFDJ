//
//  Extensions.swift
//  SportsFDJ
//
//  Created by Benabdallah Mohamed on 01/10/2020.
//

import UIKit

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


