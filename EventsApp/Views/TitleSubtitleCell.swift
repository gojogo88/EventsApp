//
//  TitleSubtitleCell.swift
//  EventsApp
//
//  Created by Jonathan Go on 17.02.22.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    lazy var subtitleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 20, weight: .medium)
        return tf
    }()
    
    private lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black.withAlphaComponent(0.4)
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleTextField,
            photoImageView
        ])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        
        return sv
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        return dp
    }()
    
    private lazy var toolBar: UIToolbar = {
        let tb = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
        tb.setItems([doneButton], animated: false)
        return tb
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private var viewModel: TitleSubtitleCellViewModel?
    
    private let padding: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHeirarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
    }
    
    private func setupHeirarchy() {
        contentView.addSubview(verticalStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            //verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeHolder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePicker
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        
        photoImageView.image = viewModel.image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : 0
    }
    
    @objc func tappedDone() {
        viewModel?.update(datePicker.date )
    }
}
