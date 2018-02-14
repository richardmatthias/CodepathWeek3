//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    var isSearching=false
    var result: [Business]!
    @IBOutlet weak var bTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return result.count
        }
        if businesses==nil{
            return 0
        }
        else{
            return businesses!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=bTableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as!BusinessCell
        if isSearching{
            cell.myBusiness=self.result[indexPath.row]
        }
        else{
            cell.myBusiness=self.businesses[indexPath.row]
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text==nil || searchBar.text==""{
            isSearching=false
            view.endEditing(true)
            bTableView.reloadData()
        }
        else{
            isSearching=true
            result=businesses.filter{($0.name?.lowercased().contains(searchText.lowercased()))!}
            bTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bTableView.dataSource=self
        bTableView.delegate=self
        bTableView.rowHeight=UITableViewAutomaticDimension
        bTableView.estimatedRowHeight=120
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            self.bTableView.reloadData()
            }
        )
        
        //searchBar=UISearchBar()
        searchBar.delegate=self
        searchBar.sizeToFit()
        searchBar.returnKeyType=UIReturnKeyType.done
        
        navigationItem.titleView=searchBar
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
