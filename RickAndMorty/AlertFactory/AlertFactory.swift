import UIKit

//MARK: Для обработки ошибок

protocol AlertFactoryProtocol: AnyObject {
    
    func createErrorAlert() -> UIAlertController
}

class AlertFactory: AlertFactoryProtocol {
    
    func createErrorAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Failed to get data", message: "Check your network connection", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        
        return alertController
    }
}
