//
//  BaseView.swift
//  GitHubSearch
//
//  Created by ちゅーたつ on 2018/06/24.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    fileprivate var constraintsInitialized = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    override func updateConstraints() {
        if !constraintsInitialized {
            constraintsInitialized = true
            initializeConstraints()
        }
        modifyConstraints()
        super.updateConstraints()
    }
    
    func initializeView() { /* don't write code here */ }
    func initializeConstraints() { /* don't write code here */ }
    func modifyConstraints() { /* don't write code here */ }
}
