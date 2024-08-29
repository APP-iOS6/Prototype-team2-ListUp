//
//  File.swift
//  ListUp
//
//  Created by 권희철 on 8/29/24.
//

import UIKit

class SearchViewController: UIViewController{
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "나에게 딱 맞는 이벤트를 검색"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.addAction(UIAction{_ in
            self.navigationController?.popViewController(animated: true)
        }, for: .editingDidEnd)
        searchBar.searchTextField.delegate = self
//        searchBar.inputAccessoryView = toolbar
        return searchBar
    }()
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "search_page")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
//    lazy var toolbar: UIToolbar = {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: SearchViewController.self, action: #selector(doneButtonTapped))
//        toolbar.setItems([flexible, doneButton], animated: true)
//        return toolbar
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.titleView = searchBar
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
//    @objc func doneButtonTapped(){
//        self.searchBar.resignFirstResponder()
//    }
//    
}

extension SearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //키보드에서 return버튼 눌렀을 때 이벤트
        self.navigationController?.popViewController(animated: true)
        let topController = self.navigationController?.topViewController as? TabBarController
        if let topController{
            topController.selectedIndex = 1
        }
        return true
    }
}
