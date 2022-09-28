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
    
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
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
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func prepareDisplay(_ model : HomeModel?){
        if let modelUrl = model?.poster {
            imgView.sd_setImage(with: URL(string: modelUrl), placeholderImage: UIImage(systemName: "camera.circle.fill"), options: .continueInBackground)
        }
    }
}
