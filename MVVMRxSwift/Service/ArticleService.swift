//
//  ArticleService.swift
//  MVVMRxSwift
//
//  Created by SJ on 2022/10/17.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocal {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleServiceProtocal {
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            self.fetchNews { error, articles in
                if let error = error {
                    observer.onError(error)
                }
                if let articles = articles {
                    observer.onNext(articles)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
        
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-09-17&sortBy=publishedAt&apiKey=4b731bc248e74f70be0f85968022f9fd"
        guard let url = URL(string: urlString) else { return
            completion(
                NSError(domain: "test",code: 404, userInfo:nil),
                nil
            )
        }
        
        AF.request(
            url,
            method: HTTPMethod.get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            interceptor: nil,
            requestModifier: nil).responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    return completion(error, nil)
                }
                if let articles = response.value?.articles {
                    return completion(nil, articles)
                }
            }
    }
    
}
