import UIKit

extension UIViewController {
    
    public func push(vc: UIViewController, barTint: UIColor = .primary()) {
        self.navigationController?.navigationBar.tintColor = barTint
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getCustomTitleLabel(navigationBar: UINavigationBar) -> UILabel {
        let firstFrame = CGRect(x: 32, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
        let label = UILabel(frame: firstFrame)
        label.text = "Workplace"
        label.textColor = .black
        let fontDec = UIFontDescriptor(name: "Futura", size: 20)
        fontDec.withSymbolicTraits(.traitBold)
        let font = UIFont(descriptor: fontDec, size: 20)
        label.font = font
        label.tag = 1
        return label
    }
    
    public func addNavBarTitle() {
        clearNavBarTitle()
        if let navigationBar = navigationController?.navigationBar {
//            navigationBar.addSubview(getCustomTitleLabel(navigationBar: navigationBar))
            let imageView = UIImageView(image: UIImage(named: "logo-white"))
            imageView.tag = 1
            navigationBar.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
    
    public func clearNavBarTitle() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.subviews.forEach { view in
                if let view = view as? UIImageView {
                    if view.tag == 1 {
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    public func showUnderConstructionDialog() {
        let message = "This feature is not available as of the moment."
        let alert = UIAlertController(title: "Coming Soon!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func addTitle(_ title: String) {
        clearNavBarTitle()
        navigationController?.topViewController?.navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
