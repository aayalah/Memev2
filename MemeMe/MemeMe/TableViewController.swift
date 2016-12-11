//
//  TableViewController.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 11/28/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import UIKit




class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var memes: MemeModel!
    let reuseIdentifier = "TableViewCell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memes = MemeModel.model
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        if memes.getCount() == 0 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "imageMeme") as! ImageMemeController
            present(controller, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
        
        cell.setContent(memes.getMemeImage(indexPath.row), labelText: memes.getTopLabel(indexPath.row) + "..." + memes.getBottomLabel(indexPath.row))
        cell.meme.image = memes.getMemeImage(indexPath.row)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "chooseMeme", sender: indexPath)
        
    }

  

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "chooseMeme" {
            let controller = segue.destination as! EditViewController
            controller.index = (sender as! IndexPath).row
        }
        
    }
    

}
