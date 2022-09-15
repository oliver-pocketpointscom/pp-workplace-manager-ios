import UIKit

public class ChoosePlanView: UIView {
    
    public let radioButton = RadioButton()
    
    lazy var primaryButton: UIButton = {
        .roundedButton(withTitle: "Proceed")
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "3 of 4"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
    }()
    
    lazy var subscriptionLegend: UILabel = {
        let label = UILabel()
        label.text = "Subscription"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
    }()
    
    lazy var subscriptionTypeLegend: UILabel = {
        let label = UILabel()
        label.text = "Subscription Type"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
    }()
    
    
    lazy var freeTrialButton: PPButton = {
        let button = PPButton(type: .system)
        button.setTitle("Pocket Points Free Trial", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(onFreeTrialTapped), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    lazy var basicPlanButton: PPButton = {
        let button = PPButton(type: .system)
        button.setTitle("Pocket Points Basic Plan", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(onBasicPlanTapped), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    lazy var premiumPlanButton: PPButton = {
        let button = PPButton(type: .system)
        button.setTitle("Pocket Points Premium Plan", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(onPremiumPlanTapped), for: .touchUpInside)
        button.tag = 3
        return button
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
        addSubview(subscriptionLegend)
        addSubview(subscriptionTypeLegend)
        addSubview(freeTrialButton)
        addSubview(basicPlanButton)
        addSubview(premiumPlanButton)
        addSubview(primaryButton)
        addSubview(progressLabel)
        
        subscriptionLegend.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        subscriptionTypeLegend.snp.makeConstraints { make in
            make.top.equalTo(subscriptionLegend.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(16)
        }
        
        radioButton.buttons = [freeTrialButton, basicPlanButton, premiumPlanButton]
        radioButton.defaultButton = freeTrialButton
                
        freeTrialButton.snp.makeConstraints { make in
            make.top.equalTo(subscriptionTypeLegend.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(55)
        }
        
        basicPlanButton.snp.makeConstraints { make in
            make.top.equalTo(freeTrialButton.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(55)
        }
        
        premiumPlanButton.snp.makeConstraints { make in
            make.top.equalTo(basicPlanButton.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(55)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
            make.bottom.equalTo(progressLabel.snp.top).offset(-16)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-48)
        }
    }
    
    @objc func onFreeTrialTapped() {
        radioButton.buttonArrayUpdated(buttonSelected: freeTrialButton)
    }
    
    @objc func onBasicPlanTapped() {
        radioButton.buttonArrayUpdated(buttonSelected: basicPlanButton)
    }
    
    @objc func onPremiumPlanTapped() {
        radioButton.buttonArrayUpdated(buttonSelected: premiumPlanButton)
    }
}
