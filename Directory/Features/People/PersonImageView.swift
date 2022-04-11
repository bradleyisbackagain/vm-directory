//
//  PersonImageView.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit
import UIUtils

final class PersonImageView: UIAsyncImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipToCircle()
    }
    
    private func clipToCircle() {
        layer.masksToBounds = true
        layer.cornerRadius = bounds.size.height / 2
    }
}
