//
//  ViewController.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/20/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//

import UIKit
import CoreData

class PostsTableViewController: UITableViewController {
    
    //MARK: - Properties
    let context = CoreDataManager.sharedInstance.persistentContainer.viewContext

    //MARK: - Fetch Result
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        
        let postsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostObject")
        postsFetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        postsFetchRequest.returnsObjectsAsFaults = false
        let frc = NSFetchedResultsController(fetchRequest: postsFetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    //MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.fetchedResultsController.performFetch()
            
            self.tableView.reloadData()
        } catch {
            print("Error performing initial fetch: \(error)")
        }
       self.tableView.estimatedRowHeight = 80
       self.tableView.rowHeight = UITableViewAutomaticDimension
       self.reloadTableWithNewPosts()
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Update All posts
    func reloadTableWithNewPosts() {
        
        NetworkClient.laodAPIMainUrlData { (postsArray, error) in
            if error != nil {
                if let networkError = error as? NetworkError {
                    switch networkError{
                    case .networkFailure:
                        return
                    default:
                        return
                    }
                }
            }
            NetworkClient.saveRequiredPostsData(postsArray!, completion: { (content, error) in
                if error == nil {
                    DispatchQueue.main.async(execute: { () -> Void in
                        do {
                            try self.fetchedResultsController.performFetch()
                            self.tableView.reloadData()
                        } catch {
                            print("Error: \(error)")
                        }
                    })
                } else {
                    // handle error
                    if let networkError = error as? NetworkError {
                        switch networkError {
                        case .parsingError:
                            print("Error" + "message: Parsing error")
                            return
                            
                        default:
                            print("Error" + "message: Unknown error")
                        }
                    }
                }
            })
            
        }
    }
    
    //MARK: - IBActions
    @IBAction func refreshTable(_ sender: AnyObject) {
        
        DispatchQueue.main.async { () -> Void in
            self.reloadTableWithNewPosts()
            sender.endRefreshing()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let results = self.fetchedResultsController.fetchedObjects?.count {
            return results
        }
        
        return  0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsTableViewCell
         if let dataSource = self.fetchedResultsController.fetchedObjects as? [PostObject] {
            cell.postTitleLabel.text = dataSource[indexPath.row].userName
            cell.postDescriptionLabel.text = dataSource[indexPath.row].userDescription
            
            if let cellImage: UIImage = dataSource[indexPath.row].avatarImage as? UIImage {
                cell.postImageView.image = cellImage
            } else {
                cell.postImageView.image = UIImage(named: "user.JPG")
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
}
}

