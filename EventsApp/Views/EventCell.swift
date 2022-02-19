//
//  EventCell.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit

final class EventCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
//    private lazy var timeRemainingLabels: [UILabel] = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 28, weight: .medium)
//        label.textColor = .white
//
//        let timeRemainingLabels = [label, label, label, label]
//        return timeRemainingLabels
//    }()
    
    private let timeRemainingStackView = TimeRemainingStackView()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black.withAlphaComponent(0.4)
        iv.layer.cornerRadius = 12
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            timeRemainingStackView,
            UIView(),
            dateLabel
        ])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .trailing
        sv.spacing = 8
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHeirarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        eventNameLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setupViews() {
        timeRemainingStackView.setup()
    }
    
    private func setupHeirarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.top, .leading, .trailing])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .trailing, .bottom], constant: 16)
        eventNameLabel.pinToSuperviewEdges([.leading, .bottom], constant: 16)
        NSLayoutConstraint.activate([
            eventNameLabel.rightAnchor.constraint(equalTo: verticalStackView.leftAnchor, constant: -8)
        ])
    }
    
    func update(with viewModel: EventCellViewModel) {
        if let timeRemainingViewModel = viewModel.timeRemainingViewModel {
            timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        viewModel.loadImage { image in
            self.backgroundImageView.image = image
        }
        
    }
}

