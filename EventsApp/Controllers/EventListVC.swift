//
//  EventListVC.swift
//  EventsApp
//
//  Created by Jonathan Go on 16.02.22.
//

import UIKit

class EventListVC: UIViewController {

//    static func instantiate() -> EventListVC {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let controller = storyboard.instantiateViewController(withIdentifier: "EventListVC") as! EventListVC
//        return controller
//    }
    
    var viewModel: EventListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }

}
