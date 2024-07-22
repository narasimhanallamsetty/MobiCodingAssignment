//
//  RepositoryDetailsVC.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 20/07/24.
//

import UIKit

class RepositoryDetailsVC: UIViewController {

        private let repository: RepositoryEntity
        private let viewModel = RepositoryViewModel()
    
        private let nameLabel = UILabel()
        private let starsLabel = UILabel()
        private let bookmarkButton = UIButton(type: .system)
        
        init(repository: RepositoryEntity) {
            self.repository = repository
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    //MARK: - methods
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupUI()
            
           
            updateBookmarkButton()
            bookmarkButton.addTarget(self, action: #selector(toggleBookmark), for: .touchUpInside)
        }
        
        private func setupUI() {
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            starsLabel.translatesAutoresizingMaskIntoConstraints = false
            bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(nameLabel)
            view.addSubview(starsLabel)
            view.addSubview(bookmarkButton)
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                starsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                starsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                bookmarkButton.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 20),
                bookmarkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            nameLabel.text = repository.name
            starsLabel.text = "⭐️ \(repository.stargazersCount)"
            
        }
        
    //this method will be called to update bookmark button status
        private func updateBookmarkButton() {
            let title = repository.isBookmarked ? removeBookmark : addBookmark
            // Update button title with animation
                   UIView.transition(with: bookmarkButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                       self.bookmarkButton.setTitle(title, for: .normal)
                   })
        }
        
    //This function updates bookmarking of repository status
        @objc private func toggleBookmark() {
            if repository.isBookmarked {
                PersistenceManager.shared.removeBookmark(repository: repository)
            } else {
                PersistenceManager.shared.saveBookmark(repository: repository)
            }
            updateBookmarkButton()
            if repository.isBookmarked == true {
                //show alert
                showAlert(msg: addedBookmarkMessage)
            } else {
                showAlert(msg: removedBookmarkMessage)
            }
        }

}
