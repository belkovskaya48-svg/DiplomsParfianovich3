
import UIKit

class SearchAssembler {
    
    func build(onSelect: @escaping (WeatherClass) -> Void) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(
            view: view,
            networkService: NetworkService()
        )
        presenter.weatherSelectionHandler = onSelect
        view.presenter = presenter
        return view
    }
}
