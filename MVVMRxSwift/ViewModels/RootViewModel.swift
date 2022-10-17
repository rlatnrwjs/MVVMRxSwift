//
//  RootViewModel.swift
//  MVVMRxSwift
//
//  Created by SJ on 2022/10/17.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "Sook News"
    
    private let articleService: ArticleServiceProtocal
    
    init(articleService: ArticleServiceProtocal) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[Article]> {
        return articleService.fetchNews()
    }
}
