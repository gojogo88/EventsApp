//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import Foundation

final class AddEventViewModel {
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    var onUpdate: () -> Void = {}
    let title = "Add"
    private(set) var cells: [Cell] = []
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubtitleCellViewModel(title: "Name", subtitle: "", placeHolder: "Add a name", type: .text, onCellUpdate: {})),
            .titleSubtitle(TitleSubtitleCellViewModel(title: "Date", subtitle: "", placeHolder: "Select a date", type: .date, onCellUpdate: { [weak self] in
                self?.onUpdate()
            })),
            .titleSubtitle(TitleSubtitleCellViewModel(title: "Background", subtitle: "", placeHolder: "", type: .image, onCellUpdate: { [weak self] in
                self?.onUpdate()
            }))
        ]
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
       // extract info from cell view models and save in core data
        // tell coordinator to dismiss
        
    }
    
    func updateText(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleViewModel):
            titleSubtitleViewModel.update(subtitle)
        }
    }
    
//    deinit {
//        print("deinit from add event view model")
//    }
}


