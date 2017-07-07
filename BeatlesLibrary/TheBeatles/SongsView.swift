//
//  SongsView.swift
//  TheBeatles
//
//  Created by LUNVCA on 11/2/16.
//  Copyright © 2016 uca. All rights reserved.
//

import UIKit

class SongsView: UITableViewController {

    
    
        var  sentindex : Int!
        var sentfilename : String!
       var dictionary : NSDictionary?
        var mainrows = 0;
        var songkeyarray = [String]()
        var i = 0;
        var artistnamearray = [String]()
    var sentsongname : String?
    
        override func viewDidLoad() {
            
            
            
            super.viewDidLoad()
          self.sentfilename = self.sentfilename! + "_songs"
          //  print(sentfilename)
             var dictionary = NSBundle.mainBundle().pathForResource(sentfilename , ofType: "plist")
            var albums = NSDictionary(contentsOfFile: dictionary!)
            self.mainrows = albums!.count
            
           
            
            //now we will parse the dictionary for easy use with the tableview
            for (key, value) in albums! {
                
         
                songkeyarray.append(key as! String)
                artistnamearray.append(value as! String)

                
               
            }
            dump(songkeyarray)
            
            dump(artistnamearray)
            
            
            
            //   print(mainrows)
            //   print(albums!.allKeys)
            //print("\n\n")
            //print(albums!.allValues)
            //  print(albums!.count)
            // print(albums!.objectForKey("ABBEY ROAD")!)
            
            
            
            
            
            super.viewDidLoad()
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return mainrows
        }
        
        override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            print("You selected cell number: \(indexPath.row)!")
            
            
            print (indexPath.row)
            self.sentindex = indexPath.row
            self.sentsongname = songkeyarray[indexPath.row]
            performSegueWithIdentifier( "videoview", sender: indexPath)
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Song" , forIndexPath: indexPath)
            
            
            
            cell.textLabel?.text = songkeyarray[indexPath.row]
            cell.detailTextLabel?.text = artistnamearray[indexPath.row]
           
            // Configure the cell...
            
            return cell
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "videoview") {
            print(self.sentindex)
            var yourNextViewController = (segue.destinationViewController as! VideoViewController)
            yourNextViewController.sentindex = self.sentindex
          
            yourNextViewController.sentsongname = self.sentsongname
            

}
}
}