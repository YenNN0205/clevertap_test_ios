//
//  ViewController.swift
//  clevertap-test
//
//  Created by Yên Nguyễn on 07/03/2023.
//

import UIKit
import CleverTapSDK

class ViewController: UIViewController {

    var num = 0;
    var numUserProfile = 0;

    @IBOutlet weak var txtUsrProfile: UITextField!
    @IBOutlet weak var btnUserUpload: UIButton!
    
    
    @IBOutlet weak var txtNum: UITextField!
    @IBOutlet weak var btnCallF: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func handleUserUpload(_ sender: UIButton) {
        
        let profile: Dictionary<String, Any> = [
            //Update pre-defined profile properties
            "identity": 9084,
            "Name": "YenNN",
            "Email": "yennn1322@31cinnovation.com",
            "Phone": "+84355322422",
            "DOB": "$D_-1164921064",
            "Gender": "M",
            "MSG-email": true,
            "MSG-sms": true,
            "MSG-push": true,
            "MSG-whatsapp": true,
                  
        ]
        CleverTap.sharedInstance()?.onUserLogin(profile)
        numUserProfile=numUserProfile+1
        loadData()
      
    }
    
    func getJson() {
        
        let urlString = "http://103.157.218.115/CleverTap/hs/CleverTap/V1/UserProfile"

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {

                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                    for item in parsedData
                    {
                        let id = item["Email"] as! String
                        print(id)
                    }

                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }

            }.resume()
    }
                                           
    
    func loadData(){
        txtNum.text = String(num)
        txtUsrProfile.text = String(numUserProfile)
    }

  
    @IBAction func btnClicked(_ sender: UIButton) {
        recordUserChargedEvent()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation,

    fromLocation oldLocation: CLLocation) {

    CleverTap.setLocation(newLocation.coordinate)

    }
    
    func recordUserChargedEvent() {
  
        //charged event
        let chargeDetails = [
            "Amount": 999,
            "Payment mode": "Test",
            "Charged ID": 24052013
        ] as [String : Any]
        
        let item1 = [
            "Category": "books",
            "Book name": "The Millionaire next door",
            "Quantity": 1
        ] as [String : Any]
        
        let item2 = [
            "Category": "books",
            "Book name": "Achieving inner zen",
            "Quantity": 1
        ] as [String : Any]
        
        let item3 = [
            "Category": "books",
            "Book name": "Chuck it, let's do it",
            "Quantity": 5
        ] as [String : Any]
        
        CleverTap.sharedInstance()?.recordChargedEvent(withDetails: chargeDetails, andItems: [item1, item2, item3])
        CleverTap.setLocation(CLLocationCoordinate2D(latitude: 10.781871940976819,  longitude: 106.68293268465969))
        CleverTap.sharedInstance()?.recordEvent("Button Pressed")
        CleverTap.sharedInstance()?.enableDeviceNetworkInfoReporting(true)
    }
}

