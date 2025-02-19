//
//  PhotoAsset+URL.swift
//  HXPHPicker
//
//  Created by Slience on 2021/7/19.
//

import UIKit
import AVFoundation

public extension PhotoAsset {
    
    /// 压缩参数
    struct Compression {
        let imageCompressionQuality: CGFloat?
        let videoExportPreset: ExportPreset?
        let videoQuality: Int?
        
        /// 压缩图片
        /// - Parameter imageCompressionQuality: 图片压缩质量 [0.1 - 0.9]
        public init(
            imageCompressionQuality: CGFloat
        ) {
            self.imageCompressionQuality = imageCompressionQuality
            self.videoExportPreset = nil
            self.videoQuality = nil
        }
        
        /// 压缩视频
        /// - Parameters:
        ///   - videoExportPreset: 视频分辨率
        ///   - videoQuality: 视频质量 [1-10]
        public init(
            videoExportPreset: ExportPreset,
            videoQuality: Int
        ) {
            self.imageCompressionQuality = nil
            self.videoExportPreset = videoExportPreset
            self.videoQuality = videoQuality
        }
        
        /// 压缩图片、视频
        /// - Parameters:
        ///   - imageCompressionQuality: 图片压缩质量 [0.1 - 0.9]
        ///   - videoExportPreset: 视频分辨率
        ///   - videoQuality: 视频质量 [1-10]
        public init(
            imageCompressionQuality: CGFloat,
            videoExportPreset: ExportPreset,
            videoQuality: Int
        ) {
            self.imageCompressionQuality = imageCompressionQuality
            self.videoExportPreset = videoExportPreset
            self.videoQuality = videoQuality
        }
    }
    
    typealias AssetURLCompletion = (Result<AssetURLResult, AssetError>) -> Void
    
    /// 获取url
    /// - Parameters:
    ///   - compression: 压缩参数，nil - 原图
    ///   - completion: 获取完成
    func getAssetURL(
        compression: Compression? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        if mediaType == .photo {
            if mediaSubType == .livePhoto ||
                mediaSubType == .localLivePhoto {
                getLivePhotoURL(
                    completion: completion
                )
                return
            }
            getImageURL(
                compressionQuality: compression?.imageCompressionQuality,
                completion: completion
            )
        }else {
            getVideoURL(
                exportPreset: compression?.videoExportPreset,
                videoQuality: compression?.videoQuality,
                completion: completion
            )
        }
    }
    
    /// 获取图片url
    /// - Parameters:
    ///   - compressionQuality: 压缩比例[0.1-0.9]，不传就是原图。gif不会压缩
    ///   - completion: 获取完成
    func getImageURL(
        compressionQuality: CGFloat? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        #if canImport(Kingfisher)
        if isNetworkAsset {
            getNetworkImageURL(
                resultHandler: completion
            )
            return
        }
        #endif
        requestImageURL(
            compressionQuality: compressionQuality,
            resultHandler: completion
        )
    }
    
    /// 获取视频url
    /// - Parameters:
    ///   - exportPreset: 视频分辨率，不传获取的就是原始视频
    ///   - videoQuality: 视频质量[0-10]
    ///   - exportSession: 导出视频时对应的 AVAssetExportSession
    ///   - completion: 获取完成
    func getVideoURL(
        exportPreset: ExportPreset? = nil,
        videoQuality: Int? = 6,
        exportSession: ((AVAssetExportSession) -> Void)? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        if isNetworkAsset {
            getNetworkVideoURL(
                resultHandler: completion
            )
            return
        }
        requestVideoURL(
            exportPreset: exportPreset,
            videoQuality: videoQuality,
            exportSession: exportSession,
            resultHandler: completion
        )
    }
    
    /// 获取LivePhoto里的图片和视频URL
    /// - Parameters:
    ///   - compression: 压缩参数，nil - 原图
    ///   - completion: 获取完成
    func getLivePhotoURL(
        compression: Compression? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        requestLivePhotoURL(
            compression: compression,
            completion: completion
        )
    }
}
