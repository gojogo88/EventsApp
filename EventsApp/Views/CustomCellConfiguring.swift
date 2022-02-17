//
//  CustomCellConfiguring.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import Foundation

protocol CustomCellConfiguring {
    static var reuseIdentifier: String { get }
    func setupHeirarchy()
    func setupLayout()
}

extension CustomCellConfiguring {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
