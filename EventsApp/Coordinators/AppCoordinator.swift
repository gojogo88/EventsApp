//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by Jonathan Go on 16.02.22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ childCoordinator: Coordinator) { }
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
