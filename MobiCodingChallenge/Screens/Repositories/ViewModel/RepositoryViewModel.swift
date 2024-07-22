//
//  RepositoryViewModel.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 19/07/24.
//


import UIKit

class RepositoryViewModel {
    //taking a varibale for page count
    private var currentPage = 1
    private var repositories: [RepositoryEntity] = []
  
    var isLoading = false
    //creating closure for data communication
    var eventHandler: ((_ event: Event) -> Void)?

    func loadRepositories() {
        guard !isLoading else { return }
        isLoading = true
        //API call for fetching data with page number
        NetworkManager.shared.fetchRepositories(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let repositories):
                    repositories.forEach { repository in
                        PersistenceManager.shared.saveRepository(id: repository.id, name: repository.name, stargazersCount: repository.stargazers_count)
                        //data saved in the database here
                    }
                    self?.currentPage += 1
                    //fetching data and assigning to repositories array
                    self?.repositories = PersistenceManager.shared.fetchRepositories()
                    //sending data loaded call back
                    self?.eventHandler?(.dataLoaded)
                case .failure(let error):
                    print("\(failedtoFetchRepositoriesMessage): \(error.localizedDescription)")
                    self?.eventHandler?(.error(_error: error))
                }
            }
        }
    }
    
    //function to return repositories
    func getRepositories() -> [RepositoryEntity] {
        return repositories
    }
}

//Added one extension for sending appropriate state of API calling.
extension RepositoryViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(_error:Error)
    }
}
