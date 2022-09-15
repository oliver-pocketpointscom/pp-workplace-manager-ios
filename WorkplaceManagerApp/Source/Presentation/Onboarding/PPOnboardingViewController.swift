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
        
        customView.termsConditionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewTermsOfService)))
        
        customView.privacyPolicyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewPrivacyPolicy)))
    }
    
    @objc func onLoginScreen() {
        showLoginView()
    }
    
    @objc func onSignUpScreen() {
        showSignUpView()
    }
    
    @objc func onViewTermsOfService() {
        if let url = URL(string: "https://pocketpoints.com/terms") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func onViewPrivacyPolicy() {
        if let url = URL(string: "https://pocketpoints.com/privacy") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
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

