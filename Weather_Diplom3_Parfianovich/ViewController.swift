protocol WeatherSelectionHandler {
    func didSelectWeather(weather: WeatherClass)
}

protocol ViewControllerProtocol {
    func updateWeatherDisplay(with weather: WeatherClass)
    func showError(message: String)
    func openSearchModule(_ controller: UIViewController)
   
}

import UIKit
import SnapKit
import CoreLocation

final class ViewController: UIViewController, ViewControllerProtocol {

    var presenter: ViewControllerPresenter?
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
       return backgroundImageView
    }()
    private let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textColor = .black
        locationLabel.textAlignment = .center
        locationLabel.font = .systemFont(ofSize: 30)
        locationLabel.backgroundColor = UIColor(white: 1, alpha: 0.6)
        locationLabel.layer.cornerRadius = 20
        return locationLabel
    }()

    private let degreeLabel: UILabel = {
        let degreeLabel = UILabel()
        degreeLabel.textColor = .black
        degreeLabel.font = .systemFont(ofSize: 30)
        degreeLabel.textAlignment = .center
        degreeLabel.backgroundColor = UIColor(white: 1, alpha: 0.6)
        degreeLabel.layer.cornerRadius = 20
        return degreeLabel
    }()

    private let windDirectionLabel: UILabel = {
        let windDirectionLabel = UILabel()
        windDirectionLabel.textColor = .black
        windDirectionLabel.font = .systemFont(ofSize: 30)
        windDirectionLabel.textAlignment = .center
        windDirectionLabel.backgroundColor = UIColor(white: 1, alpha: 0.6)
        windDirectionLabel.layer.cornerRadius = 20
        return windDirectionLabel
    }()

    private let windSpeedLabel: UILabel = {
        let windSpeedLabel = UILabel()
        windSpeedLabel.textColor = .black
        windSpeedLabel.font = .systemFont(ofSize: 30)
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.backgroundColor = UIColor(white: 1, alpha: 0.6)
        windSpeedLabel.layer.cornerRadius = 20
        return windSpeedLabel
    }()

    private let burgerButton: UIButton = {
        let burgerButton = UIButton()
        burgerButton.backgroundColor = .purple
        burgerButton.setTitle("🍔", for: .normal)
        return burgerButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.getLocation()
    }

    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(burgerButton)
        view.addSubview(locationLabel)
        view.addSubview(degreeLabel)
        view.addSubview(windDirectionLabel)
        view.addSubview(windSpeedLabel)
        
        backgroundImageView.frame = view.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
       
        backgroundImageView.image = UIImage(named: "sunset")

        burgerButton.addAction(UIAction { [weak self] _ in
            self?.burgerAction()
        }, for: .touchUpInside)

        burgerButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(50)
        }

        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        degreeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }

        windDirectionLabel.snp.makeConstraints { make in
            make.top.equalTo(degreeLabel.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(50)
        }

        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirectionLabel.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
/// Да, я знаю, что это нужно в презентер вынести, я попыталась и начало все сыпаться... потянулось много изменеий, поэтому оставила так
    func updateWeatherDisplay(with weather: WeatherClass) {
        
        locationLabel.text = weather.city
        degreeLabel.text = "\(weather.degree) °C"
        windDirectionLabel.text = weather.windDirectionText
        windSpeedLabel.text = "\(weather.windSpeed) м/с"
    }

    func showError(message: String) {
        print("Ошибка: \(message)")
    }
    
    func openSearchModule(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
   
    func burgerAction() {
        
            presenter?.didTapBurger()
        
    }
}
