//
//  ConsultViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 05.08.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar

class ConsultViewController: UIViewController
{

    var progressBar: FlexibleSteppedProgressBar!
    
    @IBOutlet weak var view3: UIStackView!
    @IBOutlet weak var view2: UIStackView!
    @IBOutlet weak var view1: UIStackView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var view4: UIStackView!
    
    var dimension = 50
    var level = 4
    var currentLevel = 0
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 50 / 2
        prevButton.layer.cornerRadius = 50 / 2
        configureProgressbar()
        
    }
    
  
    
    @IBAction func nextButtonTapped(_ sender: Any)
    {
        currentLevel = (currentLevel + 1) > 3 ? currentLevel : currentLevel + 1
        progressBar.currentIndex = (currentLevel)%level
        
        navigate(index:currentLevel)
    }
    @IBAction func prevButtonTapped(_ sender: Any)
    {
        currentLevel = (currentLevel - 1) < 0 ? currentLevel : currentLevel - 1
        progressBar.currentIndex = currentLevel
        navigate(index:currentLevel)
    }
    func configureProgressbar()
    {
          progressBar = FlexibleSteppedProgressBar()
          view.addSubview(progressBar)
        
        // Progressbar Constraints
          progressBar.translatesAutoresizingMaskIntoConstraints = false
          progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
          progressBar.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
          progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          progressBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
          

          // Customise the progress bar here
          progressBar.numberOfPoints = level
          progressBar.lineHeight = 9
          progressBar.radius = 15
          progressBar.progressRadius = 50
          progressBar.progressLineHeight = 3
          progressBar.selectedBackgoundColor = .blue
          progressBar.completedTillIndex = 3
          progressBar.centerLayerTextColor = .black // couleur de tout les elements de la barre
          progressBar.currentSelectedTextColor = .white
         
          progressBar.currentSelectedCenterColor = .black // couleur du centre de l'element actuelle
          progressBar.selectedOuterCircleStrokeColor = .systemBlue
          progressBar.selectedOuterCircleLineWidth = 5
          
          
        
          progressBar.delegate = self
    }
    func gotoOne()
    {
         view1.alpha = 1
         view2.alpha = 0
         view3.alpha = 0
         view4.alpha = 0
    }
    func gotoTwo()
    {
         view1.alpha = 0
         view2.alpha = 1
         view3.alpha = 0
         view4.alpha = 0
    }
    func gotoThree()
    {
         view1.alpha = 0
         view2.alpha = 0
         view3.alpha = 1
         view4.alpha = 0
    }
    func gotoFour()
    {
         view1.alpha = 0
         view2.alpha = 0
         view3.alpha = 0
         view4.alpha = 1
    }

    func navigate(index : Int)
    {
        switch index {
        case 0:
            gotoOne()
        case 1 :
            gotoTwo()
        case 2 :
            gotoThree()
        case 3 :
            gotoFour()
        default:
            gotoOne()
        }
    }

}



extension ConsultViewController : FlexibleSteppedProgressBarDelegate
{
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                 didSelectItemAtIndex index: Int) {
        progressBar.currentIndex = index
        
        switch index {
        case 0:
            gotoOne()
        case 1 :
            gotoTwo()
        case 2 :
            gotoThree()
        case 3 :
            gotoFour()
        default:
            gotoOne()
        }
        
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                 willSelectItemAtIndex index: Int) {
       
    }

    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     canSelectItemAtIndex index: Int) -> Bool {
        return true
    }

    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        if position == FlexibleSteppedProgressBarTextLocation.center{
            
            return "\(index)"
        }
    return ""
    }


}
