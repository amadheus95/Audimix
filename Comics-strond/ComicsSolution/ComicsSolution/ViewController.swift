//
//  ViewController.swift
//  ComicsSolution
//
//  Created by Rodrigo Machado on 9/8/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    @IBOutlet weak var navigationTitle: UINavigationBar!
    
    var imagemCollectionView = ["HOMEN ARANHA3", "flash", "batman","HOMEN ARANHA3", "flash", "batman"]
    var nomePersonagens = ["homem aranha", "flash", "batman","homem aranha", "flash", "batman"]
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var comicImage: UIImageView!
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    
    var index = Int()
    var sound = Sound()
    var swipe = loadSwipe()
    var cont = Int()
    var verificador1 = Int()
    var verificador2 = Int()
    var verificador3 = Int()
    var instaceAllComics: AllComics?
    
    var  darplay2 = true
    
    var vetorComics = ["0","1","2"]
    var vetorStrings = ["pagina01", "pagina02"]
    
    var vetorStringAudio = ["dinastia-p2-q1","dinastia-p2-q2"]
    var vetorStringFala = ["estranho", "audio-p2-q2"]
    var doubleTap = true
    var location = CGPoint()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        swipe.loadSwipe(self.view!,ob: self)
        viewCollection.hidden = true
        loadTapGesture()
        instaceAllComics = AllComics()
        vetorStrings = instaceAllComics!.vetorComics(index) // Pegar INDEX AQUI!!!!
        vetorStringAudio = instaceAllComics!.vetorAudio(index) // Pegar INDEX AQUI!!!!
        vetorStringFala = instaceAllComics!.vetorFala(index)  //Pegar INDEX AQUI!!!!
        
        audioPlayer2 = sound.setupAudioPlayerWithFile(vetorStringAudio[0])
        audioPlayer3 = sound.setupAudioPlayerWithFile(vetorStringFala[0])
        
        
        loadImage(vetorStrings) // Pegar INDEX AQUI!!!!
        
        vetorComics = (instaceAllComics?.current())!
        
        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.maximumZoomScale = 6.0;
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
    return imagemCollectionView.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: MinhaCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MinhaCollectionViewCell
        
        cell.imagemCell.image = UIImage(named: imagemCollectionView[indexPath.row])
        cell.personagemCell.text = nomePersonagens[indexPath.row]
        cell.imagemCell.layer.cornerRadius = 30
        cell.imagemCell.layer.borderWidth = 5
        cell.imagemCell.layer.borderColor = UIColor.whiteColor().CGColor
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("cell \(indexPath.row) clicada")
    }
    
    func update(){
        
        if audioPlayer2.playing {
            print("wntrou\(darplay2)")
        } else {
            
            if(verificador2==1 && darplay2){
                
                darplay2 = false
                print(audioPlayer3)
                audioPlayer3.play()
                
            }
        }
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    func loadImage(vetor: [String]) {
        comicImage.image = UIImage(named: vetor[cont]) // carregar imagem na tela
        if verificador1 == 1{
            vetorComics = (instaceAllComics?.current())!
            audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
            audioPlayer2.play()
        }
    }
    
    
    
    func loadTapGesture(){
        let bSelector : Selector = "respondToTapGesture:"
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: bSelector)
        doubleTapGesture.numberOfTapsRequired = 2
        self.view!.addGestureRecognizer(doubleTapGesture)
        
        //tapGesture.requireGestureRecognizerToFail(doubleTapGesture)
    }
    
    func respondToTapGesture(gesture: UITapGestureRecognizer){
        
        if(scrollView.zooming || doubleTap || scrollView.zoomScale == 6){
            scrollView.zoomToRect(CGRect(x: 0, y: 0, width: 1000, height: 1000), animated: true)
            doubleTap = false;
        }else{
            //let Touch = gesture.locationOfTouch(1, inView: scrollView)
            //print(Touch.x);
            //print(Touch.y);
            self.scrollView.zoomToRect(CGRect(x: gesture.locationOfTouch(0, inView: scrollView.viewForFirstBaselineLayout).x, y: gesture.locationOfTouch(0, inView: scrollView.viewForFirstBaselineLayout).y, width: 2, height: 2), animated: true)
            print(scrollView.zoomScale)
            doubleTap = true;
            print(location);
        }
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Right:
                print("right")
                
                vetorComics = instaceAllComics!.previous()
                
                if(vetorComics[0] != "end"){
                    audioPlayer = sound.setupAudioPlayerWithFile("Pagina 1")
                    audioPlayer.volume = 0.2
                    audioPlayer.play()
                    if verificador1 == 1{
                        audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
                        audioPlayer2.play()
                    }
                    if verificador2 == 1 {
                        darplay2 = true
                        audioPlayer3 = sound.setupAudioPlayerWithFile(vetorComics[2])
                        if !audioPlayer2.playing{
                            audioPlayer3.play()
                        }
                        
                    }
                    comicImage.image = UIImage(named: vetorComics[0])
                }
                
                return
                
            case UISwipeGestureRecognizerDirection.Left:
                
                print("left")
                
                let vetorComics = instaceAllComics!.next()
                
                if(vetorComics[0] != "end"){
                    audioPlayer = sound.setupAudioPlayerWithFile("Pagina 1")
                    audioPlayer.volume = 0.2
                    audioPlayer.play()
                    if verificador1 == 1{
                        audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
                        audioPlayer2.play()
                    }
                    if verificador2 == 1 {
                        darplay2 = true
                        audioPlayer3 = sound.setupAudioPlayerWithFile(vetorComics[2])
                        if !audioPlayer2.playing{
                            
                            audioPlayer3.play()
                            
                        }
                        
                    }
                    comicImage.image = UIImage(named: vetorComics[0])
                    
                }
                
                
                return
                
            case UISwipeGestureRecognizerDirection.Up:
                print("up")
                viewCollection.hidden = true
                navigationTitle.hidden = false
                return
                
            case UISwipeGestureRecognizerDirection.Down:
                print("down")
                return
                
            default:
                return
            }
        }
        
    }
    
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return self.comicImage
    }
    
    @IBAction func previous(gesture: AnyObject)
    {
        let vetorComics = instaceAllComics!.previous()
        
        if(vetorComics[0] != "end"){
            audioPlayer = sound.setupAudioPlayerWithFile("Pagina 1")
            audioPlayer.volume = 0.2
            audioPlayer.play()
            if verificador1 == 1{
                audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
                audioPlayer2.play()
            }
            if verificador2 == 2 {
                darplay2 = true
                audioPlayer3 = sound.setupAudioPlayerWithFile(vetorComics[2])
                //audioPlayer3.play()
            }
            comicImage.image = UIImage(named: vetorComics[0])
        }
        
        
        
    }
    
    @IBAction func next(sender: AnyObject)
    {
        let vetorComics = instaceAllComics!.next()
        
        if(vetorComics[0] != "end"){
            audioPlayer = sound.setupAudioPlayerWithFile("Pagina 1")
            audioPlayer.volume = 0.2
            audioPlayer.play()
            if verificador1 == 1{
                audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
                audioPlayer2.play()
            }
            if verificador2 == 2 {
                darplay2 = true
                audioPlayer3 = sound.setupAudioPlayerWithFile(vetorComics[2])
                //audioPlayer3.play()
            }
            comicImage.image = UIImage(named: vetorComics[0])
        }
        
        
    }
    
    @IBAction func menu1(sender: AnyObject) {
        print("Verificador1: ",verificador1)
        print("audioPlayer : ",vetorComics[1])
        print("      ibagem: ",vetorComics[0])
        if verificador1 == 0 {
            verificador1 = 1
            vetorComics = (instaceAllComics?.current())!
            audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
            audioPlayer2.play()
            NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector:"update",userInfo:nil, repeats: true)
        }else{
            verificador1 = 0
            audioPlayer2.stop()
        }
        
        print("clicou1\t\(verificador1)")
        
    }
    
    @IBAction func menu2(sender: AnyObject) {
        if verificador2 == 0 {
            verificador2 = 1
            vetorComics = (instaceAllComics?.current())!
            audioPlayer3 = sound.setupAudioPlayerWithFile(vetorComics[2])
            print("\(vetorComics)\t\(audioPlayer2)")
            if !audioPlayer2.playing{
                audioPlayer3.play()
            }
        }else{
            verificador2 = 0
            audioPlayer3.stop()
        }
        print("clicou2\t\(verificador2)")
        
    }
    @IBAction func menu3(sender: AnyObject) {
        if verificador2 == 1 && verificador1 == 1 {
            audioPlayer2.stop()
            audioPlayer3.stop()
            vetorComics = (instaceAllComics?.current())!
            audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
            darplay2 = true
            audioPlayer2.play()
        }else if verificador2 == 1{
            audioPlayer3.stop()
            vetorComics = (instaceAllComics?.current())!
            audioPlayer3 = sound.setupAudioPlayerWithFile(vetorComics[2])
            audioPlayer3.play()
        }else if verificador1 == 1 {
            audioPlayer2.stop()
            vetorComics = (instaceAllComics?.current())!
            audioPlayer2 = sound.setupAudioPlayerWithFile(vetorComics[1])
            audioPlayer2.play()
        }else{
            print("clicou3\t\(verificador3)")
        }
        
        
    }
    
    @IBAction func persogensButton(sender: AnyObject) {
        
        navigationTitle.hidden = true
        viewCollection.hidden = false
    }
    
    
}

