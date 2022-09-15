import UIKit

public class ChooseNumberOfLicenseView: UIView {
    
    lazy var primaryButton: UIButton = {
        .roundedButton(withTitle: "Proceed")
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "4 of 4"
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
    
    lazy var numberOfLicenseField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Number of Licenses"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.textAlignment = .right
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        textField.delegate = self
        return textField
    }()
    
    lazy var paymentDetailsView: UIView = {
       let view = UIView()
        
        view.addSubview(paymentDetailsLegend)
        view.addSubview(creditCardField)
        view.addSubview(expiryMonthField)
        view.addSubview(expiryYearField)
        view.addSubview(securityCodeField)
        
        paymentDetailsLegend.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        creditCardField.snp.makeConstraints { make in
            make.top.equalTo(paymentDetailsLegend.snp.bottom).offset(16)
            make.leading.equalToSuperview()
        }
        
        expiryMonthField.snp.makeConstraints { make in
            make.top.equalTo(creditCardField.snp.bottom).offset(16)
            make.leading.equalToSuperview()
        }
        
        expiryYearField.snp.makeConstraints { make in
            make.top.equalTo(expiryMonthField.snp.bottom).offset(16)
            make.leading.equalToSuperview()
        }
        
        securityCodeField.snp.makeConstraints { make in
            make.top.equalTo(expiryYearField.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var paymentDetailsLegend: UILabel = {
        let label = UILabel()
        label.text = "Payment Details"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
    }()
    
    lazy var creditCardField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Credit Card Number"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        textField.delegate = self
        return textField
    }()
    
    lazy var expiryMonthField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Expiry Month"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        textField.delegate = self
        return textField
    }()
    
    lazy var expiryYearField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Expiry Year"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        textField.delegate = self
        return textField
    }()
    
    lazy var securityCodeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Security Code"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        textField.delegate = self
        return textField
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
        addSubview(numberOfLicenseField)
        addSubview(paymentDetailsView)
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
        
        numberOfLicenseField.snp.makeConstraints { make in
            make.top.equalTo(subscriptionTypeLegend.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        paymentDetailsView.snp.makeConstraints { make in
            make.top.equalTo(numberOfLicenseField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
        
        paymentDetailsView.isHidden = true
    }
}

extension ChooseNumberOfLicenseView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
            return string.isInt
        }
        return false
    }
}
