//
//  ChangePhotoOrImageView.h
//  HongDian
//
//  Created by 姜通 on 15/8/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectWhichTypeUseImageBlock) ();
typedef void(^SelectWhichTypeUsePhotoBlock) ();
typedef void(^SelectWhichTypeUseCaccleBlock) ();


@interface ChangePhotoOrImageView : UIView

@property (nonatomic, copy) SelectWhichTypeUseImageBlock selectWhichTypeUseImageBlock;
@property (nonatomic, copy) SelectWhichTypeUsePhotoBlock selectWhichTypeUsePhotoBlock;
@property (nonatomic, copy) SelectWhichTypeUseCaccleBlock selectWhichTypeUsecancleBlock;

@end
