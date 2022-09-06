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
        customView.loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLoginScreen)))
        customView.signUpButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSignUpScreen)))
    }
    
    @objc func onLoginScreen() {
        showLoginView()
    }
    
    @objc func onSignUpScreen() {
        showSignUpView()
    }
    
    private func showLoginView() {
        let vc = PPLoginViewController()
        push(vc: vc)
    }
    
    private func showSignUpView() {
        let vc = PPSignupViewController(style: .grouped)
        push(vc: vc)
    }
}

