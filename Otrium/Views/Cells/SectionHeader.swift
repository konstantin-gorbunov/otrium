//
//  SectionHeader.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 02/12/2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    enum Constants {
        static let reuseIdentifier: String = "sectionHeader"
    }
    
    var viewModel: SectionHeaderViewModel? {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.14
            leftLabel.attributedText = NSMutableAttributedString(string: viewModel?.name ?? "", attributes: [.kern: 1.6,
                                                                                                         .paragraphStyle: paragraphStyle])
        }
    }
    
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        leftLabelSetup()
        rightLabelSetup()
    }
    
    private func leftLabelSetup() {
        leftLabel.font = UIFont.boldSystemFont(ofSize: 24)
        leftLabel.textAlignment = .left
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftLabel)
        leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func rightLabelSetup() {
        rightLabel.font = UIFont.systemFont(ofSize: 16)
        rightLabel.textAlignment = .right
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        rightLabel.attributedText = NSMutableAttributedString(string: "View all", attributes: [.kern: 0.4,
                                                                                               .underlineStyle: NSUnderlineStyle.thick.rawValue,
                                                                                               .paragraphStyle: paragraphStyle])
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightLabel)
        rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
