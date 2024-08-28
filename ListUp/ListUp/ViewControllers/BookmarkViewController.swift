//
//  BookmarkViewController.swift
//  ListUp
//
//  Created by 권희철 on 8/27/24.
//

import UIKit
import SafariServices

class BookmarkViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 각 indexPath.row마다 북마크 여부를 나타내기위한 변수
    private var isBookMarks: [Bool] = Array(repeating: true, count: 12)
    
    private lazy var bookmarkCollectionView: UICollectionView = {
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
        collectionView.register(BookMarkCollectionViewCell.self, forCellWithReuseIdentifier: "BookMarkCollectionViewCell")  // 메인 컨텐츠 셀
        collectionView.register(TopImageCollectionViewCell.self, forCellWithReuseIdentifier: "TopImageCollectionViewCell")  // 즐겨찾기List 이미지 셀
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {    // 각 섹션별로 collectionView Layout 크기 설정해주는 함수
        
        if indexPath.section == 0 { // 상단 이미지 셀은 가로로 길고 세로로 짧은 layout
            return CGSize(width: collectionView.bounds.width, height: 50)
        } else {
            return CGSize(width: 159, height: 230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.section == 0 { // 0번 섹션은 상단 이미지 셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImageCollectionViewCell", for: indexPath) as? TopImageCollectionViewCell else { return UICollectionViewCell() }
            cell.topImageView.image = UIImage(named: "long_bookmark")   // 이미지를 '즐겨찾기 List' 사진으로 설정
            
            return cell
        } else {    // 1번 섹션은 하단의 메인 컨텐츠의 컬렉션뷰 셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkCollectionViewCell", for: indexPath) as? BookMarkCollectionViewCell else { return UICollectionViewCell() }
            let isBookMarked: Bool = isBookMarks[indexPath.row]
            
            cell.mainImageView.image = UIImage(named: "subimage\(indexPath.row + 1)")
            cell.mainTextLabel.text = ["인터파크 쇼핑 앱 설치", "10% 무제한 할인 쿠폰"].randomElement()!
            cell.hashTagTextLabel.text = ["#3000원 #누구나", "#만원이상 #몇번이든"].randomElement()!
            cell.dateTextLabel.text = "24.02.01 ~ 24.04.01"
            
            cell.heartImageView.setImage(isBookMarked ? UIImage(named: "heartfull") : UIImage(named: "heart"), for: .normal)
            
            // 셀을 만들면서 기존에 생성되어있던 액션을 삭제합니다.
            cell.heartImageView.removeAction(identifiedBy: .init("toggle heart"), for: .touchUpInside)
            
            // 하트 이미지버튼에 액션을 추가합니다. action: row번째 bool값을 토글하고 해당 bool값으로 이미지를 다시 설정합니다.
            cell.heartImageView.addAction(UIAction(identifier: .init("toggle heart"), handler: { _ in
                self.isBookMarks[indexPath.row].toggle()
                let newState = self.isBookMarks[indexPath.row]
                cell.heartImageView.setImage(newState ? UIImage(named: "heartfull") : UIImage(named: "heart"), for: .normal)
            }), for: .touchUpInside)
            
            return cell
        }
        
    }

    // 셀 선택시 사파리뷰 띄우기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: "https://m.post.naver.com/viewer/postView.naver?volumeNo=37904830") {
            let viewController = SFSafariViewController(url: url)
            
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: true)
        }
    }
    
    override func setupInterface() {
        super.setupInterface()
        stackView.addArrangedSubview(bookmarkCollectionView)
    }
    
    override func setupLayOut() {
        super.setupLayOut()
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

//#Preview {
//    BookmarkViewController()
//}
