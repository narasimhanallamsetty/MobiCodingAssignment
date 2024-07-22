//
//  Constant.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 19/07/24.
//

import Foundation

//We can save constants here
struct Constant {
    static let baseURL = "https://api.github.com/orgs/square/repos"
}

//Repositories list screen texts
let squareRepositoriesTitle = "Square Repositories"
let repositoriesCell = "RepositoriesCell"
let appName = "MobiCodingChallenge"

//Repository details screen title texts and messages
let okTitle = "ok"
let alertTitle = "Alert"
let addBookmark = "Add Bookmark"
let removeBookmark = "Remove Bookmark"
let addedBookmarkMessage = "Repository added to bookmarks"
let removedBookmarkMessage = "Repository removed from bookmarks"
let bookmarkFill = "bookmark.fill"

//core data related messages.
let coreDataStackFailedMessage =  "Core Data stack initialization failed"
let failedToSaveRepositoryMessage = "Failed to save repository"
let failedtoFetchRepositoriesMessage = "Failed to fetch repositories"
let failedtoSaveBookmarkMessage = "Failed to save bookmark"
let failedtoRemoveBookmarkMessage = "Failed to remove bookmark"
