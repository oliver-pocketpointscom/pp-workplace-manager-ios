import UIKit

extension UIButton {
    
    public class func roundedButton(withTitle title: String, backgroundColor: UIColor = .pocketpointsGreen()) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = button.frame.size
        gradient.colors = [UIColor.white.cgColor,UIColor.white.withAlphaComponent(1).cgColor]
        button.layer.insertSublayer(gradient, at:0)
        return button
    }
}
