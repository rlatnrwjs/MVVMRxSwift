//
//  Coordinator.swift
//  MVVMRxSwift
//
//  Created by SJ on 2022/10/17.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()
    }
     
}
