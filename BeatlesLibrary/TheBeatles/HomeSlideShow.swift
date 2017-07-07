//ZAC BROOKS
//HOME SLIDE SHOW VIEW CONTROLLER


import UIKit
import AVFoundation

class HomeSlideShow : UIViewController {
    
    
    
    @IBOutlet private var albumArtwork: UIImageView!
    private var images : [UIImage]!
    @IBOutlet var theBeatles: UILabel!
    
    let abbeyroad = UIImage (named: "abbeyRoad.jpg")
    let beatlesForSale = UIImage (named: "BeatlesForSale.jpg")
    let HardDaysNight = UIImage (named: "HardDaysNight.jpg")
    let help = UIImage (named: "help.jpg")
    let intro = UIImage (named: "intro.jpg")
    let letitbe = UIImage (named: "letitbe.jpg")
    let MagicalMysteryTour = UIImage (named: "MagicalMysteryTour.jpg")
    let PastMastersVolume1 = UIImage (named: "PastMastersVolume1.jpg")
    let PastMastersVolume2 = UIImage (named: "PastMastersVolume2.jpg")
    let pleasePleaseMe = UIImage (named: "pleasePleaseMe.jpg")
    let revolver = UIImage (named: "revolver.jpg")
    let rubberSoul = UIImage (named: "rubberSoul.jpg")
    let sgt_pepper = UIImage (named: "sgt_pepper.jpg")
    let white = UIImage (named: "white.jpg")
    let WithTheBeatles = UIImage (named: "WithTheBeatles.jpg")
    let Yellowsubmarine = UIImage (named: "Yellowsubmarine.jpg")
    
    
    func  setArtwork(){
        
        images = [UIImage]()
        images.append(abbeyroad!)
        images.append(beatlesForSale!)
        images.append(HardDaysNight!)
        images.append(help!)
        images.append(intro!)
        images.append(letitbe!)
        images.append(MagicalMysteryTour!)
        images.append(PastMastersVolume1!)
        images.append(PastMastersVolume2!)
        images.append(pleasePleaseMe!)
        images.append(revolver!)
        images.append(rubberSoul!)
        images.append(white!)
        images.append(WithTheBeatles!)
        images.append(Yellowsubmarine!)
        images.append(sgt_pepper!)
        
        albumArtwork.animationImages = images
        albumArtwork.animationDuration = Double(images.count)
        albumArtwork.animationRepeatCount = 0
        albumArtwork.startAnimating()
        
        
    }
    
    
    override func viewDidLoad() {
        setArtwork()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}