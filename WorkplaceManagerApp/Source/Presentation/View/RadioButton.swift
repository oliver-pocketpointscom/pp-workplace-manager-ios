import UIKit

public class RadioButton: NSObject {
    
    var buttons: [PPButton]?
    var selectedButton: PPButton?
    var defaultButton: PPButton = PPButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonArrayUpdated(buttonSelected: PPButton) {
        for button in buttons ?? [] {
            button.tintColor = .white
            if button == buttonSelected {
                selectedButton = button
                button.setImage(UIImage(named: "radio-on"), for: .normal)
            } else {
                button.setImage(UIImage(named: "radio-off"), for: .normal)
            }
        }
    }
}
