//
//  ViewController.swift
//  DrawSomething
//
//  Created by Ata Etgi on 24.04.2021.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        print(#function)
        canvas.undo()
    }
    
    @objc fileprivate func handleClear() {
        print(#function)
        canvas.clear()
    }
    
    
    override func loadView() {
        canvas.backgroundColor = .white
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    // MARK: - SETUP UI

    fileprivate func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.distribution = .fillEqually
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

