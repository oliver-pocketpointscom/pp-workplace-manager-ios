import UIKit

import SnapKit

public class PPVerifyOTPViewController: PPBaseViewController {
    
    let customView = SingleInputView()
    public var mobileNumber: String?
    
    public lazy var viewModel: LoginViewModel = {
        PPLoginViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addNavBarTitle()
    }
    
    private func initView() {
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        customView.inputField.placeholder = "Enter verification code"
        customView.inputField.delegate = self
        customView.inputField.keyboardType = .numberPad
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
        //showDebugOptions()
        guard let mobile = self.mobileNumber else { return }
        guard let code = customView.inputField.text, !code.isEmpty else {
            showIncompleteDetailsError()
            return
        }
        
        viewModel.verifyCode(mobileNumber: mobile, code: code, completion: { [weak self] error in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showBackendError()
            } else {
                strongSelf.showHome()
            }
        })
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
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showLoginRestrictionScreen() {
        let vc = PPLoginRestrictionViewController(style: .grouped)
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func showHome() {
        let home = PPTabBarController()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension PPVerifyOTPViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

extension PPVerifyOTPViewController {
    
    private func showIncompleteDetailsError() {
        let alert = UIAlertController(title: "Error", message: "\nMobile number is required\n", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showBackendError() {
        viewModel.deleteUserObject()
        let alert = UIAlertController(title: "Error", message: "\nInvalid confirmation code", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
}
