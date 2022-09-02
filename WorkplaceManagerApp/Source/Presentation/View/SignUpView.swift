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
        field.isEnabled = false
        field.text = "(415) 555 5643"
        field.backgroundColor = .lightGray
        return field
    }()
    
    lazy var companyPhotoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "starbucks"))        
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var businessSectorList: DropDown = {
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
        .roundedButton(withTitle: "Sign up")
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
