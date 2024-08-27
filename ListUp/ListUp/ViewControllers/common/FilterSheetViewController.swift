//
//  FilterSheetViewController.swift
//  ListUp
//
//  Created by 최승호 on 8/27/24.
//

import UIKit

class FilterSheetViewController: UIViewController {

    lazy var sheetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shift")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(sheetImageView)
        
        sheetImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sheetImageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            sheetImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

}

#Preview{
    FilterSheetViewController()
}
