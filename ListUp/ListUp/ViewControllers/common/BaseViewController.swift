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
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray
        stackView.distribution = .fillEqually
        return stackView
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
        
        
        for _ in 0..<4{
            let button = UIButton()
            button.setTitle("메뉴 이름", for: .normal)
            tabStackView.addArrangedSubview(button)
        }
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
