//
//  GeneralInfoCell.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 30/11/2021.
//

import UIKit

class GeneralInfoCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseIdentifier: String = "generalInfo"
    }
    
    var viewModel: GeneralInfoViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                resetView()
                return
            }
            updateView(viewModel)
        }
    }
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let emailLabel = UILabel()
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        resetView()
        
        setupImageView()
        setupNameLabel()
        setupNicknameLabel()
        setupEmailLabel()
        setupFollowersLabel()
        setupFollowingLabel()
    }
    
    private func updateView(_ viewModel: GeneralInfoViewModel) {
        if let imageUrl = viewModel.imageUrl {
            imageView.load(url: imageUrl)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.07
        nameLabel.attributedText = NSMutableAttributedString(string: viewModel.name, attributes: [.kern: 2.4,
                                                                                                  .paragraphStyle: paragraphStyle])
        paragraphStyle.lineHeightMultiple = 1.28
        nicknameLabel.attributedText = NSMutableAttributedString(string: viewModel.nickname, attributes: [.kern: 0.4,
                                                                                                          .paragraphStyle: paragraphStyle])
        emailLabel.attributedText = NSMutableAttributedString(string: viewModel.email, attributes: [.kern: 0.4,
                                                                                                    .paragraphStyle: paragraphStyle])
        paragraphStyle.lineHeightMultiple = 1.19
        followersLabel.attributedText = NSMutableAttributedString(string: viewModel.followers, attributes: [.kern: 0.4,
                                                                                                            .paragraphStyle: paragraphStyle])
        followingLabel.attributedText = NSMutableAttributedString(string: viewModel.following, attributes: [.kern: 0.4,
                                                                                                            .paragraphStyle: paragraphStyle])
    }
    
    private func resetView() {
        imageView.image = UIImage(named: "avatar")
        nameLabel.text = nil
        nicknameLabel.text = nil
        emailLabel.text = nil
        followersLabel.text = nil
        followingLabel.text = nil
    }
    
    private func setupImageView() {
        imageView.layer.cornerRadius = 44
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 32)
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupNicknameLabel() {
        nicknameLabel.font = UIFont.systemFont(ofSize: 16)
        nicknameLabel.minimumScaleFactor = 0.5
        nicknameLabel.adjustsFontSizeToFitWidth = true
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nicknameLabel)
        nicknameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nicknameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        nicknameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    }
    
    private func setupEmailLabel() {
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.minimumScaleFactor = 0.5
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailLabel)
        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        emailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setupFollowersLabel() {
        followersLabel.font = UIFont.systemFont(ofSize: 16)
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(followersLabel)
        followersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        followersLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setupFollowingLabel() {
        followingLabel.font = UIFont.systemFont(ofSize: 16)
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(followingLabel)
        followingLabel.leadingAnchor.constraint(equalTo: followersLabel.trailingAnchor, constant: 16).isActive = true
        followingLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16).isActive = true
    }
}
