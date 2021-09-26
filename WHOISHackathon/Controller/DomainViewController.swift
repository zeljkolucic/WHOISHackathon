//
//  DomainViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit
import UserNotifications

class DomainViewController: UIViewController {
    
    private let favoritesButton: FavoritesButton = {
        let button = FavoritesButton()
        let image = UIImage(systemName: "star")
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let domainName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let expirationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Obavesti me", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let responseTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: Fonts.mainFont, size: 18)
        button.backgroundColor = UIColor(named: "AppBlue")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    var domainDetail: DomainDetail?
    
    init(_ domainDetail: DomainDetail) {
        super.init(nibName: nil, bundle: nil)
        
        self.domainDetail = domainDetail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (permissionGranted, error) in
            if !permissionGranted {
                print("Permission denied.")
            }
        }
        
        configureLayout()
        
        setupLayout()
        setConstraints()
    }
    
    private func configureLayout() {
        favoritesButton.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        
        let createdDate = domainDetail?.createdDateInMiliseconds
        if let createdDate = createdDate {
            let date = Date(timeIntervalSince1970: createdDate / 1000.0)
            let dateString = DateFormatter.toString(date: date)
            createdDateLabel.text = "\(Strings.created)\(dateString)"
        }
        
        let expirationDate = domainDetail?.expirationDateInMiliseconds
        if let expirationDate = expirationDate {
            let date = Date(timeIntervalSince1970: expirationDate / 1000.0)
            let dateString = DateFormatter.toString(date: date)
            expirationDateLabel.text = "\(Strings.expires)\(dateString)"
            mainButton.setTitle(Strings.notifyWhenAvailable, for: .normal)
        } else {
            expirationDateLabel.text = "\(Strings.available)"
            mainButton.setTitle(Strings.buyDomain, for: .normal)
        }
        
        responseTextView.text = domainDetail?.whoIsResponse
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sharedDomainManager.fetchItems()
        let favorites = sharedDomainManager.domainItems
        for i in 0..<favorites.count {
            if favorites[i].name == domainDetail?.name {
                favoritesButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                favoritesButton.isChecked = true
                return
            }
        }
        favoritesButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        favoritesButton.isChecked = false
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(favoritesButton)
        view.addSubview(domainName)
        view.addSubview(createdDateLabel)
        view.addSubview(expirationDateLabel)
        view.addSubview(responseTextView)
        view.addSubview(mainButton)
        
        if let domainDetail = domainDetail {
            domainName.text = domainDetail.name
        }
    }
    
    private func setConstraints() {
        favoritesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        domainName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        domainName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        createdDateLabel.topAnchor.constraint(equalTo: domainName.bottomAnchor, constant: 20).isActive = true
        createdDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        createdDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20).isActive = true
        
        expirationDateLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 20).isActive = true
        expirationDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        expirationDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20).isActive = true
        
        mainButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        mainButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        responseTextView.topAnchor.constraint(equalTo: expirationDateLabel.bottomAnchor, constant: 20).isActive = true
        responseTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        responseTextView.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -20).isActive = true
        responseTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        
    }
    
    @objc private func favoritesButtonPressed() {
        if favoritesButton.isChecked {
            if let name = domainDetail?.name {
                sharedDomainManager.deleteItem(name)
                favoritesButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            }
        } else {
            if let domainDetail = domainDetail {
                sharedDomainManager.insertItem(domainDetail)
                favoritesButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
        favoritesButton.isChecked = !favoritesButton.isChecked
    }
    
    @objc private func notificationButtonPressed() {
        showSimpleActionSheet(controller: self)
    }
    
    private func pushNotification() {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = "Domen \(String(describing: self.domainDetail?.name)) je istekao."
                    content.body = Strings.domainAvailable
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date() + 10)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { error in
                        if error != nil {
                            print("Error \(error.debugDescription)")
                            return
                        }
                    }
                    
                    let date = Date() + 10
                    let ac = UIAlertController(title: "Notifikacija zakazana", message: "U \(date)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(ac, animated: true)
                } else {
                    
                }
            }
        }
    }
    
    private func notifyEmail() {
        let ac = UIAlertController(title: "Unesite mail adresu", message: "", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "abc@gmail.com"
        }
        let saveAction = UIAlertAction(title: "Posalji", style: .default, handler: { alert -> Void in
            sharedNetworkManager.sendEmailRequest(emailAddress: ac.textFields![0].text!, domainName: self.domainName.text!)
        })
        ac.addAction(saveAction)
        ac.addAction(UIAlertAction(title: "Odustani", style: .destructive, handler: nil))
        self.present(ac, animated: true)
    }
    
    private func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "", message: "Izaberite kako želite da Vas oabestimo", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: { (_) in
            self.notifyEmail()
        }))

        alert.addAction(UIAlertAction(title: "Notifikacija", style: .default, handler: { (_) in
            self.pushNotification()
        }))

        alert.addAction(UIAlertAction(title: "Odustani", style: .destructive, handler: { (_) in
            
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
    
}
