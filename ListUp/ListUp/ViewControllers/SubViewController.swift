//
//  SubViewController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class SubViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var isBookMarked: Bool = false  // 북마크 여부를 나타내기위한 변수
    
    private lazy var subCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 159, height: 230)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubViewCollectionViewCell.self, forCellWithReuseIdentifier: "SubViewCollectionViewCell")  // 메인 컨텐츠 셀
        collectionView.register(LastestCollectionViewCell.self, forCellWithReuseIdentifier: "LastestCollectionViewCell")  // 즐겨찾기List 이미지 셀
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int { // (상단 이미지 섹션, 메인 컨텐츠 섹션) 2개
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 12    // 메인 컨텐츠 섹션 임의로 20개로 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        } else {
            return CGSize(width: 159, height: 230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastestCollectionViewCell", for: indexPath) as? LastestCollectionViewCell else { return UICollectionViewCell() }
            cell.topImageView.image = UIImage(named: "lastest")
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubViewCollectionViewCell", for: indexPath) as? SubViewCollectionViewCell else { return UICollectionViewCell() }
            cell.mainImageView.image = UIImage(named: "subimage\(indexPath.row + 1)")
            cell.mainTextLabel.text = ["인터파크 쇼핑 앱 설치", "10% 무제한 할인 쿠폰", "인터라켄 3% 웰컴쿠폰", "2024 새해 쿠폰선물"].randomElement()!
            cell.hashTagTextLabel.text = ["#3000원 #누구나", "#만원이상 #몇번이든", "#중복적용 #누구나", "#네이버쇼핑 5~20%"].randomElement()!
            cell.dateTextLabel.text = "24.02.01 ~ 24.04.01"
            cell.heartImageView.addAction(UIAction { _ in
                self.isBookMarked.toggle()
                cell.heartImageView.setImage(self.isBookMarked ? UIImage(named: "heartfull") : UIImage(named: "heart"), for: .normal)
            }, for: .touchUpInside)
            
            return cell
        }
        
    }
    
    override func setupInterface() {
        super.setupInterface()
        stackView.addArrangedSubview(subCollectionView)
    }
    
    override func setupLayOut() {
        super.setupLayOut()
        
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

#Preview {
    SubViewController()
}
