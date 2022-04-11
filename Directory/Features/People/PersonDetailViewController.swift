//
//  PersonDetailViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 10/04/2022.
//

import Foundation
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = viewModel.fullName
        view.addSubview(label)
        view.edgeConstrain(subview: label, layoutGuide: .margins)
    }
}
