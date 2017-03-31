//
//  WeatherDetailViewController.swift
//  myWeather
//
//  Created by Abhir Vaidya on 29/03/17.
//  Copyright © 2017 Abhir Vaidya. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var city : String?
    var weatherConditionsArray : [Weather?] = []
    var pageController: UIPageViewController?
    
    let pages = ["PagesContentController1", "PagesContentController2"]
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.black
        
        
        //Make Call to Weather API on background thread
        DispatchQueue.global(qos: .background).async {
            
            guard self.city != nil else{
                return
            }
            WebServiceClient.sharedInstance.weather(city: self.city!, completion: { (weatherData : WeatherResult) in
            
            switch weatherData{
            case .success(let current, let weatherArray) :
                
                //Push result on main thread
                DispatchQueue.main.async {
                    // qos' default value is ´DispatchQoS.QoSClass.default`
                    let vc = self.viewControllers?.first as? WeatherContentDetailPageViewController
                    vc!.currentCondition = current
                    vc!.currentCity =  self.city
                    vc!.updateUI()
                    self.weatherConditionsArray = weatherArray
            }
            case .failure(let err) :
                
                //TODO: Show Alert with for error
                print(err)
                // create the alert
                let alert = UIAlertController(title: "Alert", message: "No City Found, Enter Valid city Name", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            
            }
         })
          
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PagesContentController1")
        
        setViewControllers([vc!],
            direction: .forward,
            animated: true,
            completion: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            }
            else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    
    // MARK: Page View Controller Delegate Methods
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index > 0 {
                    return self.storyboard?.instantiateViewController(withIdentifier: pages[index-1])
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index < pages.count - 1 {
                    let vc1 = self.storyboard?.instantiateViewController(withIdentifier: pages[index+1]) as? weeklyWeatherDetailPageViewController
                    vc1!.weatherConditionsArray = self.weatherConditionsArray
                    return vc1
                }
            }
        }
        return nil
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let identifier = viewControllers?.first?.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                return index
            }
        }
        return 0
    }
    
    //MARK: Helper Methods
    func getCurrentWeatherDetails() -> [Weather?]{
        return self.weatherConditionsArray
    }
    
}
