//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import Foundation

final class AddEventViewModel {
    var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
//    deinit {
//        print("deinit from add event view model")
//    }
}
