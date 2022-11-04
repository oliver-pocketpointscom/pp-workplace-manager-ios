import UIKit

public class LoginView: UIView {
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var mobileNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile Phone"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var mobileNumberField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Mobile Number"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.addBottomBorder()
        return textField
    }()
    
    lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var emailAddressField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email Address"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.addBottomBorder()
        return textField
    }()
    
    lazy var smsDisclaimerLabel: UILabel = {
        let label = UILabel()
        label.text = "We'll send you an SMS verification code"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var smsDisclaimer2Label: UILabel = {
        let label = UILabel()
        label.text = "Message and Data Rates may apply"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var primaryButton: UIButton = {
        .roundedButton(withTitle: "Continue")
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
        addSubview(loginLabel)
        addSubview(mobileNumberLabel)
        addSubview(mobileNumberField)
        addSubview(emailAddressLabel)
        addSubview(emailAddressField)
        addSubview(smsDisclaimerLabel)
        addSubview(smsDisclaimer2Label)
        addSubview(primaryButton)
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        emailAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(64)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        emailAddressField.snp.makeConstraints { make in
            make.top.equalTo(emailAddressLabel.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        mobileNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(emailAddressField.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        mobileNumberField.snp.makeConstraints { make in
            make.top.equalTo(mobileNumberLabel.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        smsDisclaimerLabel.snp.makeConstraints { make in
            make.top.equalTo(mobileNumberField.snp.bottom).offset(64)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        smsDisclaimer2Label.snp.makeConstraints { make in
            make.top.equalTo(smsDisclaimerLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.top.equalTo(smsDisclaimer2Label.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        backgroundColor = .black
    }
}
