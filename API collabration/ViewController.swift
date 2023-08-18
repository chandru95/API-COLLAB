//
//  ViewController.swift
//  API collabration
//
//  Created by Admin on 17/08/23.
//

import UIKit



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    struct root1: Codable{
        let makeList: [String?]
    }

    struct root2: Codable{
        let modelList: [String?]
    }

    struct root3: Codable{
        let variantList: [String?]
    }

    struct root4: Codable{
        let locationList: [String?]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tap == 1{
            print("lion\(tap)")
            return year.count
            
        }
        else if tap == 2{
            print("tiger\(tap)")
            return jsondata1?.makeList.count ?? 0
        }
        else if tap == 3{
            print("elephant\(tap)")
            return jsondata2?.modelList.count ?? 0
        }
        else if tap == 4{
            return jsondata3?.variantList.count ?? 0
        }
        else if tap == 5{
            return jsondata4?.locationList.count ?? 0
        }
        return 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)
        
        
        if tap == 1 {
            cell.textLabel?.text = year[indexPath.row]
        }
        else if tap == 2 {
            cell.textLabel?.text = jsondata1?.makeList[indexPath.row]
        }
        else if tap == 3{
            cell.textLabel?.text = jsondata2?.modelList[indexPath.row]
        }
        else if tap == 3{
            cell.textLabel?.text = jsondata3?.variantList[indexPath.row]
        }
        else if tap == 4{
            cell.textLabel?.text = jsondata4?.locationList[indexPath.row]
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tap == 1 {
            print("chandru\(tap)")
            text1.text = year[indexPath.row]
            tableView.isHidden = true
        }
        
        else if tap == 2 {
            text2.text =  jsondata1?.makeList[indexPath.row]
            tableView.isHidden = true
            
        }
        else if tap == 3{
            text3.text = jsondata2?.modelList[indexPath.row]
            tableView.isHidden = true
        }
        else if tap == 4{
            text4.text = jsondata3?.variantList[indexPath.row]
            tableView.isHidden = true
        }
        else if tap == 5{
            text5.text = jsondata4?.locationList[indexPath.row]
            tableView.isHidden = true
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var text1: UITextField!
    
    @IBOutlet weak var text2: UITextField!
    
    
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var text4: UITextField!
    
    @IBOutlet weak var text5: UITextField!
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var tap : Int?
    var year = ["2001","2002","2003","2004","2005","2006","2020"]
    
    var jsondata1: root1? = nil
    var jsondata2: root2? = nil
    var jsondata3: root3? = nil
    var jsondata4: root4? = nil
    
    override func viewDidLoad() {
       // tableview.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func text1(_ sender: Any) {
        //tableview.isHidden = false
        tap = 1
        self.tableview.reloadData()
    }
    
    
    @IBAction func text2(_ sender: Any) {
        tableview.isHidden = false
        tap = 2
        make()
        self.tableview.reloadData()
    }
    
    
    @IBAction func text3(_ sender: Any) {
        tableview.isHidden = false
        tap = 3
        model()
    }
    
    
    @IBAction func text4(_ sender: Any) {
        tableview.isHidden = false
        tap = 4
        variant()
    }
    
    
    @IBAction func text5(_ sender: Any) {
        tableview.isHidden = false
        tap = 5
        location()
    }
    
    func make() {
        let url = "https://kuwycredit.in/servlet/rest/ltv/forecast/ltvMakes"
        let request = NSMutableURLRequest (url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue ("application/json",forHTTPHeaderField: "Content-Type")
        var params: [String: Any] = ["year":text1.text!]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = URLSession.shared.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print("status rode = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do {
                        let content = try? JSONDecoder().decode(root1.self, from: data)
                        self.jsondata1 = content
                        print (content as Any)
                        
                        DispatchQueue.main.async{
                            self.tableview.reloadData()
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            })
            task.resume()
        }catch _ {
            print("oops something happened buddy")
        }
            
            
    }
    
    func model() {
        let url = "https://kuwycredit.in/servlet/rest/ltv/forecast/ltvModels"
        let request = NSMutableURLRequest (url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue ("application/json",forHTTPHeaderField: "Content-Type")
        var params: [String: Any] = ["year":text1.text!,"make":text2.text!]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = URLSession.shared.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print("status rode = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do {
                        let content = try? JSONDecoder().decode(root2.self, from: data)
                        self.jsondata2 = content
                        print (content as Any)
                        
                        DispatchQueue.main.async{
                            self.tableview.reloadData()
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            })
            task.resume()
        }catch _ {
            print("oops something happened buddy")
        }
            
            
    }
    
    func variant() {
        let url = "https://kuwycredit.in/servlet/rest/ltv/forecast/ltvVariants"
        let request = NSMutableURLRequest (url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue ("application/json",forHTTPHeaderField: "Content-Type")
        var params: [String: Any] = ["year":text1.text!,"make":text2.text!,"model":text3.text!]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = URLSession.shared.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print("status rode = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do {
                        let content = try? JSONDecoder().decode(root3.self, from: data)
                        self.jsondata3 = content
                        print (content as Any)
                        
                        DispatchQueue.main.async{
                            self.tableview.reloadData()
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            })
            task.resume()
        }catch _ {
            print("oops something happened buddy")
        }
            
            
    }
    
    func location() {
        let url = "https://kuwycredit.in/servlet/rest/ltv/forecast/ltvLoc"
        let request = NSMutableURLRequest (url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue ("application/json",forHTTPHeaderField: "Content-Type")
        var params: [String: Any] = ["year":text1.text!,"make":text2.text!,"model":text3.text!,"variant":text4.text!]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = URLSession.shared.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print("status rode = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do {
                        let content = try? JSONDecoder().decode(root4.self, from: data)
                        self.jsondata4 = content
                        print (content as Any)
                        
                        DispatchQueue.main.async{
                            self.tableview.reloadData()
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            })
            task.resume()
        }catch _ {
            print("oops something happened buddy")
        }
            
            
    }

    }


    

