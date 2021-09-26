//
//  DomainViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

class DomainViewController: UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
  //  let searchResult: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //textView.text = searchResult?.searchValue ?? "Nothing"
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(textView)
    }
    
    private func setConstraints() {
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
}
