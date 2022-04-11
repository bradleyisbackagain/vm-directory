//
//  ListItemTableViewCell.swift
//  Directory
//
//  Created by Bradley Mackey on 09/04/2022.
//

import UIKit

final class ListItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListItemTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .footnote)
        lbl.textColor = .gray
        return lbl
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
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        contentView.edgeConstrain(subview: stack, layoutGuide: .margins)
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
    }
}
