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
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        //tv.delegate = self
        tv.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        tv.tableFooterView = UIView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupHeirarchy()
        setupLayout()
        
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
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
    
    private func setupHeirarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.pinToSuperviewEdges()
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }

}


extension EventListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as? EventCell else { return UITableViewCell() }
            cell.update(with: eventCellViewModel)
            return cell
        }
    }
    
    
}
