import UIKit
import SafariServices

class BookmarkViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    // 각 indexPath.row마다 북마크 여부를 나타내기위한 변수
    private var isBookMarks: [Bool] = Array(repeating: true, count: 12)
    

    private var imageNames: [String] = []  // 이미지 파일 이름들을 저장할 배열
    private var randomImageNames: [String] = [] // 섞인 이미지를 저장할 배열
    private var randomURLs: [URL] = [] // 섞인 URL들을 저장할 배열

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
        collectionView.register(LastestCollectionViewCell.self, forCellWithReuseIdentifier: "LastestCollectionViewCell")  // 즐겨찾기 이미지 셀
        collectionView.register(BookMarkCollectionViewCell.self, forCellWithReuseIdentifier: "BookMarkCollectionViewCell")

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagesAndURLs()  // 이미지 및 URL 초기화 및 섞기
        subCollectionView.reloadData()
    }

    // 이미지 및 URL 초기화 및 섞기
    private func setupImagesAndURLs() {
        // 이미지 이름 초기화
        imageNames = (1...12).map { "subimage\($0)" }
        // 이미지 이름 섞기
        randomImageNames = imageNames.shuffled()

        // URL 초기화
        let urls = [
            URL(string: "https://kr.trip.com/sale/w/9836/2024summergetaway.html?locale=ko-KR&curr=krw&promo_referer=405_9836_1")!,
            URL(string: "https://shopping.naver.com/festa/gift/66a1e70db2b88f039c8c2db9?dtm_source=shopping_layer&dtm_medium=mktatrb_sh&dtm_campaign=2408-shopping-002&pcode=shopping_layer&campaign_id=2408-shopping-002&channel_id=shopping_layer")!,
            URL(string: "https://shop-events.interpark.com/exhibition?exhibitionCode=240125002")!,
            URL(string: "https://m.flyairseoul.com/CM/ko/eventView.do?seq=1806&type=I")!,
            URL(string: "https://www.baskinrobbins.co.kr/play/event/view.php?seq=205&category=ALL")!,
            URL(string: "https://www.kia.com/kr/event/detail?eventId=351&statusCd=PEND")!
        ]
        // URL 섞기
        randomURLs = Array(repeating: urls, count: randomImageNames.count / urls.count + 1)
            .flatMap { $0 }
            .shuffled()
    }

    // 섹션 수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2  // (상단 이미지 섹션, 메인 컨텐츠 섹션) 2개
    }

    // 각 섹션별 항목 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : randomImageNames.count // 첫 번째 섹션은 1개, 두 번째 섹션은 랜덤 이미지 수
    }

    // 섹션별 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        } else {
            return CGSize(width: 159, height: 230)
        }
    }

    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastestCollectionViewCell", for: indexPath) as? LastestCollectionViewCell else { return UICollectionViewCell() }
            cell.topImageView.image = UIImage(named: "lastest")
            return cell
        } else {    // 1번 섹션은 하단의 메인 컨텐츠의 컬렉션뷰 셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkCollectionViewCell", for: indexPath) as? BookMarkCollectionViewCell else { return UICollectionViewCell() }
            let isBookMarked: Bool = isBookMarks[indexPath.row]
            
//            cell.mainImageView.image = UIImage(named: "subimage\(indexPath.row + 1)")
            // 섞인 이미지 설정
            cell.mainImageView.image = UIImage(named: randomImageNames[indexPath.row])
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

    // 셀 선택 시 사파리 뷰 띄우기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let selectedURL = randomURLs[indexPath.row]
            let viewController = SFSafariViewController(url: selectedURL)
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: true)
        }
    }

    // 탭 선택 시 해당 섹션으로 업데이트
    func updateTab(to tab: TabType) {
        setupImagesAndURLs()  // 이미지 및 URL을 섞어 줌
        subCollectionView.reloadData()
    }

    enum TabType {
        case sale, promotion, sns, category
    }
}
