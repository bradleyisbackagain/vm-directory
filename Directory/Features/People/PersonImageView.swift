//
//  PersonImageView.swift
//  Directory
//
//  Created by Bradley Mackey on 11/04/2022.
//

import UIKit
import UIUtils

/// An image view for displaying a user profile image, circle cropped.
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
