//
//  ControlLibros.swift
//  BuscadorLibros
//
//  Created by AlexGarcia on 8/16/16.
//  Copyright © 2016 AlexGarcia. All rights reserved.
//

import UIKit

class ControlLibros: UIViewController {

    var isbn = ""
    
    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var autoresLbl: UITextView!
    @IBOutlet weak var portdaImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
        let url = NSURL(string: urls)
        
        let datos : NSData? = NSData(contentsOfURL: url!)
        
        //print(datos)
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dico1 = json as! NSDictionary
            
            let dico2 = dico1["ISBN:" + isbn] as! NSDictionary
            
            tituloLbl.text = dico2["title"] as? String
            
            let autoresArray = dico2["authors"] as! NSArray
            //print("cant: \(autoresArray.count)")
            var s = ""
            for a in autoresArray {
                let autor = a["name"] as! String
                s = s + "\n" + autor
                //print("autor:" + autor)
            }
            autoresLbl.text = s
            
            let dico3 = dico2["cover"] as? NSDictionary
            //print("dico3: \(dico3)")
            if dico3 != nil {
                
                var c1 = ""
                
                if dico3!["large"] != nil {
                    c1 = dico3!["large"] as! String
                    print("large: " + c1)
                }
                else if dico3!["medium"] != nil {
                    c1 = dico3!["medium"] as! String
                    print("medium: " + c1)
                }
                else if dico3!["small"] != nil {
                    c1 = dico3!["small"] as! String
                    print("small: " + c1)
                }
                
                let urlCover = NSURL(string: c1)
                if urlCover != nil {
                    let dataCover : NSData? = NSData(contentsOfURL: urlCover!)
                    portdaImg.hidden = false
                    portdaImg.image = UIImage(data: dataCover!)
                }
                else {
                    portdaImg.hidden = true
                }
            }
            else {
                portdaImg.hidden = true
            }
            //print("Titulo: \(tituloLbl.text!)")
            //print("Titulo: \(autoresLbl.text!)")
        }
        catch _ {
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
