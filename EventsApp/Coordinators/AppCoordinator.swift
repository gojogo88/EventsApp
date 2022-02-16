//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by Jonathan Go on 16.02.22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}
final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        let navigationController = UINavigationController()
        
        let eventListCoodinator = EventListCoordinator(navigationController: navigationController)
        childCoordinators.append(eventListCoodinator)
        eventListCoodinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
