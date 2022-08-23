import UIKit

public class PPSignupViewController: PPBaseViewController {
    
    lazy var customView: SignUpView =  {
        debugPrint("init SignUpView...")
        return SignUpView()
    }()
    
    lazy var pickerView: UIPickerView = {
        debugPrint("init UIPickerView...")
       return UIPickerView()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        customView.primaryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSignUp)))
        customView.dropDownBoxView.optionArray = ["Manufacturing", "Transport", "Goods", "Mining", "Education"]
    }
    
    @objc func onSignUp() {
        showCreateGeofenceScreen()
    }
    
    private func showCreateGeofenceScreen() {
        let vc = PPCreateGeofenceViewController()
        push(vc: vc)
    }
}
