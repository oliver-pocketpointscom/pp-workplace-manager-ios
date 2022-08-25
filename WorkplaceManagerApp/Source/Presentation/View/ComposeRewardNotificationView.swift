import UIKit
import SnapKit

public class ComposeRewardNotificationView: UIView {
    
    lazy var primaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 144/255, green: 213/255, blue: 199/255, alpha: 1.0)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = button.frame.size
        gradient.colors = [UIColor.white.cgColor,UIColor.white.withAlphaComponent(1).cgColor]
        button.layer.insertSublayer(gradient, at:0)

        return button
    }()
    
    lazy var titleField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Reward Title"
        textField.font = .systemFont(ofSize: 14)
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        return textField
    }()
    
    lazy var messageField: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    private let DEFAULT_MESSAGE_PLACEHOLDER_MESSAGE = "Describe your reward"
    
    lazy var messagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = DEFAULT_MESSAGE_PLACEHOLDER_MESSAGE
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
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
        
        let headingLabel = UILabel()
        headingLabel.text = "We know that you care for your employees. \n\nSend them a reward now."
        headingLabel.font = .systemFont(ofSize: 22, weight: .bold)
        headingLabel.numberOfLines = 0
        headingLabel.lineBreakMode = .byWordWrapping
        headingLabel.textAlignment = .center
           
        let containerView = UIView()
        containerView.addSubview(headingLabel)
        containerView.addSubview(titleField)
        containerView.addSubview(messagePlaceholderLabel)
        containerView.addSubview(primaryButton)
        
        
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        titleField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(35)
        }
        
        let messageFieldContainer = UIView()
        messageFieldContainer.layer.cornerRadius = 10
        messageFieldContainer.layer.borderColor = UIColor.lightGray.cgColor
        messageFieldContainer.layer.borderWidth = 1
        messageFieldContainer.addSubview(messageField)
        containerView.addSubview(messageFieldContainer)
        messageField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
        
        messageFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(200)
        }
        
        messagePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(messageFieldContainer.snp.top).offset(18)
            make.leading.equalTo(messageFieldContainer.snp.leading).offset(14)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.top.equalTo(messageFieldContainer.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(450)
            make.width.equalTo(300)
        }
        
        backgroundColor = .backgroundColor()
    }
}

extension ComposeRewardNotificationView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = textField.text?.appending(string) ?? ""
        let numberOfChars = newText.count
        return numberOfChars <= 25
    }
}

extension ComposeRewardNotificationView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            return false
        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= 100
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            messagePlaceholderLabel.text = ""
        } else {
            messagePlaceholderLabel.text = DEFAULT_MESSAGE_PLACEHOLDER_MESSAGE
        }
    }
}
