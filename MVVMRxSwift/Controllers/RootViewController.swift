//
//  RootViewController.swift
//  MVVMRxSwift
//
//  Created by SJ on 2022/10/17.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    // MARK: Properties
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    private let articles = BehaviorRelay<[Article]>(value: [])
    var articlesObserver: Observable<[Article]> {
        return articles.asObservable()
    }
    // MARK: Rifecycles
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchArticles()
    }
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: Helpers
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe { articles in
            self.articles.accept(articles)
        }.disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articlesObserver.subscribe { articles in
            // collectionview를 생성할건데요, 이때 collectionView.reloadData함수를 호출할거임
        }.disposed(by: disposeBag)

    }
}
