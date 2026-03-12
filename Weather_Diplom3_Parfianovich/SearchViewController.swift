
protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ controller: SearchViewController, didSelectWeather weather: WeatherClass)
}
protocol SearchViewProtocol{
    func reloadCities()
    func showError(message: String)
}


import UIKit
import SnapKit

final class SearchViewController: UIViewController, SearchViewProtocol {

    var presenter: SearchPresenter?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.backgroundColor = .green
        backButton.setTitle("🔙", for: .normal)
        return backButton
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the name of any city"
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 2
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
                return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }

    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(backButton)
        view.addSubview(tableView)
        
        textField.delegate = self
        
        let backAction = UIAction { _ in
            self.backAction()
        }
        backButton.addAction(backAction, for: .touchUpInside)
    

        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func backAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func reloadCities() {
        tableView.reloadData()
    }

    func showError(message: String) {
        print(message)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.cities.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = presenter?.cities[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = presenter?.cities[indexPath.row] else { return }
        textField.text = city
        presenter?.fetchWeather(for: city)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.addCity(textField.text ?? "")
        textField.text = ""
        return true
    }
}
