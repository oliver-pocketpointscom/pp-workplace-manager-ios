import UIKit
import iOSDropDown

public class SignUpView: UIView {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    lazy var companyNameField: UITextField = {
        return createTextField(placeholder: "Company Name")
    }()
    
    lazy var firstNameField: UITextField = {
        return createTextField(placeholder: "First Name")
    }()
    
    lazy var lastNameField: UITextField = {
        return createTextField(placeholder: "Last Name")
    }()
    
    lazy var emailField: UITextField = {
        let field = createTextField(placeholder: "Company Email Address")
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var mobileNumberField: UITextField = {
        let field = createTextField(placeholder: "Mobile Phone Number")
        field.keyboardType = .phonePad
        return field
    }()
    
    lazy var companyPhotoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "starbucks"))        
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var dropDownBoxView: DropDown = {
        let textField = DropDown()
        textField.placeholder = "Business Sector"
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        textField.arrowColor = UIColor.lightGray
        return textField
    }()
    
    lazy var primaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .pocketpointsGreen()
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = button.frame.size
        gradient.colors = [UIColor.white.cgColor,UIColor.white.withAlphaComponent(1).cgColor]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradient.locations = [0.0 , 1.0]
        button.layer.insertSublayer(gradient, at:0)

        return button
    }()
    
    private func createTextField(placeholder: String) -> UITextField{
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        return textField
    }
    
    private func setupView() {
        addSubview(companyNameField)
        addSubview(companyPhotoView)
        addSubview(dropDownBoxView)
        addSubview(firstNameField)
        addSubview(lastNameField)
        addSubview(emailField)
        addSubview(mobileNumberField)
        addSubview(primaryButton)
        
        companyPhotoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        companyNameField.snp.makeConstraints { make in
            make.top.equalTo(companyPhotoView.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        dropDownBoxView.snp.makeConstraints { make in
            make.top.equalTo(companyNameField.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        firstNameField.snp.makeConstraints { make in
            make.top.equalTo(dropDownBoxView.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        lastNameField.snp.makeConstraints { make in
            make.top.equalTo(firstNameField.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(lastNameField.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        mobileNumberField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        
        backgroundColor = .backgroundColor()
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
