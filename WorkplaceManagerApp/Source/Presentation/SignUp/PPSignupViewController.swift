import UIKit
import MapKit

public class PPSignupViewController: PPBaseTableViewController {
    
    lazy var pickerView: UIPickerView = {
        debugPrint("init UIPickerView...")
       return UIPickerView()
    }()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
    }
    
    @objc func onSignUp() {
        showCreateGeofenceScreen()
    }
    
    private func showCreateGeofenceScreen() {
        let vc = PPCreateGeofenceViewController()
        push(vc: vc)
    }
}

extension PPSignupViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SignUpRows.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let row = SignUpRows(rawValue: indexPath.row)
        switch row {
        case .profilePhotoView:
            let view = SignUpView.shared.companyPhotoView
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.height.width.equalTo(100)
            }
            break
        case .companyNameField:
            let view = SignUpView.shared.companyNameField
            view.delegate = self
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .businessSectorField:
            let view = SignUpView.shared.businessSectorList
            view.delegate = self
            view.optionArray = ["Manufacturing", "Transport", "Goods", "Mining", "Education"]
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .firstNameField:
            let view = SignUpView.shared.firstNameField
            view.delegate = self
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .lastNameField:
            let view = SignUpView.shared.lastNameField
            view.delegate = self
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .emailField:
            let view = SignUpView.shared.emailField
            view.delegate = self
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .mobileNumberField:
            let view = SignUpView.shared.mobileNumberField
            view.delegate = self
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .signUpButton:
            let view = SignUpView.shared.primaryButton
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSignUp)))
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(35)
            }
            break
        case .none: break
        }
        return cell
    }
}

extension PPSignupViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

public enum SignUpRows: Int, Hashable, CaseIterable {
    case profilePhotoView
    case companyNameField
    case businessSectorField
    case firstNameField
    case lastNameField
    case emailField
    case mobileNumberField
    case signUpButton
}
