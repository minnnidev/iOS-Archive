//
//  ViewController.swift
//  TextViewDynamicHeight
//
//  Created by 김민 on 2023/02/12.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let textView: UITextView = UITextView()
    
    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
}

extension ViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white
        
//        1. scroll 막고, sizeToFit() 이용
        textView.do {
            $0.backgroundColor = .systemGray5
            $0.font = .systemFont(ofSize: 20)
            $0.isScrollEnabled = false
            $0.sizeToFit()
        }
        
//        2. font 크기 조절
//        textView.do {
//            $0.backgroundColor = .systemGray5
//            $0.font = .systemFont(ofSize: 20)
//            $0.isScrollEnabled = false
//            $0.sizeToFit()
//        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
        }
    }
}
