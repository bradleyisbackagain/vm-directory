//
//  ViewController.swift
//  Directory
//
//  Created by Bradley Mackey on 07/04/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Hello world"
        view.addSubview(label)
        view.edgeConstrain(subview: label, layoutGuide: .safeArea)
    }

}

