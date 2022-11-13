import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    private let networkManager = NetworkManager()
    private var heroesInfoStorage = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate   = self
    }
    
    //MARK: Network request
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkManager.getData(viewController: self) { [weak self] results in
            guard let self = self else { return }
            self.heroesInfoStorage = results
        }
    }
    
    //MARK: Animate tableView
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainTableView.animateTableView()
    }
}

//MARK: Extension for UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesInfoStorage.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        let item = heroesInfoStorage[indexPath.row]
        
        //MARK: Загрузка изображения
        
        let url = URL(string: item.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [self] in
                
                cell.heroImageView.image = UIImage(data: data!)
                
                //MARK: Настройка UI элементов в зависимости от статуса героя (DEAD, ALIVE, UNKNOWN)

                cell.heroStatusLabel.text = {
                                
                    switch item.status.rawValue {
                        
                    case "Alive":
                        cell.heroStatusView.backgroundColor = UIColor(named: "customLightGreen")
                        cell.heroStatusLabel.textColor = UIColor(named: "customGreen")
                        
                        return "ALIVE"
                        
                    case "unknown":
                        cell.heroStatusView.backgroundColor = UIColor(named: "customLightGray")
                        cell.heroStatusLabel.textColor = UIColor(named: "customGray")
                        
                        return "UNKNOWN"
                        
                    case "Dead":
                        cell.heroStatusView.backgroundColor = UIColor(named: "customLightOrange")
                        cell.heroStatusLabel.textColor = UIColor(named: "customOrange")
                        cell.heroImageView.image = monochromaticImage(from: UIImage(data: data!)!, in: .white)
                        
                        return "DEAD"
                    default:
                        return ""
                    }
                }()
            }
        }
        
        cell.heroNameLabel.text = item.name
        cell.heroSpeciesLabel.text = "\(item.species.rawValue), \(item.gender.rawValue.lowercased())"
        cell.heroLocation.text = item.location.name
        
        return cell
    }
}
