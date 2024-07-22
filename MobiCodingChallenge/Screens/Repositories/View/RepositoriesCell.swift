//
//  RepositoriesCell.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 20/07/24.
//

import UIKit

class RepositoriesCell: UITableViewCell {

    @IBOutlet weak var repoBackgroundView: UIView!
    @IBOutlet weak var repoName: UILabel!
    
    @IBOutlet weak var starGazersCount: UILabel!
    
    //Adding property observer for changes
    var repository: RepositoryEntity? {
        didSet { // Property Observer
            repositoryDetailsConfiguration()
        }
    }
    
    //MARK: - methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        repoBackgroundView.backgroundColor = UIColor.systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func repositoryDetailsConfiguration () {
        guard let repository else {
            return
        }
        //assinging respective values
        repoName.text = repository.name
        starGazersCount.text = repository.stargazersCount.description
        //using default accessoryView for showing bookmark image. If the bookmark is added, it will be shown.
        if repository.isBookmarked {
            self.accessoryView = UIImageView(image: UIImage(systemName: "bookmark.fill"))
        } else {
            self.accessoryView = nil
        }
    }
}
