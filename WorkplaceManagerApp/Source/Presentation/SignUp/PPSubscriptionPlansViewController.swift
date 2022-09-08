import UIKit

public class PPSubscriptionPlansViewController: PPBaseTableViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTitle("Subscription")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .white
        tableView.separatorColor = .white
        tableView.allowsMultipleSelection = false
    }
    
    private func navigateHome() {
        let home = PPTabBarController()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func onSubscribe(_ sender: UIButton?) {
        if let tag = sender?.tag {
            
            if let row = SubscriptionPlans(rawValue: tag) {
                var message = "\(row.category()): \(row.price())"
                if tag > 0 {
                    message = message.appending("/month")
                }
                confirmSubscription(message: message)
            }
        }
    }
    
    private func confirmSubscription(message: String) {
        let alert = UIAlertController(title: "Confirm Subscription", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {
            [weak self ]action in
            guard let strongSelf = self else { return }
            strongSelf.proceedToNextScreen()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func proceedToNextScreen() {
        navigateHome()
    }
}

extension PPSubscriptionPlansViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SubscriptionPlans.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .backgroundColor()
        
        let contentView = SubscriptionPlanView()
        
        let row = SubscriptionPlans(rawValue: indexPath.row)
        contentView.planCategoryContainer.backgroundColor = row?.backgroundColor()
        contentView.planCategoryLabel.text = row?.category()
        contentView.planPriceLabel.text = row?.price()
        contentView.licenseCountLabel.text = row?.licenseCount()
        if indexPath.row > 0 {
            contentView.occurrenceLabel.text = "/month"
        }
        
        cell.contentView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.height.width.equalToSuperview().offset(-20)
            make.centerY.centerX.equalToSuperview()
        }
        
        contentView.subscribeButton.tag = indexPath.row
        contentView.subscribeButton.addTarget(self, action: #selector(onSubscribe(_ :)), for: .touchUpInside)
        
        return cell
    }
}

public enum SubscriptionPlans: Int, Hashable, CaseIterable {
    case free
    case basic
    case premium
    case elite
    case platinum
    
    public func category() -> String {
        switch self {
        case .free: return "Free Trial"
        case .basic: return "Basic"
        case .premium: return "Premium"
        case .elite: return "Elite"
        case .platinum: return "Platinum"
        }
    }
    
    public func price() -> String {
        switch self {
        case .free: return "$0"
        case .basic: return "$15"
        case .premium: return "$25"
        case .elite: return "$50"
        case .platinum: return "$100"
        }
    }
    
    public func licenseCount() -> String {
        switch self {
        case .free: return "Up to 25 licenses for 30-days"
        case .basic: return "Up to 50 licenses"
        case .premium: return "Up to 100 licenses"
        case .elite: return "Up to 200 licenses"
        case .platinum: return "Up to 400 licenses"
        }
    }
    
    public func backgroundColor() -> UIColor {
        switch self {
        case .free:
            return .blue
        case .basic:
            return .pocketpointsGreen()
        case .premium:
            return .purple
        case .elite:
            return .black
        case .platinum:
            return .darkGray
        }
    }
}

public class SubscriptionPlanView: UIView {
    
    public lazy var planCategoryContainer: UIView = {
        let view = UIView()
        view.addSubview(planCategoryLabel)
        planCategoryLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.bottom.trailing.equalToSuperview().offset(-4)
        }
        return view
    }()
    
    public lazy var planCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Trial"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    public lazy var planPriceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    public lazy var occurrenceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    public lazy var licenseCountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    public lazy var subscribeButton: UIButton = {
        .roundedButton(withTitle: "Subscribe")
    }()
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        addSubview(planCategoryContainer)
        addSubview(planPriceLabel)
        addSubview(occurrenceLabel)
        addSubview(licenseCountLabel)
        addSubview(subscribeButton)
        
        planCategoryContainer.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        licenseCountLabel.snp.makeConstraints { make in
            make.top.equalTo(planCategoryContainer.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        planPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(licenseCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        occurrenceLabel.snp.makeConstraints { make in
            make.top.equalTo(licenseCountLabel.snp.bottom).offset(8)
            make.leading.equalTo(planPriceLabel.snp.trailing).offset(4)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        subscribeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
