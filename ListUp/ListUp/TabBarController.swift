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
        tabBar.tintColor = UIColor.systemMint
        
        
        buildViewController()
    }
    
    private func buildViewController(){
        let mainViewController: UIViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(title: "", image: .tabhome.withRenderingMode(.alwaysOriginal), selectedImage: .tabhome)

        let subViewController: UIViewController = SubViewController()
        subViewController.tabBarItem = UITabBarItem(title: "", image: .tablist.withRenderingMode(.alwaysOriginal), selectedImage: .tablist)

        let bookmarkViewController: UIViewController = BookmarkViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(title: "", image: .tabheart.withRenderingMode(.alwaysOriginal), selectedImage: .tabheart)
        
        let alarmViewContorller: UIViewController = AlarmViewController()
        alarmViewContorller.tabBarItem = UITabBarItem(title: "", image: .tabalarm.withRenderingMode(.alwaysOriginal), selectedImage: .tabalarm)

        viewControllers = [mainViewController, subViewController, bookmarkViewController,alarmViewContorller ]
    }
}

#Preview {
    TabBarController()
}
