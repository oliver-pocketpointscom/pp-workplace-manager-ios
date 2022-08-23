import UIKit

public class OnboardingView: UIView {
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rewarding Healthy Mobile Behavior in the Workplace"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var subheadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Earn extra credit, deals on food, clothes, entertainment, and more for time off your phone."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
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
        addSubview(headingLabel)
        addSubview(subheadingLabel)
        addSubview(loginButton)
        
        headingLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        subheadingLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        backgroundColor = .darkGray
    }
}
