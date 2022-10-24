import UIKit
import SnapKit

public class PPCompanyPointsSetupViewController: PPBaseTableViewController {
    
    private lazy var viewModel: CompanyPointsSetupViewModel = {
        PPCompanyPointsSetupViewModel()
    }()
    
    private var settingsModel: TenantSettingsModel?
    
    private var startEarnPoints: String?
    private var endEarnPoints: String?
    private var selectedDaysOfTheWeek: [String] = []
    
    private lazy var timePerPointLegend: UILabel = {
        let label = UILabel()
        label.text = PointsEarningTime.minutes.name()
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
    private lazy var timePerPointInputField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
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
        return textField
    }()
    
    private lazy var durationLegend: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        timePicker.datePickerMode = UIDatePicker.Mode.time
        timePicker.backgroundColor = .white
        timePicker.tintColor = .white
        return timePicker
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
                strongSelf.showFailedMessage(.load)
            } else {
                strongSelf.settingsModel = result
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    @objc func onSave() {
        if let settings = settingsModel {
            updateSettings(payload: settings)
        } else {
            if let startEarnPoints = self.startEarnPoints,
               let endEarnPoints = self.endEarnPoints,
               let timePerPointInput = self.timePerPointInputField.text,
               let timePerPoint = Int(timePerPointInput) {
                
                let payload = TenantSettingsModel(daysOfTheWeek: selectedDaysOfTheWeek,
                                                  startEarnPoints: startEarnPoints,
                                                  endEarnPoints: endEarnPoints,
                                                  timePerPoint: timePerPoint)
                createSettings(payload: payload)
            }
        }
    }
    
    private func createSettings(payload: TenantSettingsModel) {
        viewModel.createTenantSettings(payload: payload) {
            [weak self] error in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showFailedMessage(.create)
            } else {
                strongSelf.onSaveSuccessful()
            }
        }
    }
    
    private func updateSettings(payload: TenantSettingsModel) {
        viewModel.updateTenantSettings(payload: payload) {
            [weak self] error in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showFailedMessage(.update)
            } else {
                strongSelf.onSaveSuccessful()
            }
        }
    }
    
    @objc func onStartTimeSelected(datePicker: UIDatePicker) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        startEarnPoints = df.string(from: datePicker.date)
    }
    
    @objc func onEndTimeSelected(datePicker: UIDatePicker) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        endEarnPoints = df.string(from: datePicker.date)
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
    
    private func showFailedMessage(_ action: CompanySettingsAction) {
        var message = ""
        switch action {
        case .create:
            message = "Unable to create your company settings. Please try again."
            break
        case .update:
            message = "Unable to update your company settings. Please try again."
            break
        case .load:
            message = "Unable to retrieve your company settings. Please try again."
            break
        }
        
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
            if let row = PointsDayOfTheWeek(rawValue: indexPath.row) {
                selectedDaysOfTheWeek = selectedDaysOfTheWeek.filter { $0 != row.name() }
                selectedDaysOfTheWeek.append(row.name())
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
            return getTimePerPointRowCell(cell)
        case .duration:
            return getDurationRowCell(cell, indexPath: indexPath)
        case .dayOfTheWeek:
            return getDaysOfTheWeekRowCell(cell, indexPath: indexPath)
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

extension PPCompanyPointsSetupViewController {
    
    public func getTimePerPointRowCell(_ cell: UITableViewCell) -> UITableViewCell {
        cell.addSubview(timePerPointLegend)
        cell.contentView.addSubview(timePerPointInputField)
        timePerPointLegend.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        
        timePerPointInputField.snp.makeConstraints { make in
            make.leading.equalTo(timePerPointLegend.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        if let model = settingsModel {
            timePerPointInputField.text = "\(model.timePerPoint)"
        }
        return cell
    }
    
    public func getDurationRowCell(_ cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        let row = PointsDuration(rawValue: indexPath.row)
        cell.addSubview(durationLegend)
        durationLegend.text = row?.name()
        
        cell.addSubview(timePicker)
                    
        durationLegend.snp.makeConstraints { make in
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
        
        if let model = settingsModel {
            let df = DateFormatter()
            df.dateFormat = "HH:mm:ss"
            var date = Date()
            if row == .startTime, let dateFromConfig = df.date(from: model.startEarnPoints) {
                date = dateFromConfig
            } else if row == .endTime, let dateFromConfig = df.date(from: model.endEarnPoints) {
                date = dateFromConfig
            }
            timePicker.setDate(date, animated: true)
        }
        return cell
    }
    
    public func getDaysOfTheWeekRowCell(_ cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        if let row = PointsDayOfTheWeek(rawValue: indexPath.row) {
            cell.textLabel?.text = row.name()
            cell.backgroundColor = .clear
            let box = UIImageView(image: UIImage(named: "checkboxEmpty")?.withRenderingMode(.alwaysTemplate))
            box.tintColor = .white
            cell.addSubview(box)
            box.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.width.equalTo(24)
                make.trailing.equalToSuperview().offset(-20)
            }
            if let model = settingsModel {
                let daysOfTheWeek = model.daysOfTheWeek
                if daysOfTheWeek.contains(row.name()) {
                    cell.accessoryType = .checkmark
                }
            }
        }
        return cell
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

public enum CompanySettingsAction: Int, Hashable, CaseIterable {
    case create
    case update
    case load
}
