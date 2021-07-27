
import UIKit

protocol LocalNewsProtocol: class {

}

final class LocalNewsPresenterImpl {

    let navigator: NewsNavigatorImpl

    init(navigator: NewsNavigatorImpl) {
        self.navigator = navigator
    }
    func message(new: String?, viewController: UIViewController){
        let alert = UIAlertController(title: new, message: "Deleted", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}
