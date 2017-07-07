//
//  ViewController.swift
//  App2
//  AMFMTRANSMITTER APP
//  Created by Zachary Brooks on 9/27/16.
//  Copyright © 2016 uca. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    
    @IBOutlet private var label : UILabel!
    @IBOutlet private var playbutton : UIButton!
    @IBOutlet private var slider : UISlider!
    @IBOutlet private var volumeslider: UISlider!
    @IBOutlet private var segment : UISegmentedControl!
    @IBOutlet private var radioDisplay : UIImageView!
    @IBOutlet private var seekbutton : UIButton!
   
    private var segmentvalue : Int = 0
    private var volumevalue: Float = 0
    private var radiostation : Int = 0
    private var playtoggle : Int = 0
    private var player : AVPlayer?
    private var url: String = "http://provisioning.streamtheworld.com/pls/KLALFMAAC.pls"
    private var radiostationnames: [String] = [" ", "WABCAM" ,"KABCAM", "WBAPAM", "WLSAM","KARNAM","WPGPAM", "WXYTFM" , "KURBFM", "WKIMFM","WWTNFM", "KARNFM", "KLALFM"]
    private var radioslidervalue: [Float] = [0,84,89,96,104,110,140,97, 108,113,118,135,157]
    private var radiostationimage: [String] = [" ", "wabc.png" ,"kabc.png", "wbap.png", "wls.png","karnAM.png","wpgp.jpg", "wxyt.png" , "kurb.png", "wkim.png","wwtn.png", "karn.png", "klal.png"]
    var reachability = Reachability()

    //THIS FUNCTION WILL  CHECK FOR REACHABILITY AND DISPLAY ALERT IF NO INTERNET
    override func viewDidLoad() {
        super.viewDidLoad()
       if (reachability.isConnectedToNetwork() == false)
       {    var failure = "failure"
            var message = " dude wheres the wifi"
            var cancel = "sorry dude"
        
        var failing = UIAlertView(title: failure, message: message, delegate: nil, cancelButtonTitle: cancel)
        failing.show()
        }
        
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //THIS FUNCTION SETS THE STREAMING URL TO THE ONE OF THE RADIOSTATION NAME INDEX
    func setURL()
    {
        var rname = self.radiostationnames[self.radiostation]
        
       self.url = "http://provisioning.streamtheworld.com/pls/" + rname + "AAC.pls"
        
        print(self.url)
        
    }
    
    //THIS FUNCTION SETS THE RADIO DISPLAY IMAGE BY APPENDING THE NAME TO THE IMAGE FILE PATH
    func changedisplayimage()
    {
        
        var imagename = radiostationimage[self.radiostation]
       
        var img = UIImage (named: imagename)
        radioDisplay.image = img
        
        
    }
    
    //THIS FUNCTION CHANGES THE RADIO STATION, CALLED BY ACTION FUNCTIONS
    func changestation()
    {
        setURL()
        var newensurl = NSURL(string: self.url)
        var newplayeritem = AVPlayerItem(URL: newensurl!)
        player?.replaceCurrentItemWithPlayerItem(newplayeritem)
        
    }
    
    //THIS FUNCTION USES THE RADIOSTATION INT VALUE TO MAKE SEEKING POSSIBLE
    func seekstation(radiostation: Int)
    {   if (self.radiostation == 6 && self.segmentvalue != 1)
        {
        self.radiostation = 1
        self.slider.value = radioslidervalue[self.radiostation]
        changestation()
        changedisplayimage()
        return
        }
        if (self.radiostation == 12 && self.segmentvalue != 0 )
        {
            self.radiostation = 7
            self.slider.value = radioslidervalue[self.radiostation]
            changestation()
            changedisplayimage()
            return
        }
        else
        {self.slider.value = radioslidervalue[self.radiostation + 1]
        self.radiostation++
        changestation()
        changedisplayimage()
        print(self.radiostation)
        }
        
        
    }
    
    //THIS FUNCTION BEGINS PLAYING THROUGH AVPLAYER
    func letsplay(url:NSURL) {
        print("playing \(url)")
        
        
        do {
            
            var playerItem = AVPlayerItem(URL: url)
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = self.volumevalue
            
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AV AudioPlayer init failed")
        }
    }
    
    //THIS FUNCTION CONTROLS THE PLAYBUTTON AND WHAT IT DOES WHEN THE USER PRESSES IT
    @IBAction func pressplaybutton(playbutton: UIButton)
    {   if (reachability.isConnectedToNetwork() == true)
   
   {
    
        if(self.radiostation != 0)
        
            
        {
            
        var pauseimagename = "Pause-Normal-Red-icon.png"
        var pauseimage = UIImage(named: pauseimagename)
    
        
        var playimagename = "video-play-4-xl.png"
        var playimage = UIImage(named: playimagename )
        
        if(self.playtoggle == 0)
        {
            var ensurl = NSURL(string: self.url)

            self.letsplay(ensurl!)
           
            self.playbutton.setImage(pauseimage , forState: .Normal )
            self.playtoggle = 1
        }
        else if(self.playtoggle == 1)
        {
            self.player!.pause()
            self.playbutton.setImage(playimage, forState: .Normal )
            self.playtoggle = 0
        }
        
        
        }
    }
    }
    
    //THIS FUNCTION CONTROLS THE SEEK BUTTON USING THE SEEKSTATION METHOD
    @IBAction func seek(seekbutton: UIButton!)
    {if (reachability.isConnectedToNetwork() == true)
        
    {
        seekstation(self.radiostation)
        }
    }
    
    //THIS FUNCTION RESETS APP IF AM/FM IS TOGGLED
    @IBAction func changeband(segment: UISegmentedControl)
    {   self.segmentvalue = segment.selectedSegmentIndex
        self.volumeslider.value = 0
        self.radiostation = 6
        self.slider.value = 0
        self.player?.pause()
        var imagename = "launch.png"
        var img = UIImage (named: imagename)
        self.radioDisplay.image = img
        var playimagename = "video-play-4-xl.png"
        var playimage = UIImage(named: playimagename )
        self.playbutton.setImage(playimage , forState: .Normal)
        
    }
    
    //THIS FUNCTION ENABLES THE VOLUMESLIDER TO CONTROL VOLUME
    @IBAction func changeVolume(volumeslider: UISlider)
    {
        
        self.volumevalue = volumeslider.value
        
        if(self.radiostation != 0)
        {
        self.player?.volume = self.volumevalue
        
        }
        
    }
    
    //THIS FUNCTION ENABLES THE RADIOSLIDER
    @IBAction func radioSetter(slider : UISlider )
    {
        
        
        var value = slider.value
        
        
        
        //change radiostation if am
        
        if (segmentvalue == 0)
        {
            
            
               if (value > 82 && value < 86 )
        {   var previousstation = self.radiostation
            
            self.radiostation = 1
            
            
            if(previousstation != self.radiostation)
            {
            changestation()
            changedisplayimage()
            }
            
        }
            
            
            
        
        else if (value > 87 && value < 92)

        {    var previousstation = self.radiostation
            
            self.radiostation = 2
            if(previousstation != self.radiostation)
            {   changedisplayimage()
                changestation()
            }

        }

            
            
        
        else if (value > 94 && value < 99 )

        { var previousstation = self.radiostation
       
            self.radiostation = 3
        
            if(previousstation != self.radiostation)
            {   changedisplayimage()
                changestation()
                
            }
}
        
        
            
            
        
        else if (value > 101 && value < 106 )

        {    var previousstation = self.radiostation
            
            self.radiostation = 4
            if(previousstation != self.radiostation)
            {   changedisplayimage()
                changestation()
                
            }

        }

      
            
        else if (value > 107 && value < 112 )

        {    var previousstation = self.radiostation
            
            self.radiostation = 5
            if(previousstation != self.radiostation)
            {   changedisplayimage()
                changestation()
            }

        }
        
            
            
            
        else if (value > 138 && value < 143)
        {    var previousstation = self.radiostation
            
            self.radiostation = 6
            if(previousstation != self.radiostation)
            {   changedisplayimage()
                changestation()            }

            }
           
       
        }
        // if it is fm
        if (segmentvalue == 1)
            
            
        {
            
            

            
            if (value > 94 && value < 99 )
            {   var previousstation = self.radiostation
                
                self.radiostation = 7
                
                
                if(previousstation != self.radiostation)
                {
                    changestation()
                    changedisplayimage()
                }
            }
            
            else if (value > 105 && value < 109)
                
            {  var previousstation = self.radiostation
                
                self.radiostation = 8
                
                
                if(previousstation != self.radiostation)
                {
                    changestation()
                    changedisplayimage()
                    
                }
                

            }
            
            
            else if (value > 110 && value < 115 )
                
            {   var previousstation = self.radiostation
                
                self.radiostation = 9
                
                
                if(previousstation != self.radiostation)
                {
                    changestation()
                    changedisplayimage()

            }
            }
            
            
            else if (value > 116 && value < 121 )
                
            {   var previousstation = self.radiostation
                
                self.radiostation = 10
                
                
                if(previousstation != self.radiostation)
                {
                    changestation()
                    changedisplayimage()                }
                

            }
            
            
            
            else if (value > 132 && value < 137 )
                
            {  var previousstation = self.radiostation
                
                self.radiostation = 11
                
                
                if(previousstation != self.radiostation)
                {
                    changestation()
                    changedisplayimage()
                }
                

            }
            
            else if (value > 155 && value < 160)
            {  var previousstation = self.radiostation
                
                self.radiostation = 12
                
                
                if(previousstation != self.radiostation)
                {
                    changestation()
                    changedisplayimage()
                    
                }
                

            }
           
            
            
                   }
            

}
    
    }