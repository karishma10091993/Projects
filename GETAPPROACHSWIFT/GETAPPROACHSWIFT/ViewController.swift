//
//  ViewController.swift
//  GETAPPROACHSWIFT
//
//  Created by kireeti on 22/10/18.
//  Copyright © 2018 KireetiSoftSolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet var collectionView: UICollectionView!
     var data1 = [[String: Any]]()
    var summaryArr = NSArray()
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getMethodWithDictionary2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getMethodWithDictionary2() {
        //  BASE URL URL
        let urlString =  "https://punjabstore.co.in/magento2.2/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=2&searchCriteria[filter_groups][1][filters][0][field]=visibility&searchCriteria[filter_groups][1][filters][0][value]=4&searchCriteria[currentPage]=0&searchCriteria[pageSize]=42"
        let url = URL.init(string: urlString)
        var  urlReq = URLRequest.init(url: url!)
        urlReq.httpMethod = "GET"
        let urlSession = URLSession.init(configuration: .default)
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
          // print(data!)
       do {
                let JSONData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                //print("JSON RESPONSE:",JSONData)
                DispatchQueue.main.sync {
                let items = JSONData["items"] as! [[String : AnyObject]]
                   // print("items",items)
               self.data1.append(contentsOf: items)
                   // print("data1",self.data1)
               }
        
        if self.data1.count > 0 {
                    self.collectionView?.reloadData()
                }
        }catch {
                print(error)
            }
            }
            .resume()
    }
 //collection ViewData
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.data1.count)
        return self.data1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let dict =  self.data1[indexPath.row]
        //print("Dict------------>",dict)
        
        let name = self.data1[indexPath.row]["name"]
        print("name",name)
        let price = dict["price"] as! Int
        let priceData = String(describing:  price)
        let customAttr = (dict["custom_attributes"])!
        var ind = 3
        var b = String()
        //        if data1.count > 0 {
        //if (ind > 0 && ind <= 3) {
        var val = (customAttr as AnyObject).value(forKey: "value") as! [Any]
        //var a = val.removeFirst()
        //        b = val[3] as! String
        //        }
        //}
        print("------------",b)
        //  print("Values Of---->",val)
        
        //print("Dict------------>",customAttr)
        
        
        cell.nameLbl.text = name as! String
        cell.priceLbl.text = priceData
        cell.img.image = UIImage.init(named: "Logo.jpg")
        return cell
    }

}

//extension Array {
//
//    mutating func remove(at indexs: [Int]) {
//        guard !isEmpty else { return }
//        let newIndexs = Set(indexs).sorted(by: >)
//        newIndexs.forEach {
//            guard $0 < count, $0 >= 0 else { return }
//            remove(at: $0)
//        }
//    }
//
//}
extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
