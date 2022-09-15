import UIKit
import iOSDropDown

public class SignUpView {
    
    private init() {}
    
    public static let `shared` = SignUpView()
    
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
        return field
    }()
    
    lazy var companyPhotoView: UIView = {
        let contentView = UIView()
        contentView.addSubview(companyPhotoImageView)
        contentView.addSubview(uploadPhotoButton)
        
        companyPhotoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        uploadPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(companyPhotoImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return contentView
    }()
    
    lazy var companyPhotoImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.backgroundColor = .backgroundColor()
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var uploadPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Upload Company Logo", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    lazy var businessSectorList: DropDown = {
        let textField = DropDown()
        textField.placeholder = "Business Sector"
        textField.backgroundColor = .white
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
        .roundedButton(withTitle: "Proceed")
    }()
    
    private func createTextField(placeholder: String) -> UITextField{
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = .white
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
