//
//  FandrumHomePage.swift
//  FanfrumApp
//
//  Created by Aditya on 17/01/22.
//

import UIKit
import Photos
import OpalImagePicker
import AVFoundation
import AVKit
import CoreData

struct CategoryList {
    
    var category_image: String
    var isSelected: Bool

    
    
}

struct subCategoryList {
    
    
    var subcategory_image: String
    var isSelected: Bool

    
    
}

struct userList {
    
    
    var titles: String
    var isSelected: Bool

    
    
}

class FandrumHomePage: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate{
   
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var vedieoview: UIView!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    
    @IBOutlet weak var collectionViewSecond: UICollectionView!
    var currentIndex: Int = 0


    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var ImagecollectionView: UICollectionView!

    @IBOutlet weak var profileImage: UIImageView!
    
  
    @IBOutlet weak var namelbl: UILabel!
    var topArray = [CategoryList]()
    var secondArray = [subCategoryList]()
    var bottomArray = [userList]()
    private var selectedImages: [UIImage] = []


    var player: AVPlayer!
    var avpController = AVPlayerViewController()

   

    @IBOutlet weak var bottomcollectionView: UICollectionView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    var usercategory_image = String()
    var usertag = String()
    
    var userfeatchName = String()
    var userfaatchdes = String()
    var userfatchtag = String()
   var  userfeatchImages = [String]()
    var userfeatchImage = String()
    var userfeatchProfileImage = UIImage()



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        
    }
    

   
    @IBAction func btnMemify(_ sender: Any) {
        //playVideo()
    }
    
    /// Select multiple  Image
    @IBAction func btnAddMore(_ sender: Any) {
        
        
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                     return
                 }

                 let imagePicker = OpalImagePickerController()

                //    imagePicker.maximumSelectionsAllowed = 4

                               selectedImages = []
                               let options: PHImageRequestOptions = PHImageRequestOptions()
                               options.deliveryMode = .highQualityFormat
                            
                            print(PHImageManagerMaximumSize)
                    
            
            presentOpalImagePickerController(imagePicker, animated: true,
            select: { (assets) in
                

                              for asset in assets {
                                  PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, info) in
                                      self.selectedImages.append(image!)
  
                                    self.ImagecollectionView.reloadData()
                                   
                                 
                                  }

                    imagePicker.dismiss(animated: true, completion: nil)
                }
            }, cancel: {
                //Cancel
            })
            
            
        UserDefaults.standard.setValue(selectedImages, forKey: "images")
        UserDefaults.standard.synchronize()

            
            

       

    }
    /// Initializing All the Objects
    func initialization() {
        setupNavigationBar()
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim1-1",isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim11", isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim12",isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim13",isSelected: false))

        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim14",isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim1-1",isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim11", isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim12",isSelected: false))
        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim13",isSelected: false))

        topArray.append(CategoryList(category_image: "imgpsh_fullsize_anim14",isSelected: false))
        
        
        secondArray.append(subCategoryList(subcategory_image: "imgpsh_fullsize_anim15",isSelected: false))
        secondArray.append(subCategoryList(subcategory_image: "camera",isSelected: false))
        secondArray.append(subCategoryList(subcategory_image: "imgpsh_fullsize_anim16",isSelected: false))
        secondArray.append(subCategoryList(subcategory_image: "imgpsh_fullsize_anim17",isSelected: false))


        bottomArray.append(userList(titles:"Suggsted Tag1",isSelected: false))
        bottomArray.append(userList(titles:"Suggsted Tag2",isSelected: false))
        bottomArray.append(userList(titles:"Suggsted Tag3",isSelected: false))
        
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
        
        
        let btnFavorite = UIButton.init(type: .custom)
        btnFavorite.setTitle("DRAFT", for: .normal)
        btnFavorite.setTitleColor(UIColor.red, for: .normal)
     
        
        let btnNotification = UIButton.init(type: .custom)
        btnNotification.setTitle("POST", for: .normal)
        btnNotification.setTitleColor(UIColor.red, for: .normal)
        btnNotification.addTarget(self, action: #selector(FandrumHomePage.PostButtonPressed), for: .touchUpInside)

    
        
        let stackview = UIStackView.init(arrangedSubviews: [btnFavorite,btnNotification])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        self.title = "Write a Post"
        
    }
    
    @objc func btnMenuAction() {
    }

    @objc func PostButtonPressed() {
       openDatabse()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = self.storyboard?.instantiateViewController(identifier: "FanrdumpostDetailsVc") as! FanrdumpostDetailsVc
        
        vc.userfeatchName = userfeatchName
        vc.userfaatchdes  = userfaatchdes
        vc.userfatchtag = usertag
        vc.selectedImages = selectedImages
        vc.userfeatchImage = userfeatchImage
        vc.userfeatchProfileImage = userfeatchProfileImage

        self.present(vc, animated: true, completion: nil)

        
    }
    /// open database using core data
    func openDatabse()
    {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newUser)
    }

    /// save database using  core data

    func saveData(UserDBObj:NSManagedObject)
    {
     
        let images = profileImage.image
      
        let imageData = images!.pngData()!
        
        //let imageData = profileImage.image?.pngData()
        var userprofile = imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)

      


        UserDBObj.setValue("Rahul", forKey: "name")
        UserDBObj.setValue(textView.text, forKey: "des")
        UserDBObj.setValue(usertag, forKey: "tag")
        UserDBObj.setValue(selectedImages, forKey: "images")
        UserDBObj.setValue(usercategory_image, forKey: "userImage")
        UserDBObj.setValue(userprofile, forKey: "profileImage")

        UserDefaults.standard.setValue(imageData, forKey: "profileImage")
        UserDefaults.standard.synchronize()



        print("Storing Data..")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
        fetchData()

    }

    func fetchData()
    {
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result)
            for data in result as! [NSManagedObject] {
                userfeatchName = data.value(forKey: "name") as! String
                userfaatchdes = data.value(forKey: "des") as! String
                userfatchtag = data.value(forKey: "tag") as! String

                let defaults = UserDefaults.standard

                userfeatchImages = (defaults.stringArray(forKey: "images"))!
                

                userfeatchImage = data.value(forKey: "userImage") as! String
                
                
                

                userfeatchProfileImage = profileImage.image!
              
               // userfeatchProfileImage = data.value(forKey: "profileImage") as! String

               

              

            }
        } catch {
            print("Fetching data Failed")
        }
    }



    

  /// count values off list using numberOfItemsInSection methode
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int!
        if collectionView == collectionViewTop{
            count = topArray.count
        }else if collectionView == collectionViewSecond{
            count = secondArray.count
        }
        else if collectionView == bottomcollectionView{
            count = bottomArray.count
        }
        else if collectionView == ImagecollectionView{
            if(selectedImages.count > 0){
            count = selectedImages.count
            }else{
                count = 1
            }
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
        topCell.userImage.image = UIImage(named:  topArray[indexPath.row].category_image)
       
        topCell.userImage.contentMode  = .scaleAspectFit
            
            if indexPath.row == 0{
                topCell.layer.borderWidth = 1
                topCell.layer.borderColor = UIColor.red.cgColor
            }
            if menulist.isSelected {
                topCell.layer.borderWidth = 1
                topCell.layer.borderColor = UIColor.red.cgColor
                topCell.layer.cornerRadius = 35

            }
            else{
                topCell.layer.borderWidth = 1
                topCell.layer.borderColor = UIColor.white.cgColor
                topCell.layer.cornerRadius = 0


            }
            
            cellToReturn = topCell
        }else if collectionView == collectionViewSecond{
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath)as!PostCell
            let menulist = secondArray[indexPath.row]
            topCell.userImage = topCell.contentView.viewWithTag(101) as! UIImageView
            topCell.userImage.image = UIImage(named:  secondArray[indexPath.row].subcategory_image)
           
            
            topCell.userImage.contentMode  = .scaleAspectFill
            
            if indexPath.row == 0{
                topCell.layer.borderWidth = 1
                topCell.layer.borderColor = UIColor.red.cgColor
            }
            if menulist.isSelected {
                topCell.layer.borderWidth = 1
                topCell.layer.borderColor = UIColor.red.cgColor
                topCell.layer.cornerRadius = 5

            }
            else{
                topCell.layer.borderWidth = 1
                topCell.layer.borderColor = UIColor.white.cgColor
                topCell.layer.cornerRadius = 0


            }

                cellToReturn = topCell

            
        }
        else if collectionView == bottomcollectionView{
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)as!bottomCell
            let menulist = bottomArray[indexPath.row]
            topCell.usertitles.text  = bottomArray[indexPath.row].titles
            if indexPath.row == 0{
            topCell.backgroundColor = UIColor.red
                topCell.usertitles.textColor = UIColor.white
                topCell.layer.cornerRadius = 12

            }
            if menulist.isSelected{
                topCell.backgroundColor = UIColor.red
                    topCell.usertitles.textColor = UIColor.white
                    topCell.layer.cornerRadius = 12
            }
            else{
                topCell.backgroundColor = UIColor(red: 223/255, green: 235/255, blue: 253/255, alpha: 1.0)
                topCell.usertitles.textColor = UIColor.black

                topCell.layer.cornerRadius = 12

            }
                cellToReturn = topCell

            
        }
        else if collectionView == ImagecollectionView{
            if(selectedImages.count > 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ZMPopupCVC
            
            cell?.imgView.image = selectedImages[indexPath.item]
                cell?.layer.cornerRadius = 5
                cell?.layer.borderWidth = 1
                var red1 = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0)
                cell?.layer.borderColor = red1.cgColor
                cell?.btnCross.addTarget(nil, action: #selector(del2(sender:)), for: .touchUpInside)
                 cellToReturn = cell!
            }else{
                //Kids' Wear
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ZMPopupCVC

                
                cell?.imgView.image = UIImage(named: "Kids' Wear")
                    cell?.layer.cornerRadius = 5
                    cell?.layer.borderWidth = 1
                    var red1 = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0)
                    cell?.layer.borderColor = red1.cgColor
                    cell?.btnCross.addTarget(nil, action: #selector(del2(sender:)), for: .touchUpInside)
                     cellToReturn = cell!

            }
        }

        return cellToReturn
    }
   /// delete methode for Image
    @objc func del2(sender: UIButton) {

    let indexPath = IndexPath(item: sender.tag, section: 0)

        selectedImages.remove(at: 0)

        self.ImagecollectionView.performBatchUpdates({
            self.ImagecollectionView.deleteItems(at: [indexPath])
        }) { (finished) in
            self.ImagecollectionView.reloadItems(at: self.ImagecollectionView.indexPathsForVisibleItems)
        }
        

    }

    

    /// did Select methode   select or unselect for list


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == collectionViewTop{
          usercategory_image  = topArray[indexPath.row].category_image
        
        self.currentIndex = indexPath.row
        collectionViewTop.scrollToItem(at: indexPath, at: .left, animated: true)
        for (index, _) in self.topArray.enumerated() {
            if index == indexPath.row {
                self.topArray[index].isSelected = true
                
                
                
                
            } else {
                self.topArray[index].isSelected = false
            }
            
            
        }
        
        collectionViewTop.reloadData()
        }else if collectionView == collectionViewSecond{
            
            self.currentIndex = indexPath.row
            collectionViewSecond.scrollToItem(at: indexPath, at: .left, animated: true)
            for (index, _) in self.secondArray.enumerated() {
                if index == indexPath.row {
                    self.secondArray[index].isSelected = true
                    
                    
                    
                    
                } else {
                    self.secondArray[index].isSelected = false
                }
                
                
            }
            
            collectionViewSecond.reloadData()

            
        }
        
        else if collectionView == bottomcollectionView{
           usertag = bottomArray[indexPath.row].titles
            self.currentIndex = indexPath.row
            bottomcollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            for (index, _) in self.bottomArray.enumerated() {
                if index == indexPath.row {
                    self.bottomArray[index].isSelected = true
                    
                    
                    
                    
                } else {
                    self.bottomArray[index].isSelected = false
                }
                
                
            }
            
            bottomcollectionView.reloadData()

            
        }
        
    }
}

