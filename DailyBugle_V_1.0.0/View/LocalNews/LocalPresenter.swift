
import UIKit

protocol LocalNewsProtocol: class {

}

final class LocalNewsPresenterImpl {

    let navigator: NewsNavigatorImpl

    init(navigator: NewsNavigatorImpl) {
        self.navigator = navigator
    }
}
