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
        backgroundColor = .red
        
        resetView()
        
        imageView.layer.cornerRadius = 44
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    }
    
    private func updateView(_ viewModel: GeneralInfoViewModel) {
        if let imageUrl = viewModel.imageUrl {
            imageView.load(url: imageUrl)
        }
        nameLabel.text = viewModel.name
        nicknameLabel.text = viewModel.nickname
        emailLabel.text = viewModel.email
        followersLabel.text = String(viewModel.followers ?? 0)
        followingLabel.text = String(viewModel.following ?? 0)
    }
    
    private func resetView() {
        imageView.image = UIImage(named: "avatar")
        nameLabel.text = nil
        nicknameLabel.text = nil
        emailLabel.text = nil
        followersLabel.text = nil
        followingLabel.text = nil
    }
}
