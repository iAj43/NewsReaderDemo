//
//  HomeController.swift
//  NewsReaderDemo
//
//  Created by IA on 16/09/24.
//

import UIKit
import Combine

class HomeController: UIViewController {
    
    // MARK: - setup variables
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let categoriesHeaderID = "categoriesHeaderID"
    private let newsArticleTVCellID = "newsArticleTVCellID"
    private var newsViewModel: NewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    //
    // MARK: - create UI
    //
    lazy var mainTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.sectionHeaderHeight = UITableView.automaticDimension
        tv.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        tv.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tv.estimatedSectionFooterHeight = UITableView.automaticDimension
        tv.register(CategoriesHeaderView.self, forHeaderFooterViewReuseIdentifier: self.categoriesHeaderID)
        tv.register(NewsArticleTVC.self, forCellReuseIdentifier: self.newsArticleTVCellID)
        if #available(iOS 15.0, *) {
            tv.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
            tv.contentInsetAdjustmentBehavior = .never
        }
        return tv
    }()
    
    //
    // MARK: - viewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeViewModel()
        setupBindings()
        fetchNewsData()
    }
    
    func initializeViewModel() {
        newsViewModel = NewsViewModel()
    }
    
    func setupBindings() {
        newsViewModel?.$articles
            .receive(on: DispatchQueue.main) // Ensure updates are on the main thread
            .sink { [weak self] _ in
                self?.mainTableView.reloadData()
            }
            .store(in: &cancellables)
        
        newsViewModel?.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                if let message = message {
                    self?.showAlert(title: "", message: message)
                }
            }
            .store(in: &cancellables)
        
        newsViewModel?.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.showLoadingIndicator()
                } else {
                    self?.hideLoadingIndicator()
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchNewsData() {
        Task {
            await newsViewModel?.fetchNews()
        }
    }
}
//
// MARK: - UITableViewDataSource methods
//
extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let unwrappedCell = tableView.dequeueReusableCell(withIdentifier: newsArticleTVCellID, for: indexPath) as? NewsArticleTVC else { return UITableViewCell() }
        unwrappedCell.menuButton.tag = indexPath.row
        unwrappedCell.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        unwrappedCell.setterObj = newsViewModel?.articles[indexPath.row]
        return unwrappedCell
    }
    
    @objc func menuButtonTapped(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose an Option", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Read Full Article", style: .default, handler: { _ in
            self.presentReadFullArticleController(sender.tag)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Bookmark this Article", style: .default, handler: { _ in
            self.handleBookmarkThisArticleTapped(sender.tag)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // For iPad, we need to provide a source view or a bar button item
        if let popoverController = actionSheet.popoverPresentationController {
            // Set the source view or bar button item
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [] // No arrow on iPad
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentReadFullArticleController(_ index: Int) {
        if let isValidIndex = newsViewModel?.articles.indices.contains(index),
           isValidIndex,
           let unwrappedData = newsViewModel?.articles[index] {
            let readFullArticleController = ReadFullArticleController()
            readFullArticleController.modalPresentationStyle = .fullScreen // or .automatic, .pageSheet, depending on your preference
            readFullArticleController.newsArticle = unwrappedData
            present(readFullArticleController, animated: true, completion: nil)
        } else {
            showAlert(title: StringConstants.somethingWentWrong, message: StringConstants.pleaseRetryLater)
        }
    }
    
    func handleBookmarkThisArticleTapped(_ index: Int) {
        showAlert(title: StringConstants.alert, message: StringConstants.comingSoon)
    }
    
    // MARK: - handle header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let unwrappedHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: categoriesHeaderID) as? CategoriesHeaderView else { return nil }
        unwrappedHeader.homeControllerDelegate = self
        return unwrappedHeader
    }
}
//
// MARK: - UITableViewDelegate methods
//
extension HomeController: UITableViewDelegate {
    
    // MARK: - handle header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
//
// MARK: - handle loading indicator
//
extension HomeController {
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating(in: view)
        view.isUserInteractionEnabled = false
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimatingIndicator()
        view.isUserInteractionEnabled = true
    }
}
//
// MARK: - setupUI
//
extension HomeController {
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .coolBackground
        view.addSubview(mainTableView)
        
        // MARK: - setup autoLayout
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
