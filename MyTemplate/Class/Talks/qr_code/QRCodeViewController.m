//
//  QRCodeViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/11/18.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "QRCodeViewController.h"
#import <Masonry.h>
#import <ZXingObjC.h>




@interface QRCodeViewController ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *myScanButton;       //“扫一扫”按钮
@property (nonatomic, strong) UILabel *myScanResultLabel;       //扫一扫结果


@end





@implementation QRCodeViewController



- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftBarButtonItemStyle = UILeftBarButtonItemStyleImage;
        self.sideSlipForNavBackWorked = YES;
        self.hidesBottomBarWhenPushed = YES;        //隐藏底部导航Bar
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二维码";
    
    
#pragma mark -- “扫一扫”按钮 --
    _myScanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myScanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_myScanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myScanButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myScanButton setBackgroundColor:[UIColor redColor]];
    [_myScanButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myScanButton];
    [_myScanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
#pragma mark -- “扫一扫”结果显示 --
    if(!_myScanResultLabel)
        _myScanResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _myScanResultLabel.textColor = [UIColor blackColor];
    _myScanResultLabel.font = [UIFont systemFontOfSize:15];   //字体一定要设置
    _myScanResultLabel.numberOfLines = 0;                     //无限换行一定要设置
    _myScanResultLabel.text = @"解析二维码的内容会出现在这里😄";
    _myScanResultLabel.textAlignment = NSTextAlignmentLeft;
    //    _myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _myScanResultLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_myScanResultLabel];
    [_myScanResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH * 0.9);
        make.top.equalTo(_myScanButton.mas_bottom).offset(20);
        make.height.mas_equalTo(200);
        make.centerX.equalTo(self.view);
    }];
}



/**
    打开相机
 */
-(void) takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else {
        NSLog(@"该设备无摄像头");
    }
}


/**
    ZXing 编码
 */
- (UIImage *) QREncodeByZXing:(NSString *) str {

    NSError *error = nil;
    UIImage* retImage = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:str
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        retImage = [UIImage imageWithCGImage: image];
        
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        CustomLog(@"\n%@",retImage);
    }
    
    return retImage;
}



/**
    ZXing 解码
 */
- (NSString *) QRDecodeByZXing:(UIImage *) img {
    
    if(!img.CGImage)
        return nil;
    
    
    CGImageRef imageToDecode = img.CGImage;  // Given a CGImage in which we are looking for barcodes
    
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        return contents;
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
        return @"未能正确解析图片中的信息";
    }
}



#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        
        //解析图片中的文字信息
        _myScanResultLabel.text = [self QRDecodeByZXing:image];
        
//        //以下是保存文件到沙盒路径下
//        //把图片转成NSData类型的数据来保存文件
//        NSData *data;
//        //判断图片是不是png格式的文件
//        if (UIImagePNGRepresentation(image)) {
//            data = UIImagePNGRepresentation(image);
//        }else {
//            data = UIImageJPEGRepresentation(image, 1.0);
//        }
//        //保存
//        [[NSFileManager defaultManager] createFileAtPath:self.imagePath contents:data attributes:nil];
        
    }
    //关闭相册界面
    [picker dismissModalViewControllerAnimated:YES];
}

@end
