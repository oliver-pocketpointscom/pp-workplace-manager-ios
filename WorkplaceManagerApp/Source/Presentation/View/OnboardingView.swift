import UIKit

public class OnboardingView: UIView {
    
    lazy var ppBannerView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo-white"))
        return imageView
    }()
    
    lazy var companyPhotoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_trophy_white"))
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.tintColor = .primary()
        return imageView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0.5
        return imageView
    }()

    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rewarding Healthy Mobile Behavior in the Workplace"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
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
        label.textColor = .black
        return label
    }()
    
    lazy var loginButton: UIButton = {
        return .roundedButton(withTitle: "Login")
    }()
    
    lazy var signUpButton: UIButton = {
        return .roundedButton(withTitle: "Sign Up")
    }()
    
    private lazy var separatorLabel: UIView = {
        let contentView = UIView()
        
        let label = UILabel()
        label.text = "or"
        label.textColor = .white
        label.textAlignment = .center
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(25)
        }
        
        let lineSeparatorLeft = UILabel()
        lineSeparatorLeft.backgroundColor = .white
        contentView.addSubview(lineSeparatorLeft)
        lineSeparatorLeft.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
            make.trailing.equalTo(label.snp.leading)
        }
        
        let lineSeparatorRight = UILabel()
        lineSeparatorRight.backgroundColor = .white
        contentView.addSubview(lineSeparatorRight)
        lineSeparatorRight.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalTo(label.snp.trailing)
        }
        
        
        return contentView
    }()
    
    lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.text = "By signing up, you agree to the "
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    lazy var termsConditionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms of Service"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.addBottomBorder(color: .white)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var andLabel: UILabel = {
        let label = UILabel()
        label.text = " and "
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    lazy var privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.addBottomBorder(color: .white)
        label.isUserInteractionEnabled = true
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
        addSubview(ppBannerView)
        addSubview(companyPhotoView)
        addSubview(headingLabel)
//        addSubview(subheadingLabel)
        addSubview(loginButton)
        addSubview(separatorLabel)
        addSubview(signUpButton)
        addSubview(backgroundImageView)
        
        ppBannerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        companyPhotoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(companyPhotoView.snp.bottom).offset(50)
            make.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
//        subheadingLabel.snp.makeConstraints { make in
//            make.top.equalTo(headingLabel.snp.bottom).offset(16)
//            make.trailing.leading.equalToSuperview().inset(25)
//        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        
        separatorLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(180)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(separatorLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        
        let footerContainer = UIView()
        footerContainer.addSubview(footerLabel)
        footerContainer.addSubview(termsConditionsLabel)
        footerContainer.addSubview(andLabel)
        footerContainer.addSubview(privacyPolicyLabel)
        
        addSubview(footerContainer)
        footerContainer.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-44)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
        }
        
        termsConditionsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(footerLabel.snp.centerY)
            make.leading.equalTo(footerLabel.snp.trailing).offset(4)
        }
        
        andLabel.snp.makeConstraints { make in
            make.centerY.equalTo(termsConditionsLabel.snp.centerY)
            make.leading.equalTo(termsConditionsLabel.snp.trailing)
        }
        
        privacyPolicyLabel.snp.makeConstraints { make in
            make.top.equalTo(footerLabel.snp.bottom).offset(4)
            make.centerX.bottom.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        sendSubviewToBack(backgroundImageView)
        
        backgroundColor = .black
    }
}
