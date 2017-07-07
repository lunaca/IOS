//
//  ContactInfo.swift
//  TableViewExample
//
//  Created by LUNVCA on 10/20/16.
//  Copyright © 2016 uca. All rights reserved.
//

import UIKit

class AlbumView: UITableViewController {
    
    var dictionary = NSBundle.mainBundle().pathForResource("albums", ofType: "plist")
    var mainrows = 0;
    var albumkeyarray = [String]()
    var producerarray = [String]()
    var datereleasedarray  = [String]()
    var imagenamearray = [String]()
    var i = 0;
    var sentindex  = 0 ;
    var plistnamearray = [String]()
    var sentfilename : String?
    
    override func viewDidLoad() {
    
        
        
        super.viewDidLoad()
        var albums = NSDictionary(contentsOfFile: dictionary!)
        self.mainrows = albums!.count
   
        
        
        //now we will parse the dictionary for easy use with the tableview
         for (key, value) in albums! {
            
        albumkeyarray.append(key as! String)
        var plistname = key.stringByReplacingOccurrencesOfString( " " ,  withString: "_")  
        plistnamearray.append(plistname)
        var valuesplitarray = value.componentsSeparatedByString("|")
        
        var  producername : String = valuesplitarray[0]
        producerarray.append(producername)
        
        
        var albumdate: String = valuesplitarray[1]
        datereleasedarray.append(albumdate)
        
        var imagename : String = valuesplitarray[2]
        
        imagenamearray.append(imagename)
        
        
            
     //   print("Key: \(key) - Value: \(value)")
        valuesplitarray.removeAll()
        }
        dump(albumkeyarray)
        dump(producerarray)
        dump(datereleasedarray)
        dump(imagenamearray)
        dump(plistnamearray)
        
        
        
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
        performSegueWithIdentifier( "toTheSongs", sender: indexPath)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
       
       
      
        cell.textLabel?.text = albumkeyarray[indexPath.row]
        cell.detailTextLabel?.text = datereleasedarray[indexPath.row]
        cell.imageView?.image = UIImage(named: imagenamearray[indexPath.row])
        // Configure the cell...
        
        return cell
    }
    
        
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "toTheSongs") {
            print(self.sentindex)
            var yourNextViewController = (segue.destinationViewController as! SongsView)
            yourNextViewController.sentindex = self.sentindex
            self.sentfilename = plistnamearray[self.sentindex]
            yourNextViewController.sentfilename = self.sentfilename
            
        
     // Pass the selected object to the new view controller.
        
    
     }
    
    
}
}
