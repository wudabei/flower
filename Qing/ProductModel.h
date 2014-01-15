//
//  ProductModel.h
//  Qing
//
//  Created by cannaan on 14-1-9.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "WXBaseModel.h"

@interface ProductModel : WXBaseModel


@property (strong, nonatomic)  NSString *description;
@property (strong, nonatomic)  NSString *name;
@property (strong, nonatomic)  NSString  *details;
@property (strong, nonatomic)  NSString  *price;
@property (strong, nonatomic)  NSString  *imageURL;


//temp for demo

@property (strong,nonatomic) NSString *image;
@end
