    //
    //  ViewController.swift
    //  myWeather
    //
    //  Created by Abhir Vaidya on 29/03/17.
    //  Copyright © 2017 Abhir Vaidya. All rights reserved.
    //

    import UIKit

    class ViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {

        @IBOutlet weak var citySearch: UISearchBar!
        var cityNameArray = [String] ()
        

        @IBOutlet weak var cityTableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            citySearch.text = ""
            
            //MARK: Get Recent City Search from UserDefaults
            guard (UserDefaults.standard.object(forKey: "CityNames") as? Array<Any>) != nil
                else {
                    return
            }
            cityNameArray = UserDefaults.standard.object(forKey: "CityNames") as! [String]
            cityTableView.reloadData()
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        //MARK: Search Bar Delegate Method
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "weatherDetailID") as? WeatherDetailViewController
            vc!.city = searchBar.text!
            self.savetoUserDefault(city: searchBar.text!)
            self.navigationController?.pushViewController(vc!,
                                                     animated: true)
        }


        
        
        //MARK: TableView Delegate Methods
        let cellReuseIdentifier = "customCityCell"

        // number of rows in table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cityNameArray.count
        }
        
        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:CityCustomCell = cityTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CityCustomCell
            let object = cityNameArray[indexPath.row] as String
            cell.cityLabel?.text = object
            return cell
        }
        
        // method to run when table view cell is tapped
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
            let object = cityNameArray[indexPath.row] as String
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "weatherDetailID") as? WeatherDetailViewController
            vc!.city = object
            self.navigationController?.pushViewController(vc!,
                                                          animated: true)

            
        }

    }

    extension ViewController{
        
        //MARK: City Name persisted in User Defaults
        func savetoUserDefault(city : String)  {
            let defaults = UserDefaults.standard
            
            if var array =  defaults.object(forKey: "CityNames") as? Array<Any>{
                array.append(city)
                defaults.set(array, forKey: "CityNames")
                defaults.synchronize()
            }
            else{
                var cityArray : [String] = []
                cityArray.append(city)
                defaults.set(cityArray, forKey: "CityNames")
                defaults.synchronize()

            }
           
        }
    }
