

import UIKit

class ViewControllerAssembler {
    func build() -> UIViewController {
        let view = ViewController()
        let presenter = ViewControllerPresenter(
            view: view,
            networkService: NetworkService()
        )
        view.presenter = presenter
        return view
    }
}

