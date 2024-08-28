import UIKit
import SafariServices

class SampleAlarmViewController: UIViewController {

    lazy var sampleAlarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "listalarm")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickAlarm)))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sampleAlarmImageView)
        sampleAlarmImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sampleAlarmImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sampleAlarmImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sampleAlarmImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sampleAlarmImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleSwipeDown() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clickAlarm(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://m.post.naver.com/viewer/postView.naver?volumeNo=37904830") {
            let vc = SFSafariViewController(url: url)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
