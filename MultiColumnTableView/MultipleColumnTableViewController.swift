//
//  MultipleColumnTableViewController.swift
//  MultiColumnTableView
//
//  Created by John Sklikas on 6/8/22.
//

import UIKit

private let reuseIdentifier = "MultipleColumnCell"

class MultipleColumnTableViewController: UICollectionViewController {
    let dataSourceKeys: [String] = ["Name", "City", "Color", "Country"];
    var needsStatusInset = true;
    var dataSourceDictionary:[String: Array] = ["Name":["John", "Mitch", "Kelly", "Alex"], "City":["Athens", "Tel Aviv", "Patras", "Paris"], "Color":["Red", "Blue", "Green", "Yellow"], "Country":["Greece", "Israel", "Greece", "France"]];

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //Set a safe inset because the collection view has a tendency to cover the status bar by default, and breaks on scroll. It should almost always be true, however I kept this as an option in case it breaks something.
        if (needsStatusInset) {
            var statusBarHeight = 0.0 as CGFloat;
            if #available(iOS 13.0, *) {
                let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
                statusBarHeight = (scene.statusBarManager?.statusBarFrame.height)!;
            }
            else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            self.collectionView!.contentInset.top = statusBarHeight;
        }

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //Configure Table View
        let multipleColumnView = self.collectionView;
        multipleColumnView?.dataSource = self;
        
        //Configure Custom Cell subclass
        multipleColumnView?.register(MultipleColumnCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier);
        
        collectionView?.isScrollEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //Configure Custom Layout
        let multipleColumnView = self.collectionView;
        let multipleColumnsLayout = MultipleColumnLayout();
        
        //In case the items are not enough to fill the screen, the cell size should be changed.
        let screenWidth = UIScreen.main.bounds.width;
        let defaultCellWidth = multipleColumnsLayout.CELL_WIDTH;
        let widthNeeded = defaultCellWidth * CGFloat(dataSourceKeys.count);
        
        if (widthNeeded < screenWidth) {
            let configuredWidth = screenWidth / CGFloat(dataSourceKeys.count);
            multipleColumnsLayout.CELL_WIDTH = configuredWidth;
        }
        
        multipleColumnView?.setCollectionViewLayout(multipleColumnsLayout, animated: false);
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //Rows
        let firstKey = dataSourceDictionary.keys.first;
        let firstkeyArray = dataSourceDictionary[firstKey!];
        let rows = firstkeyArray!.count;
        return rows+1;
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Columns
        let columns = dataSourceDictionary.keys.count;
        return columns;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MultipleColumnCell
        
        //Create the label object if it's not created
        if (cell.textLabel == nil) {
            let cellFrame = cell.frame;
            let cellLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellFrame.width, height: cellFrame.height));
            cell.addSubview(cellLabel);
            cell.textLabel = cellLabel;
            cell.textLabel?.textAlignment = .center;
        }
    
        //While this works, dictionaryKeys have a random order, so we need a keys array to preserve our order
        //let dictionaryKeys = Array(dataSourceDictionary.keys) as! [String];
        var currentColumnArray: [String] = [];
        
        //Set the colors depending on the section
        if indexPath.section == 0 {
            //It is the keys row
            //Bold System blue on a white background has a more modern look than white text on gray backgrounds
            //cell.backgroundColor = UIColor.darkGray
            cell.textLabel?.textColor = UIColor.systemBlue
            let headerFont = UIFont.boldSystemFont(ofSize: 17.0);
            cell.textLabel!.font = headerFont;
            currentColumnArray = dataSourceKeys;
        
        }
        else {
            //cell.backgroundColor = UIColor.white --Not needed because we want dark mode compatibility
            cell.textLabel?.textColor = UIColor.black
            let tableFont = UIFont.systemFont(ofSize: 15.0);
            cell.textLabel!.font = tableFont;
            //Get the first item for every key
            for currentKey in dataSourceKeys {
                let arrayForItem = dataSourceDictionary[currentKey];
                let searchingIndex = indexPath.section-1 //The reason is that we added a key rows on top.
                let currentItem = arrayForItem?[searchingIndex];
                currentColumnArray.append(currentItem ?? "");
            }
            
        }
        
        //Last configure the cell text
        cell.textLabel!.text = currentColumnArray[indexPath.row];
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
