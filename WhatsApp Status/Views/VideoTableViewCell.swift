//
//  VideoTableViewCell.swift
//  Motivation
//
//  Created by Zain Sidhu on 25/09/2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell, MultiTappable {
    
    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var imgHeartHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgHeartWidthConstraint: NSLayoutConstraint!
    
    var onShare: (()->Void)?
    
    
    weak var multiTapDelegate: MultiTappableDelegate?
    lazy var tapCounter = ThreadSafeValue(value: 0)
    weak var delegate: TableViewCellDelegate?
    
    
    private let unlikedImage = UIImage(named: "icon_heart")
    private let likedImage = UIImage(named: "icon_heart_fill")
    
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3
    
//    var quote: QuoteModel? {
//        didSet {
//            let theme = ThemeManager.shared.currentTheme
//            self.lblQuote.text = quote?.content
//            lblQuote?.textColor = theme?.textColor
//            lblQuote?.font = theme?.font
//
//            let favImage = ((quote?.isFavourite ?? false) ? likedImage : unlikedImage)?.withRenderingMode(.alwaysTemplate)
//            btnHeart.setImage(favImage, for: .normal)
//
//            let shareImage = UIImage(named: "icon_share")?.withRenderingMode(.alwaysTemplate)
//            btnShare.setImage(shareImage, for: .normal)
//
//            btnHeart.tintColor = theme?.textColor
//            btnShare.tintColor = theme?.textColor
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        initMultiTap()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectTapped(_ sender: Any) {
        self.onShare?()
    }
    
    private func showFavIcon() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.imgHeart.alpha = 1.0
            self.animateHeart(scale: 1.2)
        }) { (completed) in
            if completed
            {
                self.animateHeart(scale: 0.5)
            }
        }

    }
    
    
    private func animateHeart(scale: CGFloat) {
        UIView.animate(withDuration: 1, animations: {
            self.imgHeart.transform = self.btnHeart.transform.scaledBy(x: scale, y: scale)
        }, completion: { _ in
          UIView.animate(withDuration: 1, animations: {
            self.imgHeart.alpha = 0.0
            self.imgHeart.transform = CGAffineTransform.identity
          })
        })
    }
    
//    private func animate() {
//        UIView.animate(withDuration: 0.1, animations: {
//          let newScale = (self.quote?.isFavourite ?? false) ? self.likedScale : self.unlikedScale
//            self.btnHeart.transform = self.btnHeart.transform.scaledBy(x: newScale, y: newScale)
//        }, completion: { _ in
//          UIView.animate(withDuration: 0.1, animations: {
//            self.btnHeart.transform = CGAffineTransform.identity
//          })
//        })
//    }
    
    @IBAction func btnLikeTapped(_ sender: Any) {
        
//        AppManager.shared.vibrate()
//
//        if quote?.isFavourite ?? false {
//            quote?.isFavourite = false
//        } else {
//            quote?.isFavourite = true
//        }
//
////        Quote.setFavorite(id: quote?.id, favorite: quote?.isFavourite)
//
//        let favImage = UIImage(named: (quote?.isFavourite ?? false) ? "icon_heart_fill" : "icon_heart")?.withRenderingMode(.alwaysTemplate)
//        btnHeart.setImage(favImage, for: .normal)
//
//        if (quote?.isFavourite ?? false) {
//            self.showFavIcon()
//        }
//
//        animate()
    }
    
}

protocol TableViewCellDelegate: AnyObject {
    func singleTapDetected(in cell: VideoTableViewCell)
    func doubleTapDetected(in cell: VideoTableViewCell)
    func longTapDetected(in cell: VideoTableViewCell)
}

extension VideoTableViewCell: MultiTappableDelegate {
    func singleTapDetected(in view: MultiTappable) { self.delegate?.singleTapDetected(in: self) }
    func doubleTapDetected(in view: MultiTappable) { self.delegate?.doubleTapDetected(in: self) }
    func longTapDetected(in view: MultiTappable) { self.delegate?.longTapDetected(in: self) }
}
