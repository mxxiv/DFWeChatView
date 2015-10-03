//
//  DFPhotoAlbumPlugin.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFPhotoCameraPlugin.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Key.h"

@interface DFPhotoCameraPlugin()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *pickerController;

@end




@implementation DFPhotoCameraPlugin


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.icon = @"sharemore_video";
        self.name = @"拍摄";
    }
    return self;
}


-(void)onClick
{
    if (_pickerController == nil) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self.parentController presentViewController:_pickerController animated:YES completion:nil];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    ALAssetsLibraryWriteImageCompletionBlock completeBlock = ^(NSURL *assetURL, NSError *error){
        if (!error) {
            
            ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *asset)
            {
                [_pickerController dismissViewControllerAnimated:YES completion:nil];
                
                NSDictionary *dic = @{@"asset":asset};
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_IMAGE_MESSAGE object:nil userInfo:dic];
            };
            
            ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL:assetURL
                           resultBlock:resultblock
                          failureBlock:nil];
        }
    };
    if(image){
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:[image CGImage]
                                  orientation:(ALAssetOrientation)[image imageOrientation]
                              completionBlock:completeBlock];
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}

@end
