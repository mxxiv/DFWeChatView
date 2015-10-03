//
//  DFPhotoAlbumPlugin.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFPhotoAlbumPlugin.h"
#import "QBImagePickerController.h"

#import "DFImageMessage.h"

#import "Key.h"

@interface DFPhotoAlbumPlugin()<QBImagePickerControllerDelegate>

@property (strong, nonatomic) QBImagePickerController *imagePickerController;
@property (strong, nonatomic) UINavigationController *imageNavController;

@end



@implementation DFPhotoAlbumPlugin


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.icon = @"sharemore_pic";
        self.name = @"照片";
    }
    return self;
}

-(void) onClick
{
    _imagePickerController = [QBImagePickerController new];
    
    _imagePickerController.delegate = self;
    _imagePickerController.allowsMultipleSelection = YES;
    _imagePickerController.maximumNumberOfSelection = 9;
    _imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
    
    _imageNavController = [[UINavigationController alloc] initWithRootViewController:_imagePickerController];
    
    [self.parentController presentViewController:_imageNavController animated:YES completion:nil];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    [self dismiss];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    [self dismiss];
    NSLog(@"%@",assets);
    
    for (ALAsset *asset in assets) {
        NSDictionary *dic = @{@"asset":asset};
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_IMAGE_MESSAGE object:nil userInfo:dic];
    }
}
-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismiss];
}

-(void) dismiss
{
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
@end
