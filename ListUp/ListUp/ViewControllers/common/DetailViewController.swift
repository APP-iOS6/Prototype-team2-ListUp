import UIKit
import SafariServices

class DetailViewController: BaseViewController {
    
    
    var selectedImage: UIImage?  // 선택된 이미지를 저장할 변수
    var selectedURL: URL?  // 선택된 URL을 저장할 변수
    
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "detailpage")
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupInterface()
        setupLayOut()
    }
    
    // BaseViewController의 setupInterface() 오버라이드
    override func setupInterface() {
        super.setupInterface()
        
        stackView.addArrangedSubview(imageView)

    }
    
    // BaseViewController의 setupLayOut() 오버라이드
    override func setupLayOut() {
        super.setupLayOut()
        NSLayoutConstraint.activate([
            
            
            imageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            

        ])
    }

}

#Preview{
    DetailViewController()
}
