//
//  HomeDetailView.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//

import UIKit

final class HomeDetailView : UIView {
    var model : HomeModel? {
        didSet{
            prepareDisplay(model)
        }
    }
    
    var didTappedBackButton : (()->())?
    
    private lazy var backButton : UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = UIColor(named: "redTint")!.withAlphaComponent(0.7)
        backButton.makeShadow(color: UIColor(named: "blueTint") ?? .systemBlue, offSet: CGSize(width: 0, height: 4), radius: 5, opacity: 0.7)
        return backButton
    }()
    
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.makeShadow(color: UIColor(named: "blueTint") ?? .systemBlue, offSet: CGSize(width: 0, height: 4), radius: 5, opacity: 0.7)
        return label
    }()
    
    private lazy var durationIcon : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "durationIcon"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.tintColor = UIColor(named: "cellText")
        return imgView
    }()
    
    private lazy var durationLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "cellText")
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var imdbIcon : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "imdbStar"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.tintColor = UIColor(named: "cellText")
        return imgView
    }()
    
    private lazy var imdbRateLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "cellText")
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .center
        return text
    }()
    
    private lazy var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineColor")
        return view
    }()
    
    private lazy var releaseDate : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "textColor")
        text.font = .systemFont(ofSize: 16, weight: .medium)
        text.text = "Release Date"
        text.textAlignment = .left
        return text
    }()
    
    private lazy var releaseInfoLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "cellText")
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .left
        return text
    }()
    
    private lazy var genreLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "textColor")
        text.font = .systemFont(ofSize: 16, weight: .medium)
        text.text = "Genre"
        text.textAlignment = .center
        return text
    }()
    
    private lazy var genreInfoLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "cellText")
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .center
        return text
    }()

    
    private lazy var lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineColor")
        return view
    }()
    
    private lazy var plotLabel : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "textColor")
        text.font = .systemFont(ofSize: 16, weight: .medium)
        text.text = "Plot"
        text.textAlignment = .center
        return text
    }()
    
    private lazy var plotInfo : UITextView = {
        let text = UITextView()
        text.textColor = UIColor(named: "cellText")
        text.font = .systemFont(ofSize: 12, weight: .regular)
        text.textAlignment = .center
        text.backgroundColor = .clear
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        backgroundColor = UIColor(named: "backgroundColor")
        addSubview(imgView)
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(durationIcon)
        addSubview(durationLabel)
        addSubview(imdbIcon)
        addSubview(imdbRateLabel)
        addSubview(lineView)
        addSubview(releaseDate)
        addSubview(releaseInfoLabel)
        addSubview(genreLabel)
        addSubview(genreInfoLabel)
        addSubview(lineView2)
        addSubview(plotLabel)
        addSubview(plotInfo)
        
        imgView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        backButton.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(UIView.WIDTH * 0.08)
            maker.top.equalToSuperview().inset(UIView.HEIGHT * 0.09)
            maker.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(imgView.snp.bottom).offset(24)
            maker.leading.equalTo(backButton.snp.leading)
        }
        
        durationIcon.snp.makeConstraints { (maker) in
            maker.leading.equalTo(backButton.snp.leading)
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.size.equalTo(24)
        }
        
        durationLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(durationIcon.snp.trailing).offset(4)
            maker.centerY.equalTo(durationIcon.snp.centerY)
        }
        
        imdbIcon.snp.makeConstraints { (maker) in
            maker.leading.equalTo(durationLabel.snp.trailing).offset(8)
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.size.equalTo(24)
        }
        
        imdbRateLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(imdbIcon.snp.trailing)
            maker.centerY.equalTo(imdbIcon.snp.centerY)
        }
        
        lineView.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.top.equalTo(durationIcon.snp.bottom).offset(16)
            maker.leading.equalTo(durationIcon.snp.leading)
            maker.trailing.equalToSuperview().inset(UIView.WIDTH * 0.08)
        }
        
        releaseDate.snp.makeConstraints { (maker) in
            maker.leading.equalTo(lineView.snp.leading)
            maker.top.equalTo(lineView.snp.bottom).offset(16)
        }
        
        releaseInfoLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(lineView.snp.leading)
            maker.top.equalTo(releaseDate.snp.bottom).offset(12)
        }
        
        genreLabel.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().dividedBy(2)
            maker.top.equalTo(lineView.snp.bottom).offset(16)
            maker.trailing.equalToSuperview()
        }
        
        genreInfoLabel.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().dividedBy(2)
            maker.trailing.equalToSuperview()
            maker.centerY.equalTo(releaseInfoLabel.snp.centerY)
        }
        
        lineView2.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.top.equalTo(genreInfoLabel.snp.bottom).offset(16)
            maker.leading.equalTo(lineView.snp.leading)
            maker.trailing.equalTo(lineView.snp.trailing)
        }
        
        plotLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(lineView2.snp.bottom).offset(16)
        }
        
        plotInfo.snp.makeConstraints { (maker) in
            maker.leading.equalTo(lineView2.snp.leading)
            maker.trailing.equalTo(lineView2.snp.trailing)
            maker.top.equalTo(plotLabel.snp.bottom).offset(16)
            maker.bottom.equalToSuperview()
        }
    }
    
    private func prepareDisplay(_ model : HomeModel?){
        if let modelUrl = model?.poster {
            imgView.sd_setImage(with: URL(string: modelUrl), placeholderImage: UIImage(systemName: "camera.circle.fill"), options: .continueInBackground)
        }
        
        titleLabel.text = model?.title
        durationLabel.text = model?.runtime
        imdbRateLabel.text = model?.imdbRating
        releaseInfoLabel.text = model?.released
        genreInfoLabel.text = model?.genre
        plotInfo.text = model?.plot
    }
    
    @objc private func backButtonClicked(){
        didTappedBackButton?()
    }
}
