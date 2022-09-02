import UIKit

import SnapKit

public class PPLoginViewController: PPBaseViewController {
    
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
        customView.inputField.placeholder = "Enter mobile phone number"
        customView.inputField.keyboardType = .numberPad
        customView.inputField.delegate = self
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPrimaryButton)))
    }
    
    @objc func onTapPrimaryButton() {
        requestForOTP()
    }
    
    private func requestForOTP() {
        showOTPVerificationScreen()
    }
    
    private func showOTPVerificationScreen() {
        let vc = PPVerifyOTPViewController()
        push(vc: vc)
    }
}

extension PPLoginViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}