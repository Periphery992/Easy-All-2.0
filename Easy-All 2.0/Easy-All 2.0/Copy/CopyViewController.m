//
//  CopyViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/30.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "CopyViewController.h"
#import "CopyBean.h"

@interface CopyViewController ()
@property (nonatomic, copy) NSString *strCopy;
@property (nonatomic, strong) NSString *strStrong;

@end

@implementation CopyViewController
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self copyCopyBean];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)stringCopyAndMutableCopy
{
    NSString *string = @"abc";
    NSString *stringCopy = [string copy];
    NSMutableString *stringMCopy = [string mutableCopy];
    NSLog(@"string: %p, %p", string, &string);
    NSLog(@"stringCopy: %p, %p", stringCopy, &stringCopy);
    NSLog(@"stringMCopy: %p, %p", stringMCopy, &stringMCopy);
    
    //    string: 0xad768, 0x3224d8
    //    stringCopy: 0xad768, 0x3224d4
    //    stringMCopy: 0x14e62c00, 0x3224d0
}

- (void)mutableStringCopyAndMutableCopy
{
    NSMutableString *string = [NSMutableString stringWithFormat:@"abc"];
    NSString *stringCopy = [string copy];
    NSMutableString *stringMCopy = [string mutableCopy];
    
    NSLog(@"string: %p, %p", string, &string);
    NSLog(@"stringCopy: %p, %p", stringCopy, &stringCopy);
    NSLog(@"stringMCopy: %p, %p", stringMCopy, &stringMCopy);
    
//    string: 0x14d78350, 0x34d4d8
//    stringCopy: 0x14d77c10, 0x34d4d4
//    stringMCopy: 0x14d751c0, 0x34d4d0
}

- (void)arrayCopyAndMutableCopy
{
    NSString *element_01 = @"abc";
    NSString *element_02 = @"def";
    NSString *element_03 = @"ghi";
    NSArray *array = @[element_01, element_02, element_03];
    NSArray *arrayCopy = [array copy];
    NSMutableArray *arrayMCopy = [array mutableCopy];
    
    NSLog(@"array: %p, %p; array.firstObject: %p", array, &array, array.firstObject);
    NSLog(@"arrayCopy: %p, %p; arrayCopy.firstObject: %p", arrayCopy, &arrayCopy, arrayCopy.firstObject);
    NSLog(@"arrayMCopy: %p, %p; arrayMCopy.firstObject: %p", arrayMCopy, &arrayMCopy, arrayMCopy.firstObject);
    
    //    array: 0x17d85a80, 0x2d14bc; array.firstObject: 0xda768
    //    arrayCopy: 0x17d85a80, 0x2d14b8; arrayCopy.firstObject: 0xda768
    //    arrayMCopy: 0x17d5b620, 0x2d14b4; arrayMCopy.firstObject: 0xda768
}

- (void)mutableArrayCopyAndMutableCopy
{
    NSString *element_01 = @"abc";
    NSString *element_02 = @"def";
    NSString *element_03 = @"ghi";
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[element_01, element_02, element_03]];
    
    NSArray *arrayCopy = [array copy];
    NSMutableArray *arrayMCopy = [array mutableCopy];
    
    NSLog(@"array: %p, %p; array.firstObject: %p", array, &array, array.firstObject);
    NSLog(@"arrayCopy: %p, %p; arrayCopy.firstObject: %p", arrayCopy, &arrayCopy, arrayCopy.firstObject);
    NSLog(@"arrayMCopy: %p, %p; arrayMCopy.firstObject: %p", arrayMCopy, &arrayMCopy, arrayMCopy.firstObject);
    
    //    array: 0x1454c7c0, 0x2724bc; array.firstObject: 0x55768
    //    arrayCopy: 0x1454db70, 0x2724b8; arrayCopy.firstObject: 0x55768
    //    arrayMCopy: 0x145655d0, 0x2724b4; arrayMCopy.firstObject: 0x55768
}

- (void)strongStringAndCopyString
{
    NSMutableString *string = [NSMutableString stringWithFormat:@"abc"];
    self.strStrong = string;
    self.strCopy = string;
    NSLog(@"旧strStrong: %@", self.strStrong);
    NSLog(@"旧strCopy: %@", self.strCopy);
    NSLog(@"旧string: %p, %p", string, &string);
    NSLog(@"旧strStrong: %p, %p", self.strStrong, &_strStrong);
    NSLog(@"旧strCopy: %p, %p", self.strCopy, &_strCopy);
    
    //    旧strStrong: abc
    //    旧strCopy: abc
    //    旧string: 0x17e133f0, 0x2814d8
    //    旧strStrong: 0x17e133f0, 0x17e42e34
    //    旧strCopy: 0x17e37020, 0x17e42e30
    [string appendFormat:@"def"];
    NSLog(@"新strStrong: %@", self.strStrong);
    NSLog(@"新strCopy: %@", self.strCopy);
    NSLog(@"新string: %p, %p", string, &string);
    NSLog(@"新strStrong: %p, %p", self.strStrong, &_strStrong);
    NSLog(@"新strCopy: %p, %p", self.strCopy, &_strCopy);
    //    新strStrong: abcdef
    //    新strCopy: abc
    //    新string: 0x17e133f0, 0x2814d8
    //    新strStrong: 0x17e133f0, 0x17e42e34
    //    新strCopy: 0x17e37020, 0x17e42e30


}

- (void)copyCopyBean
{
    CopyBean *bean = [[CopyBean alloc] init];
    bean.title = @"title";
    bean.name = @"name";                
    
    CopyBean *beanCopy = [bean copy];
    NSLog(@"bean: %p, %p", bean, &bean);
    NSLog(@"beanCopy: %p, %p", beanCopy, &beanCopy);
//   bean: 0x14646df0, 0x2cb4d8
//   beanCopy: 0x146781e0, 0x2cb4d4

}
#pragma mark - Layout Methods

#pragma mark - Get/Set Methods
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
