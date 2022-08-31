import UIKit

import SnapKit

public class PPVerifyOTPViewController: PPBaseViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        let customView = SingleInputView()
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        customView.inputField.placeholder = "Enter verification code"
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPrimaryButton)))
        customView.showSecondaryButton()
        customView.secondaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapSecondaryButton)))
        customView.secondaryButton.setTitle("Resend Confirmation Code", for: .normal)
    }
    
    @objc func onTapPrimaryButton() {
        verifyOTP()
    }
                                                        
    @objc func onTapSecondaryButton() {
        
    }
    
    private func verifyOTP() {
        showDebugOptions()
    }
    
    private func showDebugOptions() {
        let alert = UIAlertController(title: "Debug Options",
                                      message: "Select your journey",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Home Screen", style: UIAlertAction.Style.default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showHome()
        })
        alert.addAction(UIAlertAction(title: "Login Restriction Screen", style: UIAlertAction.Style.default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showLoginRestrictionScreen()
        })
        alert.addAction(UIAlertAction(title: "Sign Up Screen", style: UIAlertAction.Style.default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showSignUpScreen()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showSignUpScreen() {
        let vc = PPSignupViewController()
        push(vc: vc)
    }
    
    private func showLoginRestrictionScreen() {
        let vc = PPLoginRestrictionViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func showHome() {
        let home = PPTabBarController()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
