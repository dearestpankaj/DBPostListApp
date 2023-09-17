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
    
    private var cancellable: AnyCancellable?
    
    @IBOutlet var postsTableView: UITableView?
    
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
        presenter.getUserPosts(userID: userID)
    }
    
    @IBAction func onChangePostViewType(segment: UISegmentedControl) {
        presenter.setPostView(postType: segment.selectedSegmentIndex)
    }
}

extension PostListViewController: PostListPresenterToViewProtocol {
    func onPostListResponseSuccess() {
        postsTableView?.reloadData()
//        hideProgressIndicator(view: self.view)
    }
    
    func onPostListResponseFailed(error: String) {
        
//        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Posts", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostListTableViewCell else {
            return UITableViewCell()
        }
        cell.set(viewModel: viewModel.posts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension PostListViewController: PostListTableViewCellDelegate {
    func favoriteButtonAction(viewModel: Post) {
        presenter.setFavoritePost(post: viewModel)
        postsTableView?.reloadData()
    }
}
