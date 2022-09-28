//
//  HomeCell.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import SDWebImage
import UIKit

final class HomeCell: UICollectionViewCell {
    static let cellId:String = "HomeCell"
    // MARK: - UIElements
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution  = .fillEqually
        stack.alignment = .center
        stack.spacing = 16.0
        return stack
    }()
    
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var typeLabel : UILabel = {
        let text = UILabel()
        text.backgroundColor = .clear
        text.textColor = UIColor(named: "cellText")
        text.layer.borderColor = UIColor(named: "strokeColor")?.cgColor
        text.layer.borderWidth = 2
        text.layer.cornerRadius = 5
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "cellBgColor")?.withAlphaComponent(0.25)
        layer.cornerRadius = 20
        clipsToBounds = true
        makeShadow(color: UIColor(named: "strokeColor")!, offSet: CGSize(width: 0, height: -6), radius: 10, opacity: 0.5)
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(dateLabel)
        addSubview(imgView)
        addSubview(stackView)
        
        imgView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(16)
            maker.width.equalToSuperview().multipliedBy(0.4)
            maker.top.bottom.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(imgView.snp.trailing).offset(8)
            maker.trailing.equalToSuperview().inset(16)
            maker.top.equalToSuperview().inset(32)
            maker.bottom.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(stackView.snp.leading)
            maker.trailing.equalToSuperview().inset(16)
        }
        
        typeLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(contentView.frame.width * 0.18)
            maker.height.equalTo(32)
        }
        
    }
    
    func configureCell(_ model: HomeModel){
        if let modelUrl = model.poster {
            imgView.sd_setImage(with: URL(string: modelUrl), placeholderImage: UIImage(systemName: "camera.circle.fill"), options: .continueInBackground)
        } else {
            imgView.sd_setImage(with: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.publicdomainpictures.net%2Fen%2Fview-image.php%3Fimage%3D270609%26picture%3Dnot-found-image&psig=AOvVaw0woEKLMrZzwOeMm8tqJseM&ust=1664379513307000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIDT-P6mtfoCFQAAAAAdAAAAABAE"))
        }
        titleLabel.text = model.title
        typeLabel.text = model.type
        dateLabel.text = model.year
    }
}
