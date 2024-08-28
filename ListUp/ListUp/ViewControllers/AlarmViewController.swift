import UIKit

class AlarmViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? ButtonCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = sections[indexPath.section].1[indexPath.item]
        cell.configure(with: title, image: imageForButton)
        let isActive = buttonStates[indexPath.section].1[indexPath.item]
        if isActive {
            cell.showImage()
        } else {
            cell.hideImage()
        }
        cell.button.addTarget(self, action: #selector(uiButtonTapped(_:)), for: .touchUpInside)
        
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
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    @objc private func uiButtonTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: buttonPosition) {
            let isActive = buttonStates[indexPath.section].1[indexPath.item]
            buttonStates[indexPath.section].1[indexPath.item].toggle()
            collectionView.reloadItems(at: [indexPath])
            
            if let cell = collectionView.cellForItem(at: indexPath) as? ButtonCollectionViewCell {
                if buttonStates[indexPath.section].1[indexPath.item] {
                    cell.showImage()
                } else {
                    cell.hideImage()
                }
            }
        }
    }
    
    // 커스텀 셀
    class ButtonCollectionViewCell: UICollectionViewCell {
        
        let button: UIButton = {
            let button = UIButton(type: .system)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.red.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.isHidden = true  // Initially hidden
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(button)
            contentView.addSubview(imageView)
            
            // Add constraints
            NSLayoutConstraint.activate([
                // Button constraints
                button.topAnchor.constraint(equalTo: contentView.topAnchor),
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                // ImageView constraints
                imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: button.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: button.heightAnchor)
            ])
            
            // Ensure imageView is on top of button
            contentView.bringSubviewToFront(imageView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with title: String, image: UIImage?) {
            button.setTitle(title, for: .normal)
            
            if let image = image {
                imageView.image = image
                imageView.alpha = 1.0 // 이미지 투명도 조정 (0.0 ~ 1.0 범위)
                imageView.layer.cornerRadius = 3
            }
        }

        func showImage() {
            imageView.isHidden = false
        }

        func hideImage() {
            imageView.isHidden = true
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            self.button.backgroundColor = .white
            hideImage() // Ensure image is hidden on reuse
        }
    }
    
    // 섹션 헤더 뷰
    class SectionHeaderView: UICollectionReusableView {
        
        let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .black
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with title: String) {
            label.text = title
        }
    }
}

// #Preview section removed for compatibility
#Preview{
    AlarmViewController()
}
