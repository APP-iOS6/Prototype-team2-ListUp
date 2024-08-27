//
//  TabBarController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class TabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .systemGray5
        
        buildViewController()
    }
    
    private func buildViewController(){
        let mainViewController: UIViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(title: "", image: .tabhome, tag: 1)
        let subViewController: UIViewController = SubViewController()
        subViewController.tabBarItem = UITabBarItem(title: "", image: .tablist, tag: 2)
        let alarmViewContorller: UIViewController = AlarmViewController()
        alarmViewContorller.tabBarItem = UITabBarItem(title: "", image: .tabalarm, tag: 3)
        let bookmarkViewController: UIViewController = BookmarkViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(title: "", image: .tabheart, tag: 4)
        
        viewControllers = [mainViewController, subViewController, alarmViewContorller, bookmarkViewController]
    }
}
