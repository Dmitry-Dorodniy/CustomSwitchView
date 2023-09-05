//
//  ViewController.swift
//  CustomSwitchView
//
//  Created by Dmitry Dorodniy on 19.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var customSwitch: UIView = {
        let view = CustomSwitchView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = .systemGray4
        view.offTintColor = .systemGray4
        view.cornerRadius = 0.5
        view.thumbCornerRadius = 0.5
        view.thumbSize = .init(width: 30, height: 30)
        view.padding = 0
        view.thumbInPadding = 5
        view.thumbOnTintColor = .systemPink
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        setupHierarchy()
        setupLayuot()
    }
    
    // MARK: - Setups
        func setupView() {
            view.backgroundColor = .systemBackground
        }
        
        func setupHierarchy() {
            view.addSubview(customSwitch)
        }
        
        func setupLayuot() {
            NSLayoutConstraint.activate([
                customSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                customSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                customSwitch.widthAnchor.constraint(equalToConstant: 40),
                customSwitch.heightAnchor.constraint(equalToConstant: 24)
            ])
            }
}

