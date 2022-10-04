import UIKit
import MapKit

public class PPSignupViewController: PPBaseTableViewController {
    
    lazy var pickerView: UIPickerView = {
        debugPrint("init UIPickerView...")
       return UIPickerView()
    }()
    
    private var businessSectors: [String] = []
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addNavBarTitle()
        
        loadBusinessSectors()
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
    }
    
    @objc func onSignUp() {
        showCreateGeofenceScreen()
    }
    
    private func showCreateGeofenceScreen() {
        let vc = PPCreateGeofenceViewController()
        push(vc: vc)
    }
    
    @objc func onUploadPhoto() {
        chooseImageSource()
    }
    
    private func onLaunchImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        present(controller, animated: true)
    }
    
    private func chooseImageSource() {
        let alert = UIAlertController(title: "Upload Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
                [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.onLaunchImagePicker(.camera)
            }))
        }
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            [weak self ]action in
            guard let strongSelf = self else { return }
            strongSelf.onLaunchImagePicker(.photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadBusinessSectors() {

        Wire.BusinessSector.findAllBusinessSectors { [weak self] error in
            let realm = DataProvider.newInMemoryRealm()
            let results = realm.findAllBusinessSectors()
            
            guard let strongSelf = self else { return }
            for r in results {
                strongSelf.businessSectors.append(r.name)
            }
            strongSelf.tableView.reloadData()
        }
    }
}

extension PPSignupViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        SignUpView.shared.companyPhotoImageView.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
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
        cell.backgroundColor = .black
        
        let row = SignUpRows(rawValue: indexPath.row)
        switch row {
        case .profilePhotoView:
            let view = SignUpView.shared.companyPhotoView
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            let uploadBtn = SignUpView.shared.uploadPhotoButton
            uploadBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onUploadPhoto)))
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
//            view.delegate = self
            view.optionArray = businessSectors
            cell.contentView.subviews.forEach { view in
                view.removeFromSuperview()
            }
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
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Sign Up"
    }
    
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Step 1 of 4"
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .clear
            headerView.backgroundView?.backgroundColor = .clear
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.textAlignment = .center
            headerView.textLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        }
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .clear
            headerView.backgroundView?.backgroundColor = .clear
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.textAlignment = .center
            headerView.textLabel?.font = .systemFont(ofSize: 14)
        }
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
