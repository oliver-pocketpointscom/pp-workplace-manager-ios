import UIKit

import SnapKit

public class PPLoginViewController: PPBaseViewController {
    
    let customView = LoginView()
    
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
        customView.mobileNumberField.placeholder = "Enter mobile phone number"
        customView.mobileNumberField.text = "325445"
        customView.mobileNumberField.keyboardType = .numberPad
        customView.mobileNumberField.delegate = self
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPrimaryButton)))
    }
    
    @objc func onTapPrimaryButton() {
        login()
    }
    
    private func login() {
        guard let mobileNumber = customView.mobileNumberField.text, !mobileNumber.isEmpty else {
            showIncompleteDetailsError()
            return
        }
        
        viewModel.login(mobileNumber: mobileNumber, completion: { [weak self] error in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showBackendError()
            } else {
                strongSelf.showOTPVerificationScreen(mobileNumber: mobileNumber)
            }
        })
        
    }
    
    private func showOTPVerificationScreen(mobileNumber: String) {
        let vc = PPVerifyOTPViewController()
        vc.mobileNumber = mobileNumber
        push(vc: vc)
    }
}

extension PPLoginViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

extension PPLoginViewController {
    
    private func showIncompleteDetailsError() {
        let alert = UIAlertController(title: "Error", message: "\nMobile number is required\n", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showBackendError() {
        let alert = UIAlertController(title: "Error", message: "\nPlease make sure the mobile number is correct", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
}
