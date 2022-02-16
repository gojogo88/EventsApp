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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedRightBarButtonItem))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tappedRightBarButtonItem() {
        print("tapped right bar button")
    }

}
