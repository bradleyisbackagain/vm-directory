//
//  PersonDetailViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 10/04/2022.
//

import Foundation
import UIKit
import UIUtils

/// Displays person detail information.
final class PersonDetailViewController: DetailItemTableViewController {
    
    let viewModel: PersonDetailViewModel
    
    init(viewModel: PersonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        super.items = viewModel.detailItems
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var profileImage: PersonImageView = {
        let loader = URLSessionAsyncImageViewLoader()
        let view = PersonImageView(loader: loader)
        view.height(equalTo: 120)
        view.constrainAsSquare()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.fullName
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = SemanticColor.textPrimary
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.backgroundColor = SemanticColor.backgroundPrimary
        stack.spacing = 16
        return stack
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImage.loadRemote(url: viewModel.avatarURL)
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        mainStack.padding(.all(16), color: SemanticColor.backgroundPrimary)
    }
}
