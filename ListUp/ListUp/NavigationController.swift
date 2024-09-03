//
//  ViewController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class NavigationController: UINavigationController {
    lazy var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }


}