class MyCell : UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    func toggleSelected ()
    {
        if (isSelected){
            userImage.layer.borderWidth = 1
            userImage.layer.borderColor = UIColor.red.cgColor
        }else {
            userImage.layer.borderWidth = 0
            userImage.layer.borderColor = UIColor.white.cgColor
        }
    }

}

class PostCell : UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    func toggleSelected ()
    {
        if (isSelected){
            userImage.layer.borderWidth = 1
            userImage.layer.borderColor = UIColor.red.cgColor
        }else {
            userImage.layer.borderWidth = 0
            userImage.layer.borderColor = UIColor.white.cgColor
        }
    }

}

class PrePhotoPostPhotoLIbraryCell: UICollectionViewCell {

    // MARK: Outlets
    @IBOutlet weak var photoLibraryImage: UIImageView!

    // var selectedPhotos = [UIImageView]()

    @IBAction func selectedButtonPressed(_ sender: UIButton) {
        self.layer.borderWidth = 3.0
        self.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.clear.cgColor
    }
    override func awakeFromNib() {

        photoLibraryImage.clipsToBounds = true
        photoLibraryImage.contentMode = .scaleAspectFill
        photoLibraryImage.layer.borderColor = UIColor.clear.cgColor
        photoLibraryImage.layer.borderWidth = 1
        photoLibraryImage.layer.cornerRadius = 5

    }
}
class bottomCell : UICollectionViewCell {

    @IBOutlet weak var usertitles: UILabel!

}

class ZMPopupCVC : UICollectionViewCell {
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var imgView: UIImageView!

}

