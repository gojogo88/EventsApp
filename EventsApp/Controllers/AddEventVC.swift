//
//  AddEventVC.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit

final class AddEventVC: UIViewController {
    
    var viewModel: AddEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.viewDidDisappear()
    }
    
//    deinit {
//        print("deinit from add event VC")
//    }
}
