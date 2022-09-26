//
//  HomeViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import UIKit

protocol HomeDisplayLogic: AnyObject{
    func displayModel(_ model:[HomeModel])
    func handleError(_ message:String)
}

final class HomeViewController: UIViewController{
    var interactor: HomeBusinessLogic?
    var router: HomeRoutingLogic?
    
    private var responseModel : [HomeModel]?
    
    private lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.cellId)
        return cv
    }()
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.showsSearchResultsButton = false
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Please Search any movie.."
        searchBar.image(for: .search, state: .normal)
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup(){
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
    }
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
        configureRefreshControl()
        LottieHud.shared.show()
        interactor?.getSearchedMovies(request: HomeRequestModel(page: 1, s: "bat"))
    }
    
    private func configureUI(){
        navigationItem.titleView = searchBar
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIView.HEIGHT * 0.05)
            make.leading.trailing.equalToSuperview().inset(UIView.WIDTH * 0.05)
            make.center.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func pullToRefresh(_ sender:UIRefreshControl){
        searchBar.text = ""
//        presenter?.getNews(keyword: nil, page: page)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            sender.endRefreshing()
        }
//        page = 1
//        keyword = nil
    }
    
    private func configureCancelButton(){
        for view in searchBar.subviews {
            for views in view.subviews {
                if let hasGesture = views.gestureRecognizers?.count, hasGesture > 0 {
                    for subView in views.subviews {
                        if let button = subView as? UIButton {
                            button.isEnabled = true
                            button.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
    }
}
// MARK: Display Logic

extension HomeViewController:HomeDisplayLogic {
    func displayModel(_ model: [HomeModel]) {
        self.responseModel = model
        DispatchQueue.main.async {
            LottieHud.shared.hide()
            self.collectionView.reloadData()

        }
    }
     
    func handleError(_ message: String) {
        DispatchQueue.main.async {
            LottieHud.shared.hide()
            self.showToast(message: message, backGroundColor: .red)
        }
    }
    
    
}
// MARK: Collection View

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellId, for: indexPath ) as? HomeCell, let model = responseModel?[indexPath.row] {
            cell.configureCell(model)
            return cell
        }
        return UICollectionViewCell()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: UIView.HEIGHT * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
}
// MARK: Searchbar

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            page = 1
//            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            searchWorkItem?.cancel()
//            let requestWorkItem = DispatchWorkItem { [weak self] in
//                self?.presenter?.getNews(keyword: searchText, page: self?.page)
//            }
//            searchWorkItem = requestWorkItem
//            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800), execute: requestWorkItem)
//            self.keyword = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
//            presenter?.getNews(keyword: nil, page: page)
//            page = 1
//            keyword = nil
        }
}
