//
//  ListItemTableViewCell.swift
//  Directory
//
//  Created by Bradley Mackey on 09/04/2022.
//

import UIKit
import UIUtils

final class ListItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListItemTableViewCell"
    
    fileprivate lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.textColor = SemanticColor.textPrimary
        lbl.setContentCompressionResistancePriority(.required, for: .vertical)
        lbl.accessibilityHint = "Title"
        lbl.accessibilityIdentifier = "TitleLabel"
        return lbl
    }()
    
    fileprivate lazy var subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .footnote)
        lbl.textColor = SemanticColor.textSecondary
        lbl.setContentCompressionResistancePriority(.required, for: .vertical)
        lbl.accessibilityHint = "Subtitle"
        lbl.accessibilityIdentifier = "SubtitleLabel"
        return lbl
    }()
    
    fileprivate lazy var iconImageView: UIAsyncImageView = {
        let loader = URLSessionAsyncImageViewLoader()
        let img = UIAsyncImageView(loader: loader)
        let imageSize: CGFloat = 30
        // circle mask
        img.layer.cornerRadius = imageSize / 2
        img.layer.masksToBounds = true
        // constrain 1:1 aspect ratio
        img.height(equalTo: imageSize)
        img.constrainAsSquare()
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        img.setContentHuggingPriority(.required, for: .horizontal)
        return img
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, labelStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .top
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerStack)
        contentView.edgeConstrain(subview: containerStack, layoutGuide: .margins)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.cancelRemote()
    }
}

extension ListItemViewModel {
    func configure(_ cell: ListItemTableViewCell) {
        title.bind { title in
            cell.titleLabel.text = title
        }
        subtitle.bind { subtitle in
            cell.subtitleLabel.text = subtitle
        }
        icon.bind { icon in
            if let icon = icon {
                cell.iconImageView.isHidden = false
                switch icon {
                case .local(let name, let tint):
                    cell.iconImageView.image = UIImage(named: name)?
                        .withRenderingMode(.alwaysTemplate)
                    cell.iconImageView.tintColor = tint ?? SemanticColor.textPrimary
                case .url(let url):
                    cell.iconImageView.loadRemote(url: url)
                }
            } else {
                cell.iconImageView.isHidden = true
            }
        }
        let hasAction = onSelection != nil
        cell.accessoryType = hasAction ? .disclosureIndicator : .none
    }
}
