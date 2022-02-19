//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Jonathan Go on 16.02.22.
//

import Foundation
import UIKit
import CoreData

final class EventListCoordinator: EventUpdatingCoordinator, Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var onUpdateEvent = {}
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListVC = EventListVC()
        let eventListViewModel = EventListViewModel()
        eventListVC.viewModel = eventListViewModel
        eventListViewModel.coordinator = self
        onUpdateEvent = eventListViewModel.reload
        navigationController.setViewControllers([eventListVC], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        // trigger event detail coordinator
        let eventDetailCoordinator = EventDetailCoordinator(eventId: id, navigationController: navigationController)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
}
