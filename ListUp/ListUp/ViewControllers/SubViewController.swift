import UIKit

class SubViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    



    // 북마크 여부를 나타내기위한 변수
    private var isBookMarks: [Bool] = Array(repeating: false, count: 12)
    private var imageNames: [String] = []  // 이미지 파일 이름들을 저장할 배열
    private var randomImageNames: [String] = [] // 섞인 이미지를 저장할 배열
    private var randomURLs: [URL] = [] // 섞인 URL들을 저장할 배열
    private var topButtonStates: [Bool] = Array(repeating: false, count: 7)
    var topFilteringButtons: [UIButton] = []

    private lazy var topFilteringScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 700, height: 20)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.isPagingEnabled = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private lazy var topFilteringStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()  // 이미지를 초기화 및 섞기
        subCollectionView.reloadData()
    }

    // 이미지 파일 이름 초기화 및 섞기
    private func setupImages() {
        // 이미지 이름 초기화
        imageNames = (1...12).map { "subimage\($0)" }
        // 해시태그 초기화
        randomHashTags = [
            "#3000원 #누구나", "#만원이상 #몇번이든", "#중복적용 #누구나", "#네이버쇼핑 5~20%",
            "#쿠폰 #할인", "#이벤트 #참여", "#특가 #한정판매", "#무료배송 #전상품"
        ]
        // 날짜 초기화
        randomDates = [
            "24.02.01 ~ 24.04.01", "24.03.01 ~ 24.05.01", "24.04.01 ~ 24.06.01", "24.05.01 ~ 24.07.01"
        ]
        // URL 초기화
        randomURLs = [
            URL(string: "https://kr.trip.com/sale/w/9836/2024summergetaway.html?locale=ko-KR&curr=krw&promo_referer=405_9836_1")!,
            URL(string: "https://shopping.naver.com/festa/gift/66a1e70db2b88f039c8c2db9?dtm_source=shopping_layer&dtm_medium=mktatrb_sh&dtm_campaign=2408-shopping-002&pcode=shopping_layer&campaign_id=2408-shopping-002&channel_id=shopping_layer")!,
            URL(string: "https://shop-events.interpark.com/exhibition?exhibitionCode=240125002")!,
            URL(string: "https://m.flyairseoul.com/CM/ko/eventView.do?seq=1806&type=I")!,
            URL(string: "https://www.baskinrobbins.co.kr/play/event/view.php?seq=205&category=ALL")!,
            URL(string: "https://www.kia.com/kr/event/detail?eventId=351&statusCd=PEND")!
        ]
        // 이미지 이름 섞기
        randomImageNames = imageNames.shuffled()
    }

    // 섹션 수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 각 섹션별 항목 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        randomImageNames.count // 랜덤 이미지 수
    }
    
    // 섹션별 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 159, height: 230)
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubViewCollectionViewCell", for: indexPath) as? SubViewCollectionViewCell else { return UICollectionViewCell() }
            
            // 섞인 이미지 설정
            cell.mainImageView.image = UIImage(named: randomImageNames[indexPath.row])
            
            // 한글 라벨 설정
            cell.mainTextLabel.text = ["인터파크 쇼핑 앱 설치", "10% 무제한 할인 쿠폰", "인터라켄 3% 웰컴쿠폰", "2024 새해 쿠폰선물"].randomElement()!
            cell.hashTagTextLabel.text = randomHashTags.randomElement()!
            cell.dateTextLabel.text = randomDates.randomElement()
            
            // 북마크 버튼 설정
            cell.heartImageView.addAction(UIAction { _ in
                self.isBookMarked.toggle()
                cell.heartImageView.setImage(self.isBookMarked ? UIImage(named: "heartfull") : UIImage(named: "heart"), for: .normal)
            }, for: .touchUpInside)
            
            return cell
    }

    override func setupInterface() {
        super.setupInterface()
        stackView.addArrangedSubview(topFilteringScrollView)
        stackView.addArrangedSubview(subCollectionView)
        topFilteringScrollView.addSubview(topFilteringStackView)
        
        // 상단 필터링 버튼들 추가
        
        for i in 0...6 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "filter\(i+1)"), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.addAction(UIAction { _ in
                self.topButtonTapped(index: i)
                print("\(self.topButtonStates)")
            }, for: .touchUpInside)
            topFilteringButtons.append(button)
        }
        
        for i in topFilteringButtons {
            topFilteringStackView.addArrangedSubview(i)
        }
        
        
    }
    
    override func setupLayOut() {
        super.setupLayOut()
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            topFilteringScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topFilteringScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            topFilteringScrollView.heightAnchor.constraint(equalToConstant: 20),
            topFilteringStackView.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }

    // 셀 선택 시 상세 페이지로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            let detailVC = DetailViewController()
            detailVC.selectedImage = UIImage(named: randomImageNames[indexPath.row])
            
            navigationController?.pushViewController(detailVC, animated: true)

        }
    }

    // 탭 선택 시 해당 섹션으로 업데이트
    func updateTab(to tab: TabType) {
        setupImages()  // 이미지를 섞어 줌
        subCollectionView.reloadData()
    }
    

    enum TabType {
        case sale, promotion, sns, category
    }
    
    // 상단 최신순,인기순,,, 탭 선택시 호출되는 함수
    func topButtonTapped(index: Int) {
        // 인덱스번째 버튼의 상태를 true, 나머지는 false로 변경
        for (i, _) in topButtonStates.enumerated() {
            topButtonStates[i] = (i == index)
        }
        
        // 인덱스번째 버튼의 이미지를 선택된이미지로 변경하는 함수
        for (i, button) in topFilteringButtons.enumerated() {
            let img = topButtonStates[i] ? UIImage(named: "filterred\(i+1)") : UIImage(named: "filter\(i+1)")
            button.setImage(img, for: .normal)
        }
    }
}

#Preview {
    SubViewController()
}

