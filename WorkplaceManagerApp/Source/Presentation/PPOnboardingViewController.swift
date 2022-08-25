import UIKit

import SnapKit

public class PPOnboardingViewController: PPBaseViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        let customView = OnboardingView()
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        customView.loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNextScreen)))
    }
    
    @objc func onNextScreen() {
        showLoginView()
    }
    
    private func showLoginView() {
        let vc = PPSignupViewController()
        push(vc: vc)
    }
}

