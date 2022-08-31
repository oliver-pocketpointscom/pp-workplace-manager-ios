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
        let fontDec = UIFontDescriptor(name: "Futura", size: 20)
        fontDec.withSymbolicTraits(.traitBold)
        let font = UIFont(descriptor: fontDec, size: 20)
        label.font = font
        label.tag = 1
        return label
    }
    
    public func addNavBarTitle() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.addSubview(getCustomTitleLabel(navigationBar: navigationBar))
        }
    }
    
    public func clearNavBarTitle() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.subviews.forEach { view in
                if let label = view as? UILabel {
                    if label.tag == 1 {
                        label.removeFromSuperview()
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
        navigationController?.topViewController?.navigationItem.title = title
    }
}
