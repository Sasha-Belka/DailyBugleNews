
import UIKit
import SDWebImage


final class LocalViewController: UIViewController {

    private var presenter: LocalNewsPresenterImpl
    var favorite: FavoriteNews

   
    @IBOutlet weak var newsHeadTitle: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var sectionLabel: UILabel!
 
    @IBOutlet weak var updatedLabel: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
    
    init(favorite: FavoriteNews, presenter: LocalNewsPresenterImpl) {
        self.presenter = presenter
        self.favorite = favorite
        super.init(nibName: "LocalViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: favorite.imageUrl ?? "0") else {return}
        newsImage.sd_setImage(with: url, completed: nil)
        setupUI()
    }
}

extension LocalViewController {
    func setupUI() {
        newsHeadTitle.lineBreakMode = .byWordWrapping
        newsHeadTitle.numberOfLines = 0
        newsHeadTitle.text = favorite.headTitle
        sourceLabel.text = "Source: " + (favorite.source ?? "-")
        sectionLabel.text = "Section: " + (favorite.section ?? "-")
        updatedLabel.text = "Updated: " + (favorite.update ?? "-")
    }
}


