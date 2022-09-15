import UIKit

public class PPRewardsViewController: PPBaseViewController {
    
    lazy var customView: ComposeRewardNotificationView = {
        debugPrint("init ComposeRewardNotificationView...")
        let customView = ComposeRewardNotificationView()
        return customView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
        clearFields()
    }
    
    private func initView() {        
        view.backgroundColor = .black
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSend)))
    }
    
    private func clearFields() {
        customView.titleField.text = ""
        customView.messageField.text = ""
    }
    
    @objc func onSend() {
        let vc = PPSelectContactsForRewardsViewController()
        vc.clearNavBarTitle()
        push(vc: vc)
    }
}
