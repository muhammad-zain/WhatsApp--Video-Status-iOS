//
//  QuoteListViewController.swift
//  Motivation
//
//  Created by Zain Sidhu on 25/09/2021.
//

import UIKit

class VideoListViewController: BaseViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
//    var quotes : [QuoteModel] = []
    var cellIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)

        self.tableView.contentInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.size.height * -1, left: 0, bottom: 0, right: 0)
        self.tableView.backgroundColor = .clear
        
        
//        self.quotes = QuoteManager.shared.getAllQuotes()
        self.tableView.reloadData()
        

    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}

extension VideoListViewController : UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
}

//extension VideoListViewController: TableViewCellDelegate {
//    func singleTapDetected(in cell: QuoteTableViewCell)  {
//        if let indexPath = tableView.indexPath(for: cell) {
//            tableView.scrollToRow(at: IndexPath(row: indexPath.row +  1, section: indexPath.section), at: .top, animated: true)
//        }
//    }
//    func doubleTapDetected(in cell: QuoteTableViewCell) {
//        cell.btnLikeTapped("")
//    }
//
//    func longTapDetected(in cell: QuoteTableViewCell) {
//        AppManager.shared.vibrate()
//        print("Long Tapped")
//    }
//}


