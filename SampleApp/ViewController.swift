//
//  ViewController.swift
//  SampleApp
//
//  Created by Prathap Reddy on 9/19/21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var presenter: ViewPresenter?

    var refreshControl = UIRefreshControl()

    var hitsFilter  = [hitsDic]()
    var isFilter = false

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCleanArch()
        addDoneCancel()
        titleLabel.text = "Sports List"
        executeTheAPI(type: "Sports")
        tableView.tableFooterView = UIView()
    }
    
    func executeTheAPI(type:String) {
        progressLoading()
        
        presenter?.checkTheHitsAPI(queryType: type)
    }
    
    func setCleanArch() {
        let controller = self
        presenter = ViewPresenter()
        let interactor = ViewInteractor()
        presenter?.view = controller
        presenter?.interector = interactor
        interactor.presenter = presenter
        presenter?.router = Router.shared
    }


    @IBAction func sectionButtonAction(_ sender: Any) {
        selectionForNewsList()
    }
    
    func selectionForNewsList() {

        let optionMenu = UIAlertController(title: "Select the type for news", message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        let Sports = UIAlertAction(title: "Sports", style: .default) { (alert : UIAlertAction!) in
            self.titleLabel.text = "Sports List"

            self.executeTheAPI(type: "Sports")
        }
        
        let Politics = UIAlertAction(title: "Politics", style: .default) { (alert : UIAlertAction!) in
            self.titleLabel.text = "Politics List"

            self.executeTheAPI(type: "Politics")

        }
        
        let Bollywood = UIAlertAction(title: "Bollywood", style: .default) { (alert : UIAlertAction!) in
            self.titleLabel.text = "Bollywood List"

            self.executeTheAPI(type: "Bollywood")


        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
       
        
        optionMenu.addAction(Sports)
        optionMenu.addAction(Bollywood)
        optionMenu.addAction(Politics)
        optionMenu.addAction(cancelAction)

        
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFilter == true {
            return hitsFilter.count
        }
        
        return HitsModel.sharedInstance.FetchHitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HitsTableViewCell", for: indexPath) as! HitsTableViewCell
        
        if isFilter == true {

        cell.titleLabel.text = hitsFilter[indexPath.row].title
        cell.dateLabel.text = hitsFilter[indexPath.row].created_at
            
        } else{
            cell.titleLabel.text = HitsModel.sharedInstance.FetchHitsList[indexPath.row].title
            cell.dateLabel.text = HitsModel.sharedInstance.FetchHitsList[indexPath.row].created_at
                
        }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isFilter == true {
            if hitsFilter[indexPath.row].url != nil {
                
                guard let url = URL(string: hitsFilter[indexPath.row].url!) else { return }
                
                UIApplication.shared.open(url)
            } else {
                view.makeToast("No Url for this one.")
            }
        } else {
        if HitsModel.sharedInstance.FetchHitsList[indexPath.row].url != nil {
            
            guard let url = URL(string: HitsModel.sharedInstance.FetchHitsList[indexPath.row].url!) else { return }
            
            UIApplication.shared.open(url)
        } else {
            view.makeToast("No Url for this one.")
        }
        }
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 100
    }
    
}



extension ViewController: ViewPresenterToViewProtocol {
  
    func hitsSuccess() {
        hideprogressLoading()

        tableView.reloadData()
        //view.makeToast("Succesfully fetched \(queryType) list.")
    }
    
    func showError(title: String, message: String){
        hideprogressLoading()
        self.showAlert(title: title, message: message)
    }
    
    func showToast(message: String){
        hideprogressLoading()
        

    }
}

extension ViewController: UISearchBarDelegate {
    
    
    func addDoneCancel() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ViewController.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        searchBar.inputAccessoryView = toolBar
    }
    
    
    @objc func doneButtonAction() {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isFilter = false

        
        tableView.reloadData()

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered  = (HitsModel.sharedInstance.FetchHitsList.filter{ ($0.title)!.lowercased().contains(searchText.lowercased())
            
        })
        
        hitsFilter = filtered
        
        isFilter = true
        
        if searchText == "" {
            isFilter = false

        }

       
        
        tableView.reloadData()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
  
       isFilter = true
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        isFilter = false

        
        self.searchBar.showsCancelButton = false
        
       
        tableView.reloadData()
        
    }
}

