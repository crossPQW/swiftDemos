//
//  CameraViewController.swift
//  snapchatMenuWithSwift
//
//  Created by 黄少华 on 16/4/28.
//  Copyright © 2016年 黄少华. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var cemareView: UIView!
    
    var captureSession : AVCaptureSession?
    var stillImageOutPut : AVCaptureStillImageOutput?
    var preViewLayer : AVCaptureVideoPreviewLayer?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        preViewLayer?.frame = cemareView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        var input : AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera) }
        catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession?.canAddInput(input) != nil {
            captureSession?.addInput(input)
            stillImageOutPut = AVCaptureStillImageOutput()
            stillImageOutPut?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if captureSession?.canAddOutput(stillImageOutPut) != nil {
                captureSession?.addOutput(stillImageOutPut)
                
                preViewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                preViewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                preViewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cemareView.layer.addSublayer(preViewLayer!)
                captureSession?.stopRunning()
            }
        }
        
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        didPressTakeAnthor()
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnthor(){
        if didTakePhoto == true {
            imageView.hidden = true
            didTakePhoto = false
        }else {
            captureSession?.startRunning()
            didTakePhoto = true
            takePhoto()
        }
    }
    
    func takePhoto() {
        if let videoConnection = stillImageOutPut?.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutPut?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentSaturation)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    self.imageView.image = image
                    self.imageView.hidden = false
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden = true
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
