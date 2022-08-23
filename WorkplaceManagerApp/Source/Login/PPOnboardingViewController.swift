import UIKit

import SnapKit

public class PPOnboardingViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        let customView = SignUpView()
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
//        customView.loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNextScreen)))
    }
    
    @objc func onNextScreen() {
        showLoginView()
    }
    
    private func showLoginView() {
        let vc = PPLoginViewController()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

