//
//  SnapVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import ImageSlideshow
import ImageSlideshowSDWebImage

class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var selectedSnap : SnapModel?
    
    var inputArray = [SDWebImageSource]()
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = "Time Left: \(selectedSnap?.timeDifferenge ?? 0)"
        
        
        if let snap  = selectedSnap {
            for imageUrl in snap.imageArray{
                inputArray.append(SDWebImageSource(urlString: imageUrl)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.7))
            
          let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = .black
            
            imageSlideShow.pageIndicator = pageIndicator
            imageSlideShow.backgroundColor = UIColor.white
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
        }
    }
    



}
