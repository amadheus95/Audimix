//
//  ChooseComicCollectionViewController.swift
//  ComicsSolution
//
//  Created by Rodrigo Machado on 9/14/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

var index = Int()

class ChooseComicCollectionViewController: UICollectionViewController
{
    var array = [String]()
    var cont = Int()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        array.append("americaCapitain")
        array.append("capa")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // número de collections que serão retornadas
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        let button = cell.viewWithTag(1) as! UIImageView // criando uma tag para cada collection
        
        button.image = UIImage(named: array[cont]) // adicionando a imagem
        cont++
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
//        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("leitor") as? ViewController
//        
//        self.navigationController?.pushViewController(viewController!, animated: true)
        index = indexPath.row
        self.performSegueWithIdentifier("vai", sender: self)
        print("opa\(indexPath.row)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
            if segue!.identifier == "vai" {
                
                let viewController:ViewController = segue!.destinationViewController as! ViewController
                print("testando o index\(index)")
                viewController.index = index
            
                
        }
    }
    
    

}
