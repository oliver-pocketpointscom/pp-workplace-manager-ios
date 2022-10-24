import UIKit

extension PPGeofenceViewController {
    
    public func showFailedToCreateGeofenceMessage() {
        let message = "Unable to create the Geofence. Please try again."
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    public func confirmGeofence() {
        let alert = UIAlertController(title: "Please confirm that the Geolocation is correct.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {
            [weak self ]action in
            guard let strongSelf = self else { return }
            strongSelf.onConfirm()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
