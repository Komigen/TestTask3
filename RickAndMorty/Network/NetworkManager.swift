import Foundation
import UIKit

final class NetworkManager {
    
    func getData(viewController: UIViewController,
                 completion: @escaping ([Result]) -> Void) {
        
        let urlToString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlToString) else {
            print("ERROR: posts URL-address not valid.")
            return }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, _, error) -> Void in
            
            if let safeError = error {
                print(safeError.localizedDescription)
                DispatchQueue.main.async {
                    viewController.present(AlertFactory().createErrorAlert(), animated: true)
                }
            }
            
            if let safeData = data {
                
                do {
                    let result = try JSONDecoder().decode(DataModel.self, from: safeData)
                    DispatchQueue.main.async {
                        completion(result.results)
                    }
                    print("SUCCESSED: parsing JsonData.")
                } catch {
                    print("ERROR: parsing JsonData. \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
