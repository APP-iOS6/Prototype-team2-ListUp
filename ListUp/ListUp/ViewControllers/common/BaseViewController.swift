import UIKit

class BaseViewController: UIViewController {

    public lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var searchView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .group47
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlarm)))
        return imageView
    }()
    
    lazy var tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOpacity = 0.25
        return stackView
    }()
    
    lazy var saleTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top1"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var promotionTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top2"), for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var snsTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top3"), for: .normal)
        button.tag = 3
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var categoryTabButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "top4"), for: .normal)
        button.tag = 4
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        button.addAction(UIAction { _ in
            print("category")
            let vc = FilterSheetViewController()
            vc.modalPresentationStyle = .pageSheet
            vc.sheetPresentationController?.detents = [.medium()]
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupInterface()
        setupLayOut()
    }
    
    public func setupInterface() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(searchView)
        stackView.addArrangedSubview(tabStackView)
        tabStackView.addArrangedSubview(saleTabButton)
        tabStackView.addArrangedSubview(promotionTabButton)
        tabStackView.addArrangedSubview(snsTabButton)
        tabStackView.addArrangedSubview(categoryTabButton)
    }
    public func setupLayOut() {
        let safeArea = view.safeAreaLayoutGuide
        stackView.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        tabStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // stackView Constraints
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            // searchView Constraints
            searchView.heightAnchor.constraint(equalToConstant: 50), // Fixed height for search view
            
            // tabStackView Constraints
            tabStackView.heightAnchor.constraint(equalToConstant: 60), // Fixed height for tab buttons
        ])
    }
    
    @objc func showAlarm(_ sender: UITapGestureRecognizer) {
        print("show alarm")
        let vc = SampleAlarmViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
    @objc func tabButtonTapped(_ sender: UIButton) {
        let originalImageName: String
        let selectedImageName: String
        
        switch sender.tag {
        case 1:
            originalImageName = "top1"
            selectedImageName = "topclick1"
            (self as? SubViewController)?.updateTab(to: .sale)
            tabBarController?.selectedIndex = 1
        case 2:
            originalImageName = "top2"
            selectedImageName = "topclick2"
            (self as? SubViewController)?.updateTab(to: .promotion)
            tabBarController?.selectedIndex = 1
        case 3:
            originalImageName = "top3"
            selectedImageName = "topclick3"
            (self as? SubViewController)?.updateTab(to: .sns)
            tabBarController?.selectedIndex = 1
        case 4:
            originalImageName = "top4"
            selectedImageName = "topclick4"
            tabBarController?.selectedIndex = 1
        default:
            return
        }
        
        if sender.image(for: .normal) == UIImage(named: selectedImageName) {
            sender.setImage(UIImage(named: originalImageName), for: .normal)
        } else {
            resetAllTabButtons()
            sender.setImage(UIImage(named: selectedImageName), for: .normal)
        }
    }
    
    private func resetAllTabButtons() {
        saleTabButton.setImage(UIImage(named: "top1"), for: .normal)
        promotionTabButton.setImage(UIImage(named: "top2"), for: .normal)
        snsTabButton.setImage(UIImage(named: "top3"), for: .normal)
        categoryTabButton.setImage(UIImage(named: "top4"), for: .normal)
    }
}

