//
//  InternetsViewController.swift
//  test
//
//  Created by Sergio Yáñez on 4/22/19.
//

import UIKit


class InternetsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.pixan.io/")
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    self.webView.loadRequest(request)
                } else {
                    AlertMessages.createMessage("Error: \(error)", in: self)
                }
            }
            task.resume()
        }
    }
    
    @IBAction func refreshPageActionBtn(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    @IBAction func goBackActionBtn(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func goForwardActionBtn(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



