//
//  AWSStreamService.swift
//  FaceRecognition
//
//  Created by capgemini on 30/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit
import AWSCore
import AWSRekognition

class AWSStreamService: NSObject {
    private var awsRekognitionClient:AWSRekognition!
    
    override init() {
        awsRekognitionClient = AWSRekognition.default()
    }
    
    func createStreamProcessor(collectionName: String? = Constants.AWSCollection.Name, streamProcessorName: String? = Constants.StreamService.streamProcessorName, kinesisVideoStreamArn: String? = Constants.StreamService.kvStreamArn,  kinesisDataStreamArn: String? = Constants.StreamService.kdStreamArn, kinesisRoleArn: String? = Constants.StreamService.iamRoleArn, matchThreshold: Float? = Constants.StreamService.threshold) {
        
        let kinesisVideoStream = AWSRekognitionKinesisVideoStream()
        kinesisVideoStream?.arn = kinesisVideoStreamArn
        
        let streamProcessorInput = AWSRekognitionStreamProcessorInput()
        streamProcessorInput?.kinesisVideoStream = kinesisVideoStream
        
        let kinesisDataStream = AWSRekognitionKinesisDataStream()
        kinesisDataStream?.arn = kinesisDataStreamArn
        
        let streamProcessorOutput = AWSRekognitionStreamProcessorOutput()
        streamProcessorOutput?.kinesisDataStream = kinesisDataStream
        
        let faceSearchSettings = AWSRekognitionFaceSearchSettings()
        faceSearchSettings?.collectionId = collectionName
        faceSearchSettings?.faceMatchThreshold = matchThreshold! as NSNumber
        
        let streamProcessorSettings = AWSRekognitionStreamProcessorSettings()
        streamProcessorSettings?.faceSearch = faceSearchSettings
        
        let createStreamProcessorRequest = AWSRekognitionCreateStreamProcessorRequest()
        createStreamProcessorRequest?.input = streamProcessorInput
        createStreamProcessorRequest?.output = streamProcessorOutput
        createStreamProcessorRequest?.settings = streamProcessorSettings
        createStreamProcessorRequest?.roleArn = kinesisRoleArn
        createStreamProcessorRequest?.name = streamProcessorName
        
        awsRekognitionClient.createStreamProcessor(createStreamProcessorRequest!) { (response, error) in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
            } else {
                print("Created Stream Processor ARN: \(String(describing: response?.streamProcessorArn))")
            }
        }
    }
    
    func startStreamProcessor() {
        let startStreamProcessorRequest = AWSRekognitionStartStreamProcessorRequest()
        startStreamProcessorRequest?.name = Constants.StreamService.streamProcessorName
        awsRekognitionClient.startStreamProcessor(startStreamProcessorRequest!) { (response, error) in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
            } else {
                print("Started Stream Processor NAME: \(String(describing: Constants.StreamService.streamProcessorName))")
            }
        }
    }
    
    func stopStreamProcessor() {
        let stopStreamProcessorRequest = AWSRekognitionStopStreamProcessorRequest()
        stopStreamProcessorRequest?.name = Constants.StreamService.streamProcessorName
        awsRekognitionClient.stopStreamProcessor(stopStreamProcessorRequest!) { (response, error) in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
            } else {
                print("Stoped Stream Processor Name: \(String(describing: Constants.StreamService.streamProcessorName))")
            }
        }
    }
    
    func deleteStreamProcessor() {
        let deleteStreamProcessorRequest = AWSRekognitionDeleteStreamProcessorRequest()
        deleteStreamProcessorRequest?.name = Constants.StreamService.streamProcessorName
        awsRekognitionClient.deleteStreamProcessor(deleteStreamProcessorRequest!) { (response, error) in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
            } else {
                print("Deleted Stream Processor Name: \(String(describing: Constants.StreamService.streamProcessorName))")
            }
        }
    }
    
    func describeStreamProcessor() {
        let describeStreamProcessorRequest = AWSRekognitionDescribeStreamProcessorRequest()
        describeStreamProcessorRequest?.name = Constants.StreamService.streamProcessorName
        awsRekognitionClient.describeStreamProcessor(describeStreamProcessorRequest!) { (response, error) in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
            } else {
                print("Described Stream Processor ARN: \(String(describing: response?.streamProcessorArn))")
                print("Described Stream Processor Input KinesisVideo Stream ARN: \(String(describing: response?.input?.kinesisVideoStream?.arn))")
                print("Described Stream Processor Output KinesisVideo Stream ARN: \(String(describing: response?.output?.kinesisDataStream?.arn))")
                print("Described Stream Processor Role ARN: \(String(describing: response?.roleArn))")
                print("Described Stream Processor Setting FaceSearch Collection ID: \(String(describing: response?.settings?.faceSearch?.collectionId))")
                print("Described Stream Processor Status: \(String(describing: response?.status))")
                print("Described Stream Processor Status Message: \(String(describing: response?.statusMessage))")
                print("Described Stream Processor Creation Time Stamp: \(String(describing: response?.creationTimestamp))")
                print("Described Stream Processor Last Updated Time Stamp: \(String(describing: response?.lastUpdateTimestamp))")
            }
        }
    }
    
    func listStreamProcessors() {
        let listStreamProcessorsRequest = AWSRekognitionListStreamProcessorsRequest()
        listStreamProcessorsRequest?.maxResults = NSNumber(integerLiteral: 100)
        awsRekognitionClient.listStreamProcessors(listStreamProcessorsRequest!) { (response, error) in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
            } else {
                for streamProcessor in  (response?.streamProcessors)! {
                    print("List Stream Processor Name: \(String(describing: streamProcessor.name))")
                    print("List Stream Processor Status: \(String(describing: streamProcessor.status))")
                }
            }
        }
    }
}
