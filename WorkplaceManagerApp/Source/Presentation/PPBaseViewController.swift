import UIKit

public class PPBaseViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initKeyboardListener()
    }
    
    private func initKeyboardListener() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
