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
    private var modalNavController: UINavigationController?
    private var completion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //create add event view controller
        self.modalNavController = UINavigationController()
        let addEventVC = AddEventVC()
        modalNavController?.setViewControllers([addEventVC], animated: false)
        //create add event view model
        let addEventViewModel = AddEventViewModel(cellBuilder: EventsCellBuilder())
        addEventViewModel.coordinator = self
        addEventVC.viewModel = addEventViewModel
        //present modally controller using navigation controller
        if let modalNavController = modalNavController {
            navigationController.present(modalNavController, animated: true, completion: nil)
        }
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        parentCoordinator?.onSaveEvent()
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        guard let modalNavController = modalNavController else { return }
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavController)
        imagePickerCoordinator.onFinishPicking = { [weak self] image in
            self?.completion(image!)
            self?.modalNavController?.dismiss(animated: true, completion: nil)
        }
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
//    func didFinishPicking(_ image: UIImage) {
//        completion(image)
//        modalNavController?.dismiss(animated: true, completion: nil)
//    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
//    deinit {
//        print("deinit from add event coordinator")
//    }
    
}
