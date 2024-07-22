//
//  RepositoriesVC.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 19/07/24.
//

import UIKit


class RepositoriesVC: UIViewController {

    @IBOutlet weak var tableViewObj: UITableView!
    
    private let viewModel = RepositoryViewModel()
    var activityIndicator: UIActivityIndicatorView!

    //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupActivityIndicator()
        self.configuration()
    }
    
    private func setupActivityIndicator() {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = UIColor.clear
            self.view.addSubview(activityIndicator)
        }
    
    func setLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2) {
                self.view.alpha = 0.5
            }
        } else {
            activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.2) {
                self.view.alpha = 1.0
            }
        }
    }
    
    //every time view appears data will be with updated data
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableViewObj.reloadData()
        }
    }
    
    // registering cell with tableview
    func configuration () {
        title = squareRepositoriesTitle
        let nib = UINib(nibName: repositoriesCell, bundle: nil)
        tableViewObj.register(nib, forCellReuseIdentifier: repositoriesCell)
        self.setLoading(true)
        initViewModel()
    }

    //updating UI through closure and reloading tableview
    func initViewModel () {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    /// show Indicator here
                    self.setLoading(true)
                case .stopLoading:
                    //stop Indicator here
                    self.setLoading(false)
                case .dataLoaded:
                    //once data loaded we reload the tableview and stop activity indicator
                    self.tableViewObj.reloadData()
                    self.setLoading(false)
                case .error(_error: let _error):
                    //if we receive th the error then we stop activity indicator and show an alert with error description
                    self.setLoading(false)
                    self.showAlert(msg: _error.localizedDescription)
                }
            }
        }
                viewModel.loadRepositories() //fetch repositories
    }
}

//Added an extension for handling datasource and delegate methods
extension RepositoriesVC:UITableViewDataSource,UITableViewDelegate {
    
    // repositories count from database will be displayed
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.getRepositories().count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: repositoriesCell, for: indexPath)as? RepositoriesCell else {
            return UITableViewCell()
        }
            let repository = viewModel.getRepositories()[indexPath.row]
        cell.repository = repository //sending particular repository entity to the cell
            cell.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    cell.alpha = 1
                })
            if indexPath.row == viewModel.getRepositories().count - 1 && !viewModel.isLoading {
                viewModel.loadRepositories()
            }
            
            return cell
        }
        
    //upon particular repository selection, user will be redirected to details screen.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let repository = viewModel.getRepositories()[indexPath.row]
            let detailsVC = RepositoryDetailsVC(repository: repository)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    
    //Changed height of the tableview row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
