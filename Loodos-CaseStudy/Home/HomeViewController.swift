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
    private var requestModel : HomeRequestModel = HomeRequestModel(page: 1, s: nil)
    private var currentIndexPath: IndexPath?
    private lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        cv.showsVerticalScrollIndicator = true
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
        searchBar.tintColor = .darkGray
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
        showStableMessage(message: "Searching for get data", backGroundColor: .systemGreen)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCancelButton()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.titleView = nil
    }
    
    private func configureNavBar(){
        navigationItem.titleView = searchBar
        navigationController?.modalTransitionStyle = .partialCurl
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = nil
    }
    
    private func configureUI(){
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIView.WIDTH * 0.05)
        }
    }
    
    private func configureCancelButton(){
        for view in searchBar.subviews {
            for views in view.subviews {
                if let hasGesture = views.gestureRecognizers?.count, hasGesture > 0 {
                    for subView in views.subviews {
                        if let button = subView as? UIButton {
                            button.tintColor = UIColor(named: "redTint")!.withAlphaComponent(0.7)
                        }
                    }
                }
            }
        }
    }
    
    private func makeRequest(_ searchText: String, _ page:Int) {
        let requestWorkItem = DispatchWorkItem {
            self.requestModel.s = searchText
            self.requestModel.page = page
            self.interactor?.getSearchedMovies(request: self.requestModel)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: requestWorkItem)
    }
}
// MARK: Display Logic

extension HomeViewController:HomeDisplayLogic {
    func displayModel(_ model: [HomeModel]) {
        DispatchQueue.main.async {
            if let _ = self.currentIndexPath, let count = self.responseModel?.count {
                self.responseModel?.append(contentsOf: model)
                self.collectionView.scrollToItem(at: IndexPath(row: count - 1, section: 0), at: .top, animated: true)
            } else {
                self.responseModel = model
            }
            self.collectionView.reloadData()
            
        }
    }
    
    func handleError(_ message: String) {
        DispatchQueue.main.async {
            if self.currentIndexPath == nil {
                self.responseModel = nil
                self.collectionView.reloadData()
            }
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
        currentIndexPath = indexPath
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellId, for: indexPath ) as? HomeCell, let model = responseModel?[indexPath.row], let count = responseModel?.count {
            
            cell.configureCell(model)
            
            if let page = requestModel.page, indexPath.row == count - 1 {
                makeRequest(requestModel.s ?? "", page+1)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let modelId = responseModel?[indexPath.row].imdbID {
            self.router?.routeToDetailScreen(modelId)
        }
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
        searchBar.showsCancelButton = true
        configureCancelButton()
        if searchText.count > 2 {
            currentIndexPath = nil
            makeRequest(searchText, 1)
        } else if searchText.count == 0 {
            self.requestModel.s = nil
            self.requestModel.page = 1
            searchBar.showsCancelButton = false
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        removeStableMessage()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.requestModel.s = nil
        self.requestModel.page = 1
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        currentIndexPath = nil
        interactor?.getSearchedMovies(request: self.requestModel)
        searchBar.showsCancelButton = true
        configureCancelButton()
        searchBar.endEditing(true)
    }
}
