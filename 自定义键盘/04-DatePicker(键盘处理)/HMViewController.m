//
//  HMViewController.m
//  04-DatePicker(键盘处理)
//
//  Created by Vincent_Guo on 14-8-26.
//  Copyright (c) 2014年 vgios. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UITextField *birthdayFiled;

@property(nonatomic,weak)UIDatePicker *datePicker;//日期选择

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置datepicker的本地化
    NSArray *idents = [NSLocale availableLocaleIdentifiers];
    NSLog(@"%@",idents);
    //设置datepicker的本地化为中国
    datePicker.locale = [NSLocale
                         localeWithLocaleIdentifier:@"zh"];
    
    //设置datepicker模式
    datePicker.datePickerMode = UIDatePickerModeDate;//只显示日期，不显示时间
    //设置textFiled键盘
    self.birthdayFiled.inputView = datePicker;
    
    
//    UIView *grayView = [[UIView alloc] init];
//    grayView.bounds = CGRectMake(0, 0, 320, 44);
//    grayView.backgroundColor = [UIColor purpleColor];
    //代码创建UIToolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
#warning 一定要设置bounds 否则UIBarButtonItem监听不了点击事件
    toolbar.bounds = CGRectMake(0, 0, 320, 44);
    toolbar.backgroundColor = [UIColor grayColor];
    
    //创建上一个按钮
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //创建下一个按钮
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //弹簧
    UIBarButtonItem *tanhuangBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //创建完成按钮
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelectedDate)];
    
    
    
    //[toolbar setItems:<#(NSArray *)#>]
    toolbar.items = @[previous,next,tanhuangBtn,finish];
    
    //设置inputAccessoryView在，就能在键盘上面添加辅助的view
    self.birthdayFiled.inputAccessoryView = toolbar;
    
    self.datePicker = datePicker;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)finishSelectedDate{
    //获取时间
    NSDate *selectedDate = self.datePicker.date;
   
    //格式化日期(2014-08-25)
    //格式化日期类
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    //设置日期格式
    formater.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [formater stringFromDate:selectedDate];
    NSLog(@"%@",dateStr);
    
    //设置textfiled的文本
    
    self.birthdayFiled.text = dateStr;
    
    //隐藏键盘
    [self.birthdayFiled resignFirstResponder];
}

@end
