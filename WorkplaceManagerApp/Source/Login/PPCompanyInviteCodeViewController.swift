import UIKit

import SnapKit

public class PPCompanyInviteCodeViewController: PPBaseViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        let customView = SingleInputView()
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        customView.inputField.placeholder = "Enter Company Invite Code"
    }
}
