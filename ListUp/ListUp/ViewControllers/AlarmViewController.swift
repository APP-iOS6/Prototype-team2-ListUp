import UIKit

class AlarmViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    
    private var isSelected: Bool = false
    var buttonStates = [("쇼핑몰", Array(repeating: false, count: 9)),
                        ("도서", Array(repeating: false, count: 8)),
                        ("가전/디지털", Array(repeating: false, count: 7)),
                        ("패션", Array(repeating: false, count: 12))]
    
    let imageForButton: UIImage = UIImage(named: "select")!  // Replace with your image
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 70, right: 20) // 양 끝쪽에 20포인트씩의 공간 추가
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.register(AlarmButtonCollectionViewCell.self, forCellWithReuseIdentifier: "AlarmButtonCell")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        return collectionView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isHidden = false // Initially hidden
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("알람완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        if let gradientImage = UIImage(named: "gradiant") {
            button.setBackgroundImage(gradientImage, for: .normal)
        }
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let sections = [
        ("쇼핑몰", ["네이버 쇼핑", "쿠팡", "홈플러스", "옥션", "11번가", "G마켓", "롯데 온", "신세계", "트레이더스"]),
        ("도서", ["교보문고", "예스24", "리디북스", "네이버 시리즈", "카카오페이지", "문피아", "조아라", "밀리의 서재"]),
        ("가전/디지털", ["하이마트", "인터파크", "전자랜드", "다나와", "삼성전자 스토어", "애플 스토어", "KT 스토어"]),
        ("패션", ["무신사", "W컨셉", "지그재그", "에이블리", "29CM", "스타일쉐어", "하이버", "브랜디", "더한섬닷컴", "SSF샵", "자라", "H&M"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupImageView()
        setupCompleteButton()
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "longalarm") // Replace "longalarm" with your image name
        imageView.isHidden = false // Show the imageView if it was hidden initially
    }
    
    private func setupCollectionView() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints for the collectionView
            collectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
        ])
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true // Set image view height as needed
    }
    
    private func setupCompleteButton() {
        stackView.addArrangedSubview(completeButton)
        NSLayoutConstraint.activate([
            completeButton.heightAnchor.constraint(equalToConstant: 35), // Set height as needed
            completeButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 150),
            completeButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -150),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20) // Adjust bottom spacing as needed
        ])
    }
    
    @objc private func completeButtonTapped() {
        let sampleAlarmVC = SampleAlarmViewController()
        sampleAlarmVC.modalPresentationStyle = .fullScreen
        present(sampleAlarmVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].1.count
    }
    

    
}

extension AlarmViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmButtonCell", for: indexPath) as? AlarmButtonCollectionViewCell else {return UICollectionViewCell()}
        
        let title = sections[indexPath.section].1[indexPath.item]
        
        cell.button.setTitle(title, for: .normal)
        cell.buttonAction = {()->() in
            cell.buttonSelected.toggle()
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let sectionInsetPadding: CGFloat = 20 // 양 끝쪽에 20포인트씩의 공간을 추가
        
        let totalSpacing = (padding * 3) + (sectionInsetPadding * 2) // 추가된 패딩을 포함
        let width = (collectionView.frame.width - totalSpacing) / 4
        
        return CGSize(width: width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        
        let sectionTitle = sections[indexPath.section].0
        headerView.configure(with: sectionTitle)
        
        headerView.buttonAction = {()-> () in
            headerView.isSelected.toggle()
            if headerView.isSelected{
                headerView.allSelectButton.setImage(.checkbox, for: .normal)
            }else{
                headerView.allSelectButton.setImage(.box, for: .normal)
            }
            
            for i in 0..<self.sections[indexPath.section].1.count{
                let cell = collectionView.cellForItem(at: [indexPath.section, i]) as? AlarmButtonCollectionViewCell
                cell?.buttonSelected = headerView.isSelected
            }
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
}

// 섹션 헤더 뷰
class SectionHeaderView: UICollectionReusableView {
    
    var buttonAction : ()->() = {}
    var isSelected : Bool = false
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var allSelectButton: UIButton = {
        let button = UIButton()
        button.setImage(.box, for: .normal)
        button.frame.size = CGSize(width: 10, height: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(identifier: .init("AllSelect")){_ in
            self.buttonAction()
        }, for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(allSelectButton)
        
        isSelected = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -6),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            allSelectButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 6),
            allSelectButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        label.text = title
    }
}

// #Preview section removed for compatibility
#Preview{
    AlarmViewController()
}
