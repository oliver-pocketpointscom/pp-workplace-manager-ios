import UIKit
import SnapKit

public class PPCompanyPointsSetupViewController: PPBaseTableViewController {
    
    private lazy var viewModel: CompanyPointsSetupViewModel = {
        PPCompanyPointsSetupViewModel()
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTitle("Company Pocket Points Setup")
        loadSettings()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
        
        let sendBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSave))
        self.navigationItem.rightBarButtonItem  = sendBarButton
    }
    
    private func loadSettings() {
        viewModel.getTenantSettings(tenantId: 59) {
            [weak self] (result, error) in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showFailedToRetrieveSettingsMessage() 
            } else {
                
            }
        }
    }
    
    @objc func onSave() {
        onSaveSuccessful()
    }
    
    @objc func onStartTimeSelected() {
        
    }
    
    @objc func onEndTimeSelected() {
        
    }
    
    private func onSaveSuccessful() {
        let alert = UIAlertController(title: "Hooray!", message: "Your employees can now start earning points.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
            [weak self ]action in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showFailedToRetrieveSettingsMessage() {
        let message = "Unable to retrieve your company settings. Please try again."
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PPCompanyPointsSetupViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = PointsSetupSections(rawValue: indexPath.section)
        
        switch section {
        case .timePerPoint:
            break
        case .duration:
            break
        case .dayOfTheWeek:
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
            }
        case .none: break
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        PointsSetupSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let section  = PointsSetupSections(rawValue: section)
        switch section {
            case .timePerPoint: return PointsEarningTime.allCases.count
            case .duration: return PointsDuration.allCases.count
            case .dayOfTheWeek: return PointsDayOfTheWeek.allCases.count
            case .none: return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.tintColor = .white
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        
        let section  = PointsSetupSections(rawValue: indexPath.section)
        switch section {
        case .timePerPoint:
            let label = UILabel()
            label.text = PointsEarningTime.minutes.name()
            label.backgroundColor = .clear
            label.textColor = .white
            cell.addSubview(label)

            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 60, height: cell.frame.height))
            textField.delegate = self
            textField.placeholder = "Time per point"
            textField.textAlignment = .right
            textField.textColor = .white
            textField.backgroundColor = .clear
            textField.attributedPlaceholder = NSAttributedString(
                string: textField.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            textField.addBottomBorder()
            cell.contentView.addSubview(textField)
            
            label.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(18)
                make.centerY.equalToSuperview()
            }
            
            textField.snp.makeConstraints { make in
                make.leading.equalTo(label.snp.trailing).offset(8)
                make.centerY.equalToSuperview()
                make.width.equalTo(120)
                make.trailing.equalToSuperview().offset(-16)
            }
            
            break
        case .duration:
            let row = PointsDuration(rawValue: indexPath.row)
            
            let label = UILabel()
            label.textColor = .white
            label.backgroundColor = .clear
            label.text = row?.name()
            cell.addSubview(label)
            
            let timePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: cell.contentView.frame.height))
            timePicker.datePickerMode = UIDatePicker.Mode.time
            timePicker.backgroundColor = .white
            timePicker.tintColor = .white
            cell.addSubview(timePicker)
                        
            label.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(18)
                make.centerY.equalToSuperview()
            }
            
            timePicker.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-16)
                make.centerY.equalToSuperview()
            }
            
            
            if row == .startTime {
                timePicker.addTarget(self, action: #selector(onStartTimeSelected), for: UIControl.Event.valueChanged)
            } else if row == .endTime {
                timePicker.addTarget(self, action: #selector(onEndTimeSelected), for: UIControl.Event.valueChanged)
            }
            break
        case .dayOfTheWeek:
            let row = PointsDayOfTheWeek(rawValue: indexPath.row)
            cell.textLabel?.text = row?.name()
            cell.backgroundColor = .clear
            let box = UIImageView(image: UIImage(named: "checkboxEmpty")?.withRenderingMode(.alwaysTemplate))
            box.tintColor = .white
            cell.addSubview(box)
            box.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.width.equalTo(24)
                make.trailing.equalToSuperview().offset(-20)
            }
            break
        case .none:
            break
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        PointsSetupSections(rawValue: section)?.name()
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .clear
            headerView.backgroundView?.backgroundColor = .clear
            headerView.textLabel?.textColor = .white
        }
    }
}

extension PPCompanyPointsSetupViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

public enum PointsSetupSections: Int, Hashable, CaseIterable {
    case timePerPoint
    case duration
    case dayOfTheWeek
    
    public func name() -> String {
        switch self {
        case .timePerPoint: return "Earning Times"
        case .duration: return "Duration"
        case .dayOfTheWeek: return "Day of the Week"
        }
    }
}

public enum PointsEarningTime: Int, Hashable, CaseIterable {
    case minutes
    
    public func name() -> String {
        switch self {
        case .minutes: return "Minutes"
        }
    }
}

public enum PointsDuration: Int, Hashable, CaseIterable {
    case startTime
    case endTime
    
    public func name() -> String {
        switch self {
        case .startTime: return "Start Time"
        case .endTime: return "End Time"
        }
    }
}

public enum PointsDayOfTheWeek: Int, Hashable, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    public func name() -> String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }
}
