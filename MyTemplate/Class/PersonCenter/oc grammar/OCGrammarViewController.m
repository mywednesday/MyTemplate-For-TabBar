//
//  OCGrammarViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/11/2.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "OCGrammarViewController.h"
#import <Masonry.h>




@interface OCGrammarViewController ()

@property (nonatomic, strong) UIButton *myArrayButton;              //NSArray按钮
@property (nonatomic, strong) UIButton *myDictionaryButton;         //NSDictionary按钮

@end





@implementation OCGrammarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC Grammar";
    self.view.backgroundColor = VIEW_NORMAL_BG_COLOR;
    
    
    
#pragma mark -- NSArray按钮 --
    _myArrayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myArrayButton setTitle:@"按钮(NSArray)" forState:UIControlStateNormal];
    [_myArrayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myArrayButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myArrayButton setBackgroundColor:[UIColor redColor]];
    [_myArrayButton addTarget:self action:@selector(arrayBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myArrayButton];
    [_myArrayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
#pragma mark -- NSDictionary按钮 --
    _myDictionaryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myDictionaryButton setTitle:@"按钮(NSDictionary)" forState:UIControlStateNormal];
    [_myDictionaryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myDictionaryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myDictionaryButton setBackgroundColor:[UIColor redColor]];
    [_myDictionaryButton addTarget:self action:@selector(dictionaryBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myDictionaryButton];
    [_myDictionaryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myArrayButton.mas_bottom).offset(40);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
}


/**
    NSArray按钮点击事件
 */
- (void) arrayBtnAction {
    
    /*
        NSArray创建后，其中的内容将不能改变
     */
    CustomLog(@"\n-- NSArray按钮点击事件 --");
    
#pragma mark -- Creating an Array --
    CustomLog(@"\n1.___Creating an Array___");
//    CustomLog(@"\n****  initWithObjects  ****");
//    NSArray *myArray1_1 = [[NSArray alloc] initWithObjects:@"we",@"slkk",@"wg",@"sd", nil];
//    CustomLog(@"\nmyArray1_1 = %@",myArray1_1);
//    
//    
//    CustomLog(@"\narrayWithObjects  可以跟多个对象(只要是对象就行)");
//    NSArray *myArray1_2 = [NSArray arrayWithObjects:@"we",myArray1_1,@"slkk",@"wg",@"sd", nil];
//    CustomLog(@"\nmyArray1_2 = %@",myArray1_2);
//    
//    
//    CustomLog(@"\arrayWithObject  只能跟一个对象(只要是对象就行)");
////    NSArray *myArray1_3 = [NSArray arrayWithObject:@"we"];
//    NSArray *myArray1_3 = [NSArray arrayWithObject:myArray1_2];
//    CustomLog(@"\nmyArray1_3 = %@",myArray1_3);
//    
//    
//    CustomLog(@"\n另外一种直接初始化的方法");
//    NSArray *myArray1_4 = @[@"四大皆空", myArray1_1, @"速度速度"];
//    CustomLog(@"\nmyArray1_4 = %@",myArray1_4);
//    
//    
//    CustomLog(@"\n从另一个Array初始化");
//    NSString *strings[3];
//    strings[0] = @"First";
//    strings[1] = @"Second";
//    strings[2] = @"Third";
//    NSArray *myArray1_5 = [NSArray arrayWithObjects:strings count:2];           //包含了strings 中的前两个
//    CustomLog(@"\nmyArray1_5 = %@",myArray1_5);
    
    
    
    
    
#pragma mark -- Initializing an Array --
    CustomLog(@"\n2.___Initializing an Array___");
//    NSArray *initTmp2 = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
//    
//    
//    CustomLog(@"\n****  initWithObjects  ****");
//    NSArray *myArray2_1 = [[NSArray alloc] initWithArray: initTmp2];
//    CustomLog(@"\nmyArray2_1 = %@",myArray2_1);
//    
//    
//    CustomLog(@"\n****  initWithObjects  ****");
//    NSArray *myArray2_2 = [[NSArray alloc] initWithArray: initTmp2 copyItems:YES];       // if flag is YES, copies of the objects—in array.
//    CustomLog(@"\nmyArray2_2 = %@",myArray2_2);
//    
//    /*  打印对象地址
//    CustomLog(@"\ninitTmp = %p",initTmp);
//    CustomLog(@"\nmyArray2_1 = %p",myArray2_1);
//    CustomLog(@"\nmyArray2_2 = %p",myArray2_2);
//    */
//    
//    
//    CustomLog(@"\n****  initWithObjects  ****");
//    NSArray *myArray2_3 = [[NSArray alloc] initWithObjects:initTmp2, nil];
//    CustomLog(@"\nmyArray2_3 = %@",myArray2_3);
//    
//    
//    CustomLog(@"\n****  initWithObjects  ****");
//    NSString *strings2[7];
//    strings2[0] = @"周一";
//    strings2[1] = @"周二";
//    strings2[2] = @"周三";
//    strings2[3] = @"周四";
//    strings2[4] = @"周五";
//    strings2[5] = @"周六";
//    strings2[6] = @"周日";
//    NSArray *myArray2_4 = [[NSArray alloc] initWithObjects:strings2  count:5];          //这里的Objects必须是 C数组[] 的形式
//    CustomLog(@"\nmyArray2_4 = %@",myArray2_4);
    
    
    
    
    
#pragma mark -- Querying an Array --
//    CustomLog(@"\n3.___Querying an Array___");
//    NSArray *initTmp3 = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
//    
//    
//    CustomLog(@"\n****  containsObject  ****");
//    CustomLog(@"\ninitTmp3中%@%@",[initTmp3 containsObject:@"周三"] ? @"含有" : @"没有", @"周三");
//    
//    
//    CustomLog(@"\n****  count  ****");
//    CustomLog(@"\ninitTmp3中一共有%lu个对象",(unsigned long)[initTmp3 count]);
//    
//    
//    CustomLog(@"\n****  getObjects: range:  不知道怎么用  ****");
//    
//    
//    CustomLog(@"\n****  firstObject  ****");
//    CustomLog(@"\ninitTmp3的第一个对象，firstObject是:%@", [initTmp3 firstObject]);     //不能智能提示出来....
//    
//    
//    CustomLog(@"\n****  lastObject  ****");
//    CustomLog(@"\ninitTmp3的最后一个对象，lastObject是:%@", [initTmp3 lastObject]);
//    
//    
//    CustomLog(@"\n****  objectAtIndex  ****");
//    int index = 3;
//    CustomLog(@"\ninitTmp3的第%d个对象是:%@", index, [initTmp3 objectAtIndex: (index - 1)]);
//    
//    
//    CustomLog(@"\n****  objectAtIndexedSubscript  ****");
//    int idx = 3;
//    CustomLog(@"\ninitTmp3的第%d个对象是:%@", idx, [initTmp3 objectAtIndexedSubscript: (idx - 1)]);
//    
//    
//    CustomLog(@"\n****  objectsAtIndexes  ****");
//    NSUInteger loc = 2;
//    NSUInteger len = 4;
//    CustomLog(@"\ninitTmp3的第%lu个位置开始的%lu个对象是:%@", loc+1,
//              (unsigned long)len,
//              [initTmp3 objectsAtIndexes: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(loc, len)]]);
//    
//    
//    CustomLog(@"\n****  objectEnumerator  ****");
//    NSEnumerator *enumerator = [initTmp3 objectEnumerator];         //将NSArray中的对象转换成枚举类型
//    CustomLog(@"对应的枚举类型为:");
//    id anObj;
//    while (anObj = [enumerator nextObject]) {
//        CustomLog(@"\n%@",anObj);
//    }
//    
//    
//    CustomLog(@"\n****  reverseObjectEnumerator  ****");
//    //与objectEnumerator的区别是：reverseObjectEnumerator将NSArray中的对象逆序排序了
//    NSEnumerator *enumerator1 = [initTmp3 reverseObjectEnumerator];
//    CustomLog(@"对应的枚举类型为:");
//    id anObj1;
//    while (anObj1 = [enumerator1 nextObject]) {
//        CustomLog(@"\n%@",anObj1);
//    }
    
    
#pragma mark -- Finding Objects in an Array --
//    CustomLog(@"\n3.___Finding Objects in an Array___");
//    NSArray *initTmp3 = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
//    NSString *targetObj = @"周三";
//    
//    CustomLog(@"\n****  indexOfObject  ****");
//    CustomLog(@"\ntargetObj是initTmp3中的第%lu个对象",(unsigned long)[initTmp3 indexOfObject: targetObj]);     //使用 isEqual 实现
//    
//    
//    CustomLog(@"\n****  indexOfObject: inRange:  ****");
//    NSUInteger targetIndex = [initTmp3 indexOfObject: targetObj inRange: NSMakeRange(2, 2)];        ////使用 isEqual 实现，不明白该函数存在的意义
//    CustomLog(@"\ntargetObj是initTmp3中的第%lu个对象", NSNotFound == targetIndex ? 1111 : targetIndex);
    
    
    
    
    //未完  待续...
}


/**
    NSDictionary按钮点击事件
 */
- (void) dictionaryBtnAction {
    /*
     NSDictionary创建后，其中的内容将不能改变
     NSDictionary中的Key是唯一的（PS：初始化时重复也不会报错，先到先得，后边添加相同的Key将会失败）
     不同Key的Value可以是相同的
     */
    CustomLog(@"\n-- NSDictionary按钮点击事件 --");
    
#pragma mark -- Creating a Dictionary --
    CustomLog(@"\n1.___Creating a Dictionary___");
//    NSDictionary *initTmp1 = @{@"1": @"周一",         //key: value
//                               @"2": @"周二",
//                               @"3": @"周三",
//                               @"4": @"周四",
//                               @"5": @"周五",
//                               @"6": @"周六",
//                               @"7": @"周日"};
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithDictionary  ****");
//    NSDictionary *myDictionary1_1 = [NSDictionary dictionaryWithDictionary:initTmp1];
//    CustomLog(@"\nmyDictionary1_1 = %@",myDictionary1_1);
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithObject: forKey:  ****");                  //这里用的单个对象
//    NSDictionary *myDictionary1_2 = [NSDictionary dictionaryWithObject:@"wo de tian" forKey:@"only"];
//    CustomLog(@"\nmyDictionary1_2 = %@",myDictionary1_2);
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithObjects: forKeys:  ****");                //这里用的只能是NSArray形式的参数
//    NSDictionary *myDictionary1_3 = [NSDictionary dictionaryWithObjects:@[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"]
//                                                                forKeys:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7"]];
//    CustomLog(@"\nmyDictionary1_3 = %@",myDictionary1_3);
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithObjects: forKeys: count: ****");          //这里用的只能是C数组形式的参数
//    NSString *values1_4[7];
//    values1_4[0] = @"Monday";
//    values1_4[1] = @"Tuesday";
//    values1_4[2] = @"Wednesday";
//    values1_4[3] = @"Thursday";
//    values1_4[4] = @"Friday";
//    values1_4[5] = @"Saturday";
//    values1_4[6] = @"Sunday";
//    
//    NSString *keys1_4[7];
//    keys1_4[0] = @"1";
//    keys1_4[1] = @"2";
//    keys1_4[2] = @"3";
//    keys1_4[3] = @"4";
//    keys1_4[4] = @"5";
//    keys1_4[5] = @"6";
//    keys1_4[6] = @"7";
//    
//    NSDictionary *myDictionary1_4 = [NSDictionary dictionaryWithObjects:values1_4
//                                                                forKeys:keys1_4
//                                                                  count:5];
//    CustomLog(@"\nmyDictionary1_4 = %@",myDictionary1_4);
//    
//    
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithObjects: forKeys: count: ****");          //和开始的时候直接初始化很像,但是这里的方式全部都是逗号(,)
//    NSDictionary *myDictionary1_5 = [NSDictionary dictionaryWithObjectsAndKeys: @"value1", @"key1", @"value2", @"key2", nil];
//    CustomLog(@"\nmyDictionary1_5 = %@",myDictionary1_5);
    
    
    
    
    
#pragma mark -- Initializing an NSDictionary Instance --
    CustomLog(@"\n2.___Initializing an NSDictionary Instance___");
//    NSDictionary *initTmp2 = @{@"1": @"Monday",         //key: value
//                               @"2": @"Tuesday",
//                               @"3": @"Wednesday",
//                               @"4": @"Thursday",
//                               @"5": @"Friday",
//                               @"6": @"Saturday",
//                               @"7": @"Sunday"};
//    
//    
//    
//    CustomLog(@"\n****  initWithDictionary  ****");
//    NSDictionary *myDictionary2_1 = [[NSDictionary alloc] initWithDictionary:initTmp2];
//    CustomLog(@"\nmyDictionary2_1 = %@",myDictionary2_1);
//    
//    
//    
//    CustomLog(@"\n****  initWithDictionary: copyItems:  ****");
//    NSDictionary *myDictionary2_2 = [[NSDictionary alloc] initWithDictionary:initTmp2 copyItems:YES];
//    CustomLog(@"\nmyDictionary2_2 = %@",myDictionary2_2);
//    
//    
//    
//    
//    CustomLog(@"\n****  initWithObjects: forKeys:  ****");                //这里用的只能是NSArray形式的参数
//    NSDictionary *myDictionary2_3 = [[NSDictionary alloc] initWithObjects:@[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"]
//                                                                  forKeys:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7"]];
//    CustomLog(@"\nmyDictionary2_3 = %@",myDictionary2_3);
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithObjects: forKeys: count: ****");          //这里用的只能是C数组形式的参数
//    NSString *values2_4[7];
//    values2_4[0] = @"Monday";
//    values2_4[1] = @"Tuesday";
//    values2_4[2] = @"Wednesday";
//    values2_4[3] = @"Thursday";
//    values2_4[4] = @"Friday";
//    values2_4[5] = @"Saturday";
//    values2_4[6] = @"Sunday";
//    
//    NSString *keys2_4[7];
//    keys2_4[0] = @"1";
//    keys2_4[1] = @"2";
//    keys2_4[2] = @"3";
//    keys2_4[3] = @"4";
//    keys2_4[4] = @"5";
//    keys2_4[5] = @"6";
//    keys2_4[6] = @"7";
//    
//    NSDictionary *myDictionary2_4 = [NSDictionary dictionaryWithObjects:values2_4
//                                                                forKeys:keys2_4
//                                                                  count:5];
//    CustomLog(@"\nmyDictionary2_4 = %@",myDictionary2_4);
//    
//    
//    
//    CustomLog(@"\n****  dictionaryWithObjects: forKeys: count: ****");          //和开始的时候直接初始化很像,但是这里的方式全部都是逗号(,)
//    NSDictionary *myDictionary2_5 = [NSDictionary dictionaryWithObjectsAndKeys: @"value1", @"key1", @"value2", @"key2", nil];
//    CustomLog(@"\nmyDictionary2_5 = %@",myDictionary2_5);
    
    
    
    
    
    
#pragma mark -- Creating Key Sets for Shared-Key Optimized Dictionaries --
    CustomLog(@"\n3.___Creating Key Sets for Shared-Key Optimized Dictionaries___");
    
    
    
    
    
    
#pragma mark -- Counting Entries --
    CustomLog(@"\n4.___Counting Entries___");
//    NSDictionary *initTmp4 = @{@"1": @"Monday",         //key: value
//                               @"2": @"Tuesday",
//                               @"1": @"Wednesday",          //key重复的将不能成功写入，count = 6
//                               @"4": @"Thursday",
//                               @"5": @"Friday",
//                               @"6": @"Saturday",
//                               @"7": @"Sunday"};
//    CustomLog(@"\n****  count  ****");
//    CustomLog(@"\ninitTmp4 中有%lu个Entry(键值对)!", (unsigned long)[initTmp4 count]);
    
    
    
    
   
#pragma mark -- Comparing Dictionaries --
    CustomLog(@"\n5.___Comparing Dictionaries___");
//    NSDictionary *initTmp5 = @{@"1": @"Monday",         //key: value
//                               @"2": @"Tuesday",
//                               @"3": @"Wednesday",
//                               @"4": @"Thursday",
//                               @"5": @"Friday",
//                               @"6": @"Saturday",
//                               @"7": @"Sunday"};
//    CustomLog(@"\n****  isEqualToDictionary: ****");
//    NSDictionary *myDictionary5_1 = [NSDictionary dictionaryWithDictionary:initTmp5];    
////    NSDictionary *myDictionary5_1 = @{@"2": @"Tuesday",         //key: value
////                               @"1": @"Monday",
////                               @"3": @"Wednesday",
////                               @"4": @"Thursday",
////                               @"5": @"Friday",
////                               @"6": @"Saturday",
////                               @"7": @"Sunday"};
//    //key和value必须都对应才可以返回YES，顺序可以是乱的
//    CustomLog(@"\nmyDictionary5_1 isEqualTo initTmp4 ?  Answer is %@ .", [myDictionary5_1 isEqualToDictionary: initTmp5] ? @"YES" : @"NO");
    
    
    
    
    
    
#pragma mark -- Accessing Keys and Values --
    CustomLog(@"\n6.___Accessing Keys and Values___");
//    NSDictionary *initTmp6 = @{@"1": @"Monday",         //key: value
//                               @"2": @"Tuesday",
//                               @"3": @"Wednesday",
//                               @"1": @"Thursday",
//                               @"5": @"Tuesday",
//                               @"7": @"Saturday",
//                               @"7": @"Sunday"};
//    CustomLog(@"\n****  allKeys  ****");
//    //相同的key只输出一次
//    CustomLog(@"\ninitTmp6 的 allKeys: %@", [initTmp6 allKeys]);
//    
//
//    
//    CustomLog(@"\n****  allKeysForObject  ****");
//    NSString *targetObj = @"Tuesday";
//    CustomLog(@"\ninitTmp6 中 Value 为 %@ 的Key有:%@", targetObj, [initTmp6 allKeysForObject:targetObj]);
//    
//    
//    
//    CustomLog(@"\n****  allValues  ****");
//    //当有相同的key存在时，只输出其中的一个
//    CustomLog(@"\ninitTmp6 的 allValues: %@", [initTmp6 allValues]);
//    
//    
//    
//    CustomLog(@"\n****  objectForKey:  ****");
//    NSString *targetKey = @"3";
//    CustomLog(@"\ninitTmp6 中 Key:%@对应的Value是: %@", targetKey, [initTmp6 objectForKey: targetKey]);
//    
//    
//    
//    CustomLog(@"\n****  objectForKeyedSubscript:  ****");
//    NSString *targetKey_1 = @"3";
//    CustomLog(@"\ninitTmp6 中 Key:%@对应的Value是: %@", targetKey, [initTmp6 objectForKeyedSubscript: targetKey_1]);
//    
//    
//    
//    
//    CustomLog(@"\n****  objectsForKeys:notFoundMarker:  ****");
//    NSArray *targetKeys = @[@"3",@"4",@"8"];
//    CustomLog(@"\ninitTmp6 中 Key:%@对应的Value是: %@", targetKey, [initTmp6 objectsForKeys:targetKeys notFoundMarker:@"fuck"]); //notFoundMarker:找不到Key时默认的返回值
//    
//    
//    
//    CustomLog(@"\n****  valueForKey:  ****");
//    NSString *targetKey_2 = @"3";
//    CustomLog(@"\ninitTmp6 中 Key:%@对应的Value是: %@", targetKey, [initTmp6 valueForKey: targetKey_2]);     //这个时KVC定义的取值方式
    
    
    
    
    
#pragma mark -- Enumerating Dictionaries --
    CustomLog(@"\n7.___Enumerating Dictionaries___");
//    NSDictionary *initTmp7 = @{@"1": @"Monday",         //key: value
//                               @"2": @"Tuesday",
//                               @"3": @"Wednesday",
//                               @"4": @"Thursday",
//                               @"5": @"Friday",
//                               @"6": @"Saturday",
//                               @"7": @"Sunday"};
//    
//    
//    
//    CustomLog(@"\n****  keyEnumerator  ****");
//    NSEnumerator *enumerator = [initTmp7 keyEnumerator];        //将Key转换成枚举
//    id key;
//    while ((key = [enumerator nextObject])) {
//        /* code that uses the returned key */
//        CustomLog(@"\n%@", key);
//    }
//    
//    
//    
//    
//    CustomLog(@"\n****  objectEnumerator  ****");
//    NSEnumerator *enumerator_1 = [initTmp7 objectEnumerator];   //将Value转换成枚举
//    id key_1;
//    while ((key_1 = [enumerator_1 nextObject])) {
//        /* code that uses the returned key */
//        CustomLog(@"\n%@", key_1);
//    }
//    
//    
//    
//    /*
//        NSDictionary有一个方法叫enumerateKeysAndObjectsUsingBlock，它就一个参数就是block，这个block携带了三个参数，这将要把dictionary
//        里面的key和value每次一组传递到block，enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给
//        你，每组都会执行这个block。这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个ENOUGH的key，然后就
//        会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block。
//     */
//    CustomLog(@"\n****  enumerateKeysAndObjectsUsingBlock  ****");
//    [initTmp7 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSString *tmp = @"";
//        if([key isKindOfClass:[NSString class]]) {
//            tmp = key;
//            if ([tmp isEqual:@"1"])
//                *stop = YES;        //注意这里是给 *stop 赋值，同时Block上的格式是这样的：^(id key, id obj, BOOL *stop)不能带有_Nonnull
//        }
//        CustomLog(@"\n%@", tmp);
//    }];
//    
//    
//    
//    
//    
//    
//    /*
//        enumerateKeysAndObjectsUsingBlock  和  
//        enumerateKeysAndObjectsWithOptions: usingBlock:
//        遍历执行block会分配在多核cpu上执行（底层很可能就是gcd的并发queue），对于耗时的任务来说是很值得这么做的，
//        而且在以后cpu升级成更多核心后不用改代码也可以享受带来的好处。同时，对于遍历的外部是保持同步的（遍历都完成后才继续执行下一行），
//        猜想内部大概是gcd的dispatch_group或者信号量控制。
//     */
//    CustomLog(@"\n****  enumerateKeysAndObjectsWithOptions: usingBlock:  ****");
//    //NSEnumerationConcurrent不进行顺序同步，NSEnumerationReverse保持按正常顺序输出，和enumerateKeysAndObjectsUsingBlock的效果一致
//    [initTmp7 enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id key, id obj, BOOL * _Nonnull stop) {
//        NSString *tmp = @"";
//        if([key isKindOfClass:[NSString class]]) {
//            tmp = key;
//            if ([tmp isEqual:@"1"])
//                *stop = YES;            //注意这里是给 *stop 赋值，同时Block上的格式是这样的：^(id key, id obj, BOOL *stop)
//        }
//        CustomLog(@"\n%@", tmp);
//    }];
    
    
    
    
    
    
    
#pragma mark -- Sorting Dictionaries --
    CustomLog(@"\n8.___Sorting Dictionaries___");
//    NSDictionary *initTmp8 = @{@"1": @"Monday",         //key: value
//                               @"2": @"Tuesday",
//                               @"3": @"Wednesday",
//                               @"4": @"Thursday",
//                               @"5": @"Friday",
//                               @"6": @"Saturday",
//                               @"7": @"Sunday"};
//    
//    
//    
//    
//    CustomLog(@"\n****  keysSortedByValueUsingSelector:  ****");
//    //算了，还是没搞明白怎么用
////    CustomLog(@"\n%@", [initTmp8 keysSortedByValueUsingSelector:@selector(mySortCompareSelector:)]);
//    
//    
//    //还有几个类似的方法，以后再看吧
    
    
    
    
    
#pragma mark -- Filtering Dictionaries --
    CustomLog(@"\n9.___Filtering Dictionaries___");
    
    
    
    
    
    
    
    
#pragma mark -- Storing Dictionaries --
    CustomLog(@"\n10.___Storing Dictionaries___");
    NSDictionary *initTmp10 = @{@"1": @"Monday",         //key: value
                                @"2": @"Tuesday",
                                @"3": @"Wednesday",
                                @"4": @"Thursday",
                                @"5": @"Friday",
                                @"6": @"Saturday",
                                @"7": @"Sunday"};
    CustomLog(@"\n****  writeToFile: atomically:  ****");
    NSString *myFilePath = [NSTemporaryDirectory() stringByAppendingString:@"/dicFile/text.plist"];
    if([initTmp10 writeToFile:myFilePath atomically:NO]) {
        CustomLog(@"\n文件写入成功！");
    } else {
        CustomLog(@"\n文件写入失败！");
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






/**
    keysSortedByValueUsingSelector:   对应的方法
 */

- (NSComparisonResult) mySortCompareSelector: (NSString*) other
{
    static float floatValue = 3.5;
    float myValue = floatValue;
    float otherValue= [other floatValue];
    if(myValue == otherValue)
        return NSOrderedSame;
    return (myValue < otherValue ? NSOrderedAscending : NSOrderedDescending);
}








































@end
