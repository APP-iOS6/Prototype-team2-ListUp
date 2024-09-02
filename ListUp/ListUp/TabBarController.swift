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
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = UIColor.systemRed
        
        
        buildViewController()
    }
    
    private func buildViewController(){
        let mainViewController: UIViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(title: "", image: .tabhome, selectedImage: .tabhome)

        let subViewController: UIViewController = SubViewController()
        subViewController.tabBarItem = UITabBarItem(title: "", image: .tablist, selectedImage: .tablist)

        let bookmarkViewController: UIViewController = BookmarkViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(title: "", image: .tabheart, selectedImage: .tabheart)
        
        let alarmViewContorller: UIViewController = AlarmViewController()
        alarmViewContorller.tabBarItem = UITabBarItem(title: "", image: .tabalarm, selectedImage: .tabalarm)

        viewControllers = [mainViewController, subViewController, bookmarkViewController,alarmViewContorller ]
    }
}

#Preview {
    TabBarController()
}
