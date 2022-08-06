//
//  MultipleColumnTableViewController.swift
//  MultiColumnTableView
//
//  Created by John Sklikas on 6/8/22.
//

import UIKit

private let reuseIdentifier = "MultipleColumnCell"

class MultipleColumnTableViewController: UICollectionViewController {
    let dataSourceKeys: [String] = ["Name", "City", "Color"];
    var dataSourceDictionary:[String: Array] = ["Name":["John", "Mitch", "Kelly"], "City":["Athens", "Tel Aviv", "Patras"], "Color":["Red", "Blue", "Green"]];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
            cell.textLabel!.font = UIFont.boldSystemFont(ofSize: cell.textLabel!.font.pointSize);
            currentColumnArray = dataSourceKeys;
        
        } else {
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel!.font = UIFont.systemFont(ofSize: cell.textLabel!.font.pointSize);
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
