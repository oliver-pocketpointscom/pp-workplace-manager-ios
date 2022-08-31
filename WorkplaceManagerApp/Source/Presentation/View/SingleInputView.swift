import UIKit

public class SingleInputView: UIView {
    
    lazy var inputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter value here"
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.addBottomBorder()
        return textField
    }()
    
    lazy var secondaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        return button
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
        addSubview(inputField)
        addSubview(secondaryButton)
        addSubview(primaryButton)
        
        inputField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        secondaryButton.snp.makeConstraints { make in
            make.bottom.equalTo(primaryButton.snp.top).offset(-32)
            make.centerX.equalToSuperview()
        }
        secondaryButton.addBottomBorder()
        
        primaryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        backgroundColor = .backgroundColor()
        
        secondaryButton.isHidden = true
    }
    
    public func showSecondaryButton() {
        secondaryButton.isHidden = false
    }
}
