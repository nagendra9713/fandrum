//
//  FanrdumpostDetailsVc.swift
//  FandrumProject
//
//  Created by Aditya on 19/01/22.
//

import UIKit
import Photos
import OpalImagePicker
import AVFoundation
import AVKit
import CoreData

class FanrdumpostDetailsVc: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var deslbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var vedieoview: UIView!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    
    @IBOutlet weak var collectionViewSecond: UICollectionView!
    var currentIndex: Int = 0


    var userfeatchName = String()
    var userfaatchdes = String()
    var userfatchtag = String()
  
    var userfeatchImage = String()
    
  
    var topArray = [String]()
    var secondArray = [String]()
    var bottomArray = [String]()
    var selectedImages: [UIImage] = []


    var player: AVPlayer!
    var avpController = AVPlayerViewController()

   

    @IBOutlet weak var bottomcollectionView: UICollectionView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    var usercategory_image = String()
    var usertag = String()
    var userfeatchProfileImage = UIImage()



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        
    }
    

   
    /// Initializing All the Objects
    func initialization() {
        setupNavigationBar()
        print(selectedImages)
        userNamelbl.text = userfeatchName
        deslbl.text = userfaatchdes
        topArray.append(userfeatchImage)
        userImage.image = userfeatchProfileImage
      
        
        
     


        bottomArray.append(userfatchtag)
      
        
        collectionViewTop.allowsSelection = true;
        collectionViewSecond.allowsSelection = true;

        bottomcollectionView.allowsSelection = true;
        
        

        let url = URL(string:"https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4")

        player = AVPlayer(url: url!)

        avpController.player = player

        avpController.view.frame.size.height = vedieoview.frame.size.height

        avpController.view.frame.size.width = vedieoview.frame.size.width

        self.vedieoview.addSubview(avpController.view)




        

        
        
    }
    
 


    /// set up Navigastion bar
    func setupNavigationBar() {
        
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(btnMenuAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        
        
        
        
        self.title = "Post Details"
        
    }
    
    @objc func btnMenuAction() {
    }

    @objc func PostButtonPressed() {
    }

   

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    

  /// count values off list using numberOfItemsInSection methode
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int!
        if collectionView == collectionViewTop{
            count = topArray.count
        }else if collectionView == collectionViewSecond{
            count = selectedImages.count
        }
        else if collectionView == bottomcollectionView{
            count = bottomArray.count
        }

        return count
    }
    
    /// show the values off list using cellForItemAt methode

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellToReturn = UICollectionViewCell()
        if collectionView == collectionViewTop{
            let menulist = topArray[indexPath.row]
        let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)as!MyCell
        topCell.userImage = topCell.contentView.viewWithTag(101) as! UIImageView
        topCell.userImage.image = UIImage(named:  topArray[indexPath.row])
       
        topCell.userImage.contentMode  = .scaleAspectFit
            
          
            
            cellToReturn = topCell
        }else if collectionView == collectionViewSecond{
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath)as!PostCell
            topCell.userImage = topCell.contentView.viewWithTag(101) as! UIImageView
            topCell.userImage.image = selectedImages[indexPath.item]
           
            
            topCell.userImage.contentMode  = .scaleAspectFill
            
          

                cellToReturn = topCell

            
        }
        else if collectionView == bottomcollectionView{
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)as!bottomCell
            let menulist = bottomArray[indexPath.row]
            topCell.usertitles.text  = bottomArray[indexPath.row]
            topCell.backgroundColor = UIColor(red: 223/255, green: 235/255, blue: 253/255, alpha: 1.0)
            topCell.usertitles.textColor = UIColor.black

            topCell.layer.cornerRadius = 12
           
                cellToReturn = topCell

            
        }

        return cellToReturn
    }

    

}
