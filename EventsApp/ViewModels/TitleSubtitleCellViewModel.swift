//
//  TitleSubtitleCellViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subtitle: String
    let placeHolder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    private(set) var image: UIImage?
    private(set) var onCellUpdate: (() -> Void)?
    
    init(title: String, subtitle: String, placeHolder: String, type: CellType, onCellUpdate: (() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.placeHolder = placeHolder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        //reload cell
        onCellUpdate?()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
