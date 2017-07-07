//
//  VideoViewController.swift
//  TheBeatles
//
//  Created by LUNVCA on 11/8/16.
//  Copyright © 2016 uca. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    
    var sentsongname : String?
    var sentindex : Int?
    
    @IBOutlet var video: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        //Declare a ViewController so it implements UIWebViewDelegate  protocol in .h:
        
        //class ViewController: UIViewController,UIWebViewDelegate
        
        //	In viewDidLoad, store URL as String* :
        
        //
        //    var url_string = "http://www.uca.edu"
        //
        //    //Create a NSURL object from the URL string:
        //
        //    var nsurl = NSURL(string: url_string)
        //
        //    //Create a NSURLRequest object from the NSURL object:
        //
        //    var nsurl_request = NSURLRequest(URL: nsurl!)
        //
        //    //The UIWebView can then load the webpage using the NSURLRequest object:
        //
        //    self.video.loadRequest(nsurl_request)
        //    return
        
        var song : String = self.sentsongname!
        song = song.stringByReplacingOccurrencesOfString(" ", withString: "+")
        var origSong = self.sentsongname
        
        //Set the artist
        var artist = "The Beatles"
        artist = artist.stringByReplacingOccurrencesOfString(" ", withString: "+")
        var origArtist = "The Beatles"
        
        //Encode search for YouTube
        let keywords = "\(artist)+\(song)"
        let max = 50
        
        //Set the youtube search
        let string = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(keywords)&order=viewCount&maxResults=\(max)&type=video&videoCategory=Music&key=AIzaSyAJiIwkPJA1F7Xmy_jZobS0KRYA2ystamE"
        
        let url = (NSURL(string: string))
        let request = NSURLRequest(URL: url!)
        
        let responseData = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
        
        let result = NSString(data: responseData!, encoding:NSUTF8StringEncoding)
        print(result!)
        
        var titles : [String] = [String]()
        var videoIDs : [String] = [String]()
        
        
        if let json: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary
        {
            //Process the JSON structure below:
            if let items = json["items"] as? NSArray
            {
                for item in items
                {
                    // construct your model objects here
                    //Get the title
                    //Get the videoID
                    let videoIDDict = item["id"] as! NSDictionary
                    print(videoIDDict)
                    let videoID = videoIDDict["videoId"] as? String
                    print(videoID)
                    
                    //Get the title of the video
                    let snippetDict = item["snippet"] as! NSDictionary
                    let title1 = snippetDict["title"] as? String
                    print(title)
                    
                    //Set the data
                    titles.append(title1!)
                    videoIDs.append(videoID!)
                }
            }
        }
        
        
        let playURL = "https://www.youtube.com/watch?v=\(videoIDs[12])"
        var result1 = titles[12].lowercaseString.rangeOfString("please please me")
        print (result1);
        
        //Generate NSURL from NSString
        
        let videoURL = NSURL(string: playURL)
        
        
        //Generate NSURLRequest from NSURL
        
        let videoRequest = NSURLRequest(URL: videoURL!)
        
        
        
        //Play the video in UIWebView
        self.video.loadRequest(videoRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
