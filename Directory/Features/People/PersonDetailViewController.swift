//
//  PersonDetailViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 10/04/2022.
//

import Foundation
import UIKit
import UIUtils

final class PersonDetailViewController: UIViewController {
    
    let viewModel: PersonDetailViewModel
    
    init(viewModel: PersonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var profileImage: PersonImageView = {
        let loader = URLSessionAsyncImageViewLoader()
        let view = PersonImageView(loader: loader)
        let size: CGFloat = 120
        view.height(equalTo: size)
        view.constrainAsSquare()
        view.layer.cornerRadius = 120/2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.fullName
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .black
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(mainStack)
        view.edgeConstrain(subview: mainStack, layoutGuide: .margins)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImage.loadRemote(url: viewModel.avatarURL)
    }
}
