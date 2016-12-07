//
//  LightsViewController.swift
//  HueHomeKit
//
//  Created by Saleem Sangi on 12/6/16.
//
//

import UIKit

class LightsViewController: UIViewController {

    let colors = [65535, 40000, 20000, 30000,10000]
    var buttonIndex = 0
    
    @IBAction func OnOffSwitchPressed(_ sender: UISwitch) {
        changeLightState(on:sender.isOn)
    }

    
    private func changeLightState(on:Bool){
        let url = URL(string: "http://10.0.1.4/api/tT7tsDOHEB4XRyqiK0gR551A10ZIcU8gU2IGNNgB/lights/1/state")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
        let data = ["on":on]
         do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            request.httpBody = jsonData

         } catch {
            print("JSON Processing Failed")
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
            }.resume()
    }
    
    @IBAction func switchColorBtn(_ sender: UIButton) {
        
        let url = URL(string: "http://10.0.1.4/api/tT7tsDOHEB4XRyqiK0gR551A10ZIcU8gU2IGNNgB/lights/1/state")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
        
        let data = ["on":true, "sat":254, "bri":254, "hue":colors[buttonIndex]] as [String : Any]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            request.httpBody = jsonData
            
        } catch {
            print("JSON Processing Failed")
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
            self.buttonIndex+=1

            if self.buttonIndex == self.colors.count{
                self.buttonIndex = 0
            }
            }.resume()

    }
    
}
