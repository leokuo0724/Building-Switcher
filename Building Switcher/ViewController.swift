//
//  ViewController.swift
//  Building Switcher
//
//  Created by 郭家銘 on 2020/11/20.
//

import UIKit

let tileName: Array<String> = [
    "1x1", "2x1", "2x2"
]
let buildingTwName: Array<String> = [
    "台南赤崁樓", "成大榕園", "花蓮慶修院", "台南林百貨", "台南安平古堡", "東京中目黑星巴克", "台北國父紀念館"
]
let gradientSet: Array<Array<Array<CGFloat>>> = [
    [[255/255, 184/255, 140/255], [222/255, 98/255, 98/255]],
    [[189/255, 195/255, 199/255], [44/255, 62/255, 80/255]],
    [[248/255, 255/255, 174/255], [67/255, 198/255, 172/255]],
    [[250/255, 255/255, 209/255], [161/255, 255/255, 206/255]],
    [[116/255, 116/255, 191/255], [52/255, 138/255, 199/255]]
]

class UserData {
    var tileIndex: Int = 0
    var buildingIndex: Int = 0
    var bgIndex: Int = 0
}

class ViewController: UIViewController {
    
    @IBOutlet weak var buildingStepper: UIStepper!
    @IBOutlet weak var gradientStepper: UIStepper!
    @IBOutlet weak var tileContainer: UIView!
    @IBOutlet weak var buildingContainer: UIView!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var gradientBg: UIView!
    
    
    let userData = UserData()
    let gradiBGLayer = CAGradientLayer()
    
    var isShow: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定 Stepper min max
        buildingStepper.minimumValue = 0
        buildingStepper.value = 0
        buildingStepper.maximumValue = Double(buildingTwName.count - 1)
        gradientStepper.minimumValue = 0
        gradientStepper.value = 0
        gradientStepper.maximumValue = Double(gradientSet.count - 1)
        
        // 設定漸層背景
        gradiBGLayer.frame = gradientBg.bounds
        gradientBg.layer.insertSublayer(gradiBGLayer, at: 0)
        
        setBuildingView()
    }
    
    
    @IBAction func changeTile(_ sender: UISegmentedControl) {
        userData.tileIndex = sender.selectedSegmentIndex
        setBuildingView()
    }
    
    @IBAction func changeBuilding(_ sender: UIStepper) {
        userData.buildingIndex = Int(sender.value)
        setBuildingView()
    }
    
    @IBAction func changeBg(_ sender: UIStepper) {
        userData.bgIndex = Int(sender.value)
        setBuildingView()
    }
    
    @IBOutlet weak var tileScrollView: UIScrollView!
    @IBOutlet weak var buildingScrollView: UIScrollView!
    @IBAction func buildingViewControl(_ sender: Any) {
        if !isShow {
            print(self.tileScrollView.frame.origin.y)
            print(self.buildingScrollView.frame.origin.y)
            isShow = true
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.gradientBg.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                self.gradiBGLayer.frame = self.gradientBg.bounds
                self.tileScrollView.frame.origin.y = (UIScreen.main.bounds.height - self.tileScrollView.frame.height) / 2
                self.buildingScrollView.frame.origin.y = (UIScreen.main.bounds.height - self.buildingScrollView.frame.height) / 2
            }
        } else {
            isShow = false
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.gradientBg.frame = CGRect(x: 0, y: 0, width: 414, height: 411)
                self.gradiBGLayer.frame = self.gradientBg.bounds
                self.tileScrollView.frame.origin.y = 80
                self.buildingScrollView.frame.origin.y = 80
            }
        }
    }
    
    func setBuildingView() {
        // 設定 tile 滑動
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
            self.tileContainer.frame.origin.x = CGFloat(-(self.userData.tileIndex) * 414)
        }
        
        // 設定 building 滑動
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
            self.buildingContainer.frame.origin.x = CGFloat(-(self.userData.buildingIndex) * 414)
        }
        
        // 設定 label text
        buildingLabel.text = buildingTwName[self.userData.buildingIndex]
        
        // 設定背景漸層色
        gradiBGLayer.colors = [
            CGColor(srgbRed: gradientSet[self.userData.bgIndex][0][0], green: gradientSet[self.userData.bgIndex][0][1], blue: gradientSet[self.userData.bgIndex][0][2], alpha: 1),
            CGColor(srgbRed: gradientSet[self.userData.bgIndex][1][0], green: gradientSet[self.userData.bgIndex][1][1], blue: gradientSet[self.userData.bgIndex][1][2], alpha: 1)
         ]
    }
    
}

