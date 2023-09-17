//
//  PostListViewController.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit
import Combine

class PostListViewController: UIViewController {
    private let userID: Int
    private let viewModel: PostListViewModel
    private let presenter: PostListViewToPresenterProtocol
    
    var posts = [Post]()
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet var postsTableView: UITableView?
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    init(
        _ userID: Int,
        _ viewModel: PostListViewModel,
        _ presenter: PostListViewToPresenterProtocol
    ) {
        self.userID = userID
        self.viewModel = viewModel
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postsTableView?.register(UINib(nibName: "PostListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        title = viewModel.pageTitle
        initializeBindings()
        
        presenter.getUserPosts(userID: userID)
    }
    
    private func initializeBindings() {
        viewModel.$isLoading.sink(receiveValue: { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator?.startAnimating()
            } else {
                self?.activityIndicator?.stopAnimating()
            }
        }).store(in: &cancellables)
        
        viewModel.$posts.sink(receiveValue: { [weak self] posts in
            self?.posts = posts
            self?.postsTableView?.reloadData()
        }).store(in: &cancellables)
        
        viewModel.$errorMessage.sink(receiveValue: { [weak self] errorMessage in
            
            guard let errorMessage = errorMessage else { return }
            
            let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }).store(in: &cancellables)
    }
    
    @IBAction func onChangePostViewType(segment: UISegmentedControl) {
        presenter.setPostView(postType: segment.selectedSegmentIndex)
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostListTableViewCell else {
            return UITableViewCell()
        }
        cell.set(viewModel: posts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension PostListViewController: PostListTableViewCellDelegate {
    func favoriteButtonAction(viewModel: Post) {
        presenter.setFavoritePost(post: viewModel)
    }
}
