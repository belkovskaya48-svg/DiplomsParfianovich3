import UIKit
import SnapKit

final class TableViewCell : UITableViewCell {
    
    static var identifier : String {"\(Self.self)"}
    
    private let namelabel : UILabel = {
        let namelabel = UILabel()
        namelabel.textAlignment = .left
        namelabel.font = .systemFont(ofSize: 20, weight: .regular)
        namelabel.textColor = .black
        return namelabel
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(namelabel)
        namelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }

    }
    
    func configure(with city : WeatherClass){
        namelabel.text = city.city 

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        namelabel.text = nil

    }
}

