import UIKit

public class OnboardingView: UIView {
    
    lazy var workplaceAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Pocket Points Workplace"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var companyPhotoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pp"))
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.tintColor = .primary()
        return imageView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "onboarding"))
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
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .black
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
        return .roundedButton(withTitle: "Sign Up", backgroundColor: .gray)
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
        label.text = "By signing up, you agree to the Terms of Service and Privacy Policy"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
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
        addSubview(workplaceAppLabel)
        addSubview(companyPhotoView)
        addSubview(headingLabel)
        addSubview(subheadingLabel)
        addSubview(loginButton)
        addSubview(separatorLabel)
        addSubview(signUpButton)
        addSubview(footerLabel)
        addSubview(backgroundImageView)
        
        workplaceAppLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        companyPhotoView.snp.makeConstraints { make in
            make.top.equalTo(workplaceAppLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
            
        }
        
        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(companyPhotoView.snp.bottom).offset(64)
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        subheadingLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
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
        
        footerLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        sendSubviewToBack(backgroundImageView)
        
        backgroundColor = .backgroundColor()
    }
}
