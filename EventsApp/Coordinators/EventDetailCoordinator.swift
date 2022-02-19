//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Jonathan Go on 18.02.22.
//

import CoreData
import UIKit

final class EventDetailCoordinator: EventUpdatingCoordinator, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventId: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent = {}
    
    init(eventId: NSManagedObjectID, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.eventId = eventId
    }
    
    func start() {
        // create eventDetialVC
        let eventDetailVC = EventDetailVC()
        // create eventDetailViewModel
        let eventDetailViewModel = EventDetailViewModel(eventId: eventId)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        eventDetailVC.viewModel = eventDetailViewModel
        // push it into the navigation controller
        navigationController.pushViewController(eventDetailVC, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(_ event: Event) {
        let editEventCoordinator = EditEventCoordinator(event: event, navigationController: navigationController)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
