//
//  EventDetailVC.swift
//  EventsApp
//
//  Created by Jonathan Go on 18.02.22.
//

import UIKit

final class EventDetailVC: UIViewController {

    var viewModel: EventDetailViewModel!
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var timeRemainingStackView = TimeRemainingStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeirarchy()
        setupLayout()
        setupViews()
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self, let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            self.backgroundImageView.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.tappedEditButton))
    }
    
    private func setupHeirarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(timeRemainingStackView)
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges()
        timeRemainingStackView.pinToSuperviewEdges()
    }

}
