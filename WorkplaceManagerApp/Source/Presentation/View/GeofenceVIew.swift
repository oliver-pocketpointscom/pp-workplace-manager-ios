import UIKit
import MapKit

public class GeofenceView: UIView {
    lazy var map: MKMapView = {
        return MKMapView()
    }()
    
    lazy var primaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Location", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 144/255, green: 213/255, blue: 199/255, alpha: 1.0)
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
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var pinImageView: UIImageView =  {
       let imageView = UIImageView(image: UIImage(named: "pin"))
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var addressContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        view.addSubview(pinImageView)
        view.addSubview(addressLabel)
        
        pinImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(pinImageView.snp.trailing)
            make.top.bottom.trailing.equalToSuperview().inset(8)
        }
        
        return view
    }()
    
    lazy var detailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor()
        
        view.addSubview(addressContainerView)
        view.addSubview(primaryButton)
        
        addressContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(primaryButton.snp.top).offset(-8)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        
        return view
    }()
    
    lazy var centerButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "curLoc"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
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
        addSubview(map)
        addSubview(detailsView)
        
        map.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(map.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
       
        addSubview(centerButton)
        
        centerButton.snp.makeConstraints { make in
            make.bottom.equalTo(detailsView.snp.top).offset(-8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.width.equalTo(35)
        }
    }
}
