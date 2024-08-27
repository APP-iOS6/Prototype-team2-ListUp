//
//  MainViewController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit
import SafariServices

class MainViewController: BaseViewController{
    let banerImages: [UIImage] = [.mainimage1, .mainimage2, .mainimage3]
    
    lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(MainBanerCell.self, forCellReuseIdentifier: "MainBanerCell")
        tableView.register(ShoppingmallListCell.self, forCellReuseIdentifier: "ShoppingmallListCell")
        tableView.register(RecommendCell.self, forCellReuseIdentifier: "RecommendCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.rowHeight = 100
    }
    
    override func setupInterface() {
        super.setupInterface()
        stackView.addArrangedSubview(mainTableView)
    }
    
    override func setupLayOut() {
        super.setupLayOut()
    
    }
    
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainBanerCell: MainBanerCell = tableView.dequeueReusableCell(withIdentifier: "MainBanerCell", for: indexPath) as! MainBanerCell
        
        let shoppingmallListCell: ShoppingmallListCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingmallListCell", for: indexPath) as! ShoppingmallListCell
        
        let recommendCell: RecommendCell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as! RecommendCell
//        let recommendCell: RecommendCell = RecommendCell()
        
        switch indexPath.row{
        case 0:
            //mainBanerCell.banners = self.banerImages
            self.mainTableView.rowHeight = 300
            return mainBanerCell
        case 1:
            self.mainTableView.rowHeight = 80
            shoppingmallListCell.buttonAction = {() -> () in
                if let url = URL(string: "https://www.naver.com") {
                    let viewController = SFSafariViewController(url: url)
                    
                    viewController.modalPresentationStyle = .pageSheet
                    self.present(viewController, animated: true)
                }
            }
            return shoppingmallListCell
        case 2:
            self.mainTableView.rowHeight = 1400
            recommendCell.tappedAction = {() -> () in
                if let url = URL(string: "https://www.naver.com") {
                    let viewController = SFSafariViewController(url: url)
                    
                    viewController.modalPresentationStyle = .pageSheet
                    self.present(viewController, animated: true)
                }
            }
            return recommendCell
        default:
            return mainBanerCell
        }
    }
    
}


#Preview{
    MainViewController()
}
