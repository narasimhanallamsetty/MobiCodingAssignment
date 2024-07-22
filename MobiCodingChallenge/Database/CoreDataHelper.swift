//
//  CoreDataHelper.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 20/07/24.
//

import Foundation
import UIKit
import CoreData

//This is a helper struct for saving data to core data or fetching data from core data
struct PersistenceManager {
    
    //creating shared instance for struct
        static let shared = PersistenceManager()
        let persistentContainer: NSPersistentContainer
        
        public init() {
            persistentContainer = NSPersistentContainer(name: appName)
            persistentContainer.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("\(coreDataStackFailedMessage): \(error.localizedDescription)")
                }
            }
        }
        
    //saving repository to the database here
        func saveRepository(id: Int, name: String, stargazersCount: Int) {
            let context = persistentContainer.viewContext
            let repositoryEntity = RepositoryEntity(context: context)
            repositoryEntity.id = Int32(id)
            repositoryEntity.name = name
            repositoryEntity.stargazersCount = Int32(stargazersCount)
            
            do {
                try context.save()
            } catch {
                print("\(failedToSaveRepositoryMessage): \(error.localizedDescription)")
            }
        }
        
    //Retrieving data from database
        func fetchRepositories() -> [RepositoryEntity] {
            let context = persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<RepositoryEntity> = RepositoryEntity.fetchRequest()
            
            do {
                return try context.fetch(fetchRequest)
            } catch {
                print("\(failedtoFetchRepositoriesMessage): \(error.localizedDescription)")
                return []
            }
        }
        
    //saving bookmark
        func saveBookmark(repository: RepositoryEntity) {
            let context = persistentContainer.viewContext
            repository.isBookmarked = true
            
            do {
                try context.save()
            } catch {
                print("\(failedtoSaveBookmarkMessage): \(error.localizedDescription)")
            }
        }
        
    //removing bookmark
        func removeBookmark(repository: RepositoryEntity) {
            let context = persistentContainer.viewContext
            repository.isBookmarked = false
            
            do {
                try context.save()
            } catch {
                print("\(failedtoRemoveBookmarkMessage): \(error.localizedDescription)")
            }
        }

}
