//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by Jonathan Go on 18.02.22.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    //private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    private lazy var timeRemainingLabels: [UILabel] = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: viewModel.font, weight: .medium)
        label.textColor = .white
        label.text = ""
        
        let timeRemainingLabels = [label, label, label, label]
        return timeRemainingLabels
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        timeRemainingLabels.forEach {
            addArrangedSubview($0)
        }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func update(with viewModel: TimeRemainingViewModel) {
        timeRemainingLabels.forEach {
//            $0.text = ""
            $0.font = .systemFont(ofSize: viewModel.fontSize, weight: .medium)
        }
        
        viewModel.timeRemainingParts.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        
        alignment = viewModel.alignment
        
    }
}
