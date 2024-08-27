//
//  BaseViewController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class BaseViewController: UIViewController{
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var searchView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .group47
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOpacity = 0.25
        
        return stackView
    }()
    
    lazy var saleTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top1"), for: .normal)
        
        return button
    }()
    
    lazy var promotionTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top2"), for: .normal)

        return button
    }()
    
    lazy var snsTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top3"), for: .normal)

        return button
    }()
    
    lazy var categoryTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top4"), for: .normal)
        button.addAction(UIAction{ _ in
            print("category")
            let vc = FilterSheetViewController()
            vc.modalPresentationStyle = .pageSheet
            vc.sheetPresentationController?.detents = [.medium()]
            self.present(vc, animated: true)
        }, for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupInterface()
        setupLayOut()
    }
    
    public func setupInterface(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(searchView)
        stackView.addArrangedSubview(tabStackView)
        
        tabStackView.addArrangedSubview(saleTabButton)
        tabStackView.addArrangedSubview(promotionTabButton)
        tabStackView.addArrangedSubview(snsTabButton)
        tabStackView.addArrangedSubview(categoryTabButton)
    }
    public func setupLayOut(){
        let safeArea = view.safeAreaLayoutGuide
        for subview in view.subviews{
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            //            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
}


#Preview{
    BaseViewController()
}
