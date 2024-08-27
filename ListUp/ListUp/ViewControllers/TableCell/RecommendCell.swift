//
//  RecommandCell.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit

class RecommendCell: UITableViewCell {
//                        UICollectionViewDelegate, UICollectionViewDataSource{
    private lazy var recommendStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var isBookMarked: Bool = false

    var tappedAction: ()-> () = {}
    
//    private lazy var recommendCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        layout.itemSize = CGSize(width: 159, height: 230)
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .systemBackground
//        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: "MainCollectionCell")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(recommendStackView)
        for i in 1...3{
            let button = UIButton()
            button.setImage(UIImage(named: "mainlist\(i)"), for: .normal)
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
            button.translatesAutoresizingMaskIntoConstraints = false
            button.imageView?.contentMode = .scaleAspectFit
            
            recommendStackView.addArrangedSubview(button)
            
            button.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 466).isActive = true
            button.imageView?.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            button.imageView?.heightAnchor.constraint(equalToConstant: 466).isActive = true
            
            button.addAction(UIAction{_ in
                self.tappedAction()
            }, for: .touchUpInside)
        }
        
//        contentView.addSubview(recommendCollectionView)
//        
//        NSLayoutConstraint.activate([
//            recommendCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            recommendCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            recommendCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            recommendCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 12
//    }
//    
//    func collectionVIew(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
////        if indexPath.section == 0{
////            return CGSize(width: collectionView.bounds.width, height: 50)
////        }else{
////            return CGSize(width: 159, height: 230)
////        }
//        return CGSize(width: 159, height: 230)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as? MainCollectionCell else{return UICollectionViewCell()}
//        cell.mainIamgeView.image = UIImage(named: "subimage\(indexPath.row + 1)")
//        cell.mainTextLabel.text = ["인터파크 쇼핑 앱 설치", "10% 무제한 할인 쿠폰"].randomElement()!
//        cell.hashTagTextLabel.text = ["#3000원 #누구나", "#만원이상 #몇번이든"].randomElement()!
//        cell.dateTextLabel.text = "24.02.01 ~ 24.04.01"
//        cell.heartImageView.addAction(UIAction{ _ in
//            self.isBookMarked.toggle()
//        }, for: .touchUpInside)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.tappedAction()
//    }
    
}
