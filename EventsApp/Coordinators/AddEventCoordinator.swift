//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //create add event view controller
        let modalNavController = UINavigationController()
        let addEventVC = AddEventVC()
        modalNavController.setViewControllers([addEventVC], animated: false)
        //create add event view model
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.coordinator = self
        addEventVC.viewModel = addEventViewModel
        //present modally controller using navigation controller
        navigationController.present(modalNavController, animated: true, completion: nil)
        
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.childDidFinish(self)
    }
    
//    deinit {
//        print("deinit from add event coordinator")
//    }
    
}
