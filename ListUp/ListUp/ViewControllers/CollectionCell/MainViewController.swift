//
//  MainViewController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit
import SafariServices

class MainViewController: BaseViewController {
    
    let urls: [String] = [
        "https://shop.interpark.com/malls/index.html?smid1=header&smid2=logo",
        "https://m.post.naver.com/viewer/postView.naver?volumeNo=29830794&memberNo=30633733&navigationType=push",
        "https://www.lotteon.com/p/display/main/lotteon"
    ]
    
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let mainBanerCell: MainBanerCell = tableView.dequeueReusableCell(withIdentifier: "MainBanerCell", for: indexPath) as? MainBanerCell else {
                return UITableViewCell()
            }
            
            // MainBanerCell의 imageTappedAction 클로저를 설정하여 Safari로 연결
            mainBanerCell.imageTappedAction = { [weak self] url in
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.modalPresentationStyle = .pageSheet
                self?.present(safariViewController, animated: true)
            }
            
            return mainBanerCell
        case 1:
            let sectionCell: SectionCell = SectionCell()
            sectionCell.sectionImageView.image = .shoppingmall
            sectionCell.selectionStyle = .none
            return sectionCell
        case 2:
            guard let shoppingmallListCell: ShoppingmallListCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingmallListCell", for: indexPath) as? ShoppingmallListCell else {
                return UITableViewCell()
            }
            
            shoppingmallListCell.buttonAction = { () -> () in
                if let url = URL(string: "https://www.naver.com") {
                    let safariViewController = SFSafariViewController(url: url)
                    safariViewController.modalPresentationStyle = .pageSheet
                    self.present(safariViewController, animated: true)
                }
            }
            return shoppingmallListCell
        case 3:
            let sectionCell: SectionCell = SectionCell()
            sectionCell.sectionImageView.image = .recomand
            sectionCell.selectionStyle = .none
            return sectionCell
        case 4:
            guard let recommendCell: RecommendCell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as? RecommendCell else {
                return UITableViewCell()
            }
            
            recommendCell.tappedAction = { (index: Int) -> () in
                if let url = URL(string: self.urls[index - 1]) {
                    let safariViewController = SFSafariViewController(url: url)
                    safariViewController.modalPresentationStyle = .pageSheet
                    self.present(safariViewController, animated: true)
                }
            }
            return recommendCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 2:
            return 100
        case 4:
            return 1400
        default:
            return 30
        }
    }
}


#Preview{
    MainViewController()
}
