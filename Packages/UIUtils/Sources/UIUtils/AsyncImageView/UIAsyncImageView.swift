//
//  UIAsyncImageView.swift
//
//  Created by Bradley Mackey on 10/04/2022.
//

import UIKit

/// A UIImageView that can load an image from a URL.
open class UIAsyncImageView: UIImageView {
    /// The service that performs the loading of the image.
    public var loader: AsyncImageViewLoader
    
    public init(loader: AsyncImageViewLoader) {
        self.loader = loader
        super.init(image: nil)
        configureUI()
    }
    
    private lazy var imageLoadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .gray
        return spinner
    }()
    
    private func configureUI() {
        addSubview(imageLoadingIndicator)
        imageLoadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageLoadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - API

extension UIAsyncImageView {
    /// Start the load of the image from a remote source.
    public func loadRemote(url: URL) {
        imageLoadingIndicator.startAnimating()
        loader.load(url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.image = image
                case .failure(let error):
                    print("ERROR LOADING IMAGE:", error)
                }
                self?.imageLoadingIndicator.stopAnimating()
            }
        }
    }
    
    /// Unload the current image and cancel any requests.
    public func cancelRemote() {
        loader.cancelLoad()
        imageLoadingIndicator.stopAnimating()
        image = nil
    }
}
