//
//  RepoCell.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 02/12/2021.
//

import UIKit

class RepoCell: UICollectionViewCell {
    enum Constants {
        static let reuseIdentifier: String = "repoCell"
    }
    
    var viewModel: RepoViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                resetView()
                return
            }
            updateView(viewModel)
        }
    }
    private let imageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let starImageView = UIImageView(image: UIImage(named: "star"))
    private let starLabel = UILabel()
    private let languageImageView = UIImageView(image: UIImage(named: "orange_dot"))
    private let languageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        resetView()
        setupImageView()
        setupNicknameLabel()
        setupNameLabel()
        setupDescriptionLabel()
        setupStarSection()
        setupLanguageSection()
    }
    
    private func updateView(_ viewModel: RepoViewModel) {
        if let imageUrl = viewModel.imageUrl {
            imageView.load(url: imageUrl)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        nicknameLabel.attributedText = NSMutableAttributedString(string: viewModel.nickname, attributes: [.kern: 0.4,
                                                                                                          .paragraphStyle: paragraphStyle])
        nameLabel.attributedText = NSMutableAttributedString(string: viewModel.name, attributes: [.kern: 0.4,
                                                                                                  .paragraphStyle: paragraphStyle])
        descriptionLabel.text = viewModel.description
        starLabel.attributedText = NSMutableAttributedString(string: String(viewModel.starCount), attributes: [.kern: 0.4,
                                                                                                         .paragraphStyle: paragraphStyle])
        languageLabel.attributedText = NSMutableAttributedString(string: String(viewModel.language), attributes: [.kern: 0.4,
                                                                                                                   .paragraphStyle: paragraphStyle])
    }
    
    private func resetView() {
        imageView.image = UIImage(named: "avatar")
        nicknameLabel.attributedText = nil
        nameLabel.attributedText = nil
        descriptionLabel.text = nil
        starLabel.attributedText = nil
        languageLabel.attributedText = nil
    }
    
    private func setupImageView() {
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    }
    
    private func setupNicknameLabel() {
        nicknameLabel.font = UIFont.systemFont(ofSize: 16)
        nicknameLabel.minimumScaleFactor = 0.5
        nicknameLabel.adjustsFontSizeToFitWidth = true
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nicknameLabel)
        nicknameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        nicknameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 7).isActive = true
        nicknameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupStarSection() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(starImageView)
        starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        starImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -34).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        starLabel.font = UIFont.systemFont(ofSize: 16)
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(starLabel)
        starLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4).isActive = true
        starLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor, constant: -2).isActive = true
    }
    
    private func setupLanguageSection() {
        languageImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageImageView)
        languageImageView.leadingAnchor.constraint(equalTo: starLabel.trailingAnchor, constant: 24).isActive = true
        languageImageView.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        languageImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        languageImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        languageLabel.font = UIFont.systemFont(ofSize: 16)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageLabel)
        languageLabel.leadingAnchor.constraint(equalTo: languageImageView.trailingAnchor, constant: 4).isActive = true
        languageLabel.centerYAnchor.constraint(equalTo: languageImageView.centerYAnchor, constant: -2).isActive = true
    }
}
