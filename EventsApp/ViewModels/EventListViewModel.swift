//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import Foundation

final class EventListViewModel {
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    var onUpdate = {}
    
    private(set) var cells: [Cell] = []
//    private let coreDataManager: CoreDataManager
//    
//    init(coreDataManager: CoreDataManager) {
//        self.coreDataManager = coreDataManager
//    }
    
    func viewDidLoad() {
        cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
        onUpdate()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}
