//
//  DonorTableViewController.swift
//  QuizDonorDarah
//
//  Created by Jun  on 11/8/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class DonorTableViewController: UITableViewController {

    let DonorURL = "https://script.googleusercontent.com/macros/echo?user_content_key=R4kCEI8L5b8p1UJqgvrvR9FIvnMTSQb6Hjx9ljuCzWnN5V9GkQk04LH0S4gt_cHLSocF86mDIuCDKIlMkW5skQVqqRTXJIsuOJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuB6lHT6qnqYcmFWggwoSVQQXTsQ1HqKa1CgDXQROm1OeNR5ibYVAaRxAeOtzLmbRZcVjrce7Uveb8iU1s-L39A_CLDTUaq6azCNVhRMhi1rsPEMUK-CH6pys1RvMr_dgaGkoVsMt9XllB7kFByHUCzY&lib=M-tpZm-Fm1QX9Yr80nZn_p-WXe3zpGnI"
    
    var donorS = [Donor]()
    var nameSelected:String?
    var alamatSelected:String?
    var jamSelected:String?
    var recanaSelected:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDonor()
        
        //self sizing cells
        //set row height to 92
        tableView.estimatedRowHeight = 92.0
        //set row table height to automatic dimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return donorS.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DonorTableViewCell
        
        cell.lblname.text = donorS[indexPath.row].instansi
        cell.lblalamat.text = donorS[indexPath.row].alamat
        

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        let dataTask = donorS[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        nameSelected = dataTask.instansi
        alamatSelected = dataTask.alamat
        jamSelected = dataTask.jam
        recanaSelected = dataTask.rencana_donor
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "segue"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let sendData = segue.destination as! ViewController
            sendData.passname = nameSelected
            sendData.passjam = jamSelected
            sendData.passalamat = alamatSelected
            sendData.passrencana = recanaSelected
            
        }
    }
    //MARK : - JSON Parsing
    //create new method with name : getLatestLoans()
    func getDonor() {
        guard let Donorurl = URL(string: DonorURL) else {
            return //this return is for back up the value that got when call variable loanURL
        }
        
        //declare request for request URL loanUrl
        let request = URLRequest(url: Donorurl)
        //declare task for take data from variable request above
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //check what error is available or not
            if let error = error {
                //condition when error
                //print error
                print(error)
                return //back up value error that we get
            }
            //parse JSON data
            //declare variable data to call data
            if let data = data {
                //for this part will call method parseJsonData that we will make in below
                self.donorS = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation({
                    //reload data again
                    self.tableView.reloadData()
                })
            }
        })
        //task will resume to call the json data
        task.resume()
    }
    //create new method with name ParseJsonData
    //this method will parsing data Json
    func parseJsonData(data: Data) -> [Donor] {
        //declare variable loans as object from loans class
        var Donorss = [Donor]()
        //will repeat to json data that parsed
        do{
            //declare jsonResult for take data from the json
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
           
            
            //parse json data
            //declare jsonLoans for call data array jsonResult with name Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //will call data be repeated for jsonLoan have data json array from variable jsonLoans
            for jsonLoan in jsonLoans {
                //declare loan as object from class loan
                let dOnor = Donor()
                //enter the value to each object from class loan
                dOnor.instansi = jsonLoan["instansi"] as! String
                dOnor.alamat = jsonLoan["alamat"] as! String
                dOnor.jam = jsonLoan["jam"] as! String
                dOnor.rencana_donor = jsonLoan["rencana_donor"] as! String
                //process enter data to object
                Donorss.append(dOnor)
            }
        }catch{
            print(error)
        }
        return donorS
        
    }
}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


