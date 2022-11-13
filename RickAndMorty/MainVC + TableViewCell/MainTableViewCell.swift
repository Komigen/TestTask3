import UIKit

final class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.layer.masksToBounds = false
            shadowView.layer.backgroundColor = UIColor.white.cgColor
            shadowView.layer.shadowColor = UIColor.darkGray.cgColor
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 40.0)
            shadowView.layer.shadowRadius = 15.0
        }
    }
    
    @IBOutlet weak var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.masksToBounds = true
            heroImageView.layer.cornerRadius = 35.0
        }
    }
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroSpeciesLabel: UILabel!
    @IBOutlet weak var watchLabel: UIView! {
        didSet {
            watchLabel.layer.cornerRadius = 15.0
            watchLabel.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var heroLocation: UILabel!
    @IBOutlet weak var heroStatusLabel: UILabel!
    @IBOutlet weak var heroStatusView: UIView! {
        didSet {
            heroStatusView.layer.cornerRadius = 10.0
            heroStatusView.clipsToBounds = true
        }
    }
}

