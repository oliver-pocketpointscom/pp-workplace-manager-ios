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
        // If user doesn't exist yet
        showCompanyInviteCodeView()
        // Else, proceed to home
    }
    
    private func showCompanyInviteCodeView() {
        let vc = PPCompanyInviteCodeViewController()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
