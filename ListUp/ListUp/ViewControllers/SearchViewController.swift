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
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.titleView = searchBar
    }
    
}

extension SearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.navigationController?.popViewController(animated: true)
        return true
    }
}
