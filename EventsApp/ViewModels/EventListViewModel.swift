//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}
