//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Jonathan Go on 16.02.22.
//

import Foundation
import UIKit

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //let eventListVC = EventListVC.instantiate()
        let eventListVC = EventListVC()
        navigationController.setViewControllers([eventListVC], animated: false)
    }
    
    
}
