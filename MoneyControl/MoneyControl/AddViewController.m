//
//  AddViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 15.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "AddViewController.h"
#import "ArrayOfCategories.h"
#import "ViewController.h"
#import "Record.h"

@interface AddViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIDatePicker *datePicker;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong) UIButton *lastSelected;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *date;
@property (strong, nonatomic) IBOutlet UITextField *sum;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) Record *record;

@end

@implementation AddViewController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = chosenImage;
    [_record setImg:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(UIAlertController*) prepareActionSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"Сделать фото" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction * galleryAction = [UIAlertAction actionWithTitle:@"Выбрать из галереи" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:cameraAction];
    [alertController addAction:galleryAction];
    return alertController;
}

- (IBAction)pressedOnImage:(id)sender {
    NSLog(@"pressed");
[self presentViewController:[self prepareActionSheet] animated: YES completion: nil];

}
- (IBAction)pressedAdd:(id)sender {
    
    [_record setDescr:_textView.text];
    [_record setCategory: _key ==1? [[ArrayOfCategories returnArrayOfIncomes] objectAtIndex:_lastSelected.tag]: [[ArrayOfCategories returnArrayOfOutcomes] objectAtIndex:_lastSelected.tag]];
    [_user addRecord:_record];
    //((ViewController*)self.navigationController.topViewController).user = _user;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Добавление объекта"
                                                                   message:@"Успешно добавлено!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) selectByBorder: (UIButton*) button {

        CGRect frame = CGRectMake(-15.0, -5.0, button.frame.size.width+30, button.frame.size.height);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:10.0];
        CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
        borderLayer.frame = CGRectMake(0.0, 0.0, button.frame.size.width+30, button.frame.size.height);
        borderLayer.path  = maskPath.CGPath;
        borderLayer.lineWidth   = 1.0f;
        borderLayer.strokeColor = [UIColor colorWithRed:157.0/255.0 green:238.0/255.0 blue: 216.0/255.0 alpha:1.0].CGColor;
        borderLayer.fillColor   = [UIColor clearColor].CGColor;
        [button.layer addSublayer:borderLayer];
    
    
        
}

-(void) buttonSelected :(id)sender{
    if (_lastSelected != nil) {
        _lastSelected.selected = NO;
        for (CALayer *l in _lastSelected.layer.sublayers)
            if ([l isMemberOfClass:[CAShapeLayer class]])
                [l removeFromSuperlayer];
        _lastSelected = nil;
    }
    [self selectByBorder:((UIButton*)sender)];
    ((UIButton*)sender).selected = YES;
    _lastSelected =(UIButton*)sender;
}

-(void)viewWillAppear:(BOOL)animated {
}

-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd.MM.YYYY"];
    self.date.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.date resignFirstResponder];
    self.record.d = datePicker.date;
    self.record.date = self.date.text;
}

-(void)textFieldDidChange :(UITextField *) textField{
    self.record.price = (NSUInteger)[textField.text integerValue];
    //[self.tableView reloadData];
}

-(void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textViewDidChange");
  //  [_record setDescr: _textView.text];
}
- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_user)
        _user = [User returnSingleton];
    //record
    _record = [[Record alloc] init];
    
    self.navigationItem.title = (_key==1? @"Новый доход": @"Новый расход");
    //scroll
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    NSArray *d = _key ==1? [ArrayOfCategories returnArrayOfIncomes]: [ArrayOfCategories returnArrayOfOutcomes];
    int x = 0;
    CGRect frame;
    for (int i = 0; i < d.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        frame = CGRectMake((i * 70) + 30, 10, 30, 60);

        button.frame = frame;
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, 30)];
        imageView1.image =((MyCategory*)[d objectAtIndex:i]).image;
        [button addSubview:imageView1];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(-15, 30, button.frame.size.width+30, 20)];
        [label setFont:[UIFont systemFontOfSize:11]];
        label.textAlignment= NSTextAlignmentCenter;
        label.text = ((MyCategory*)[d objectAtIndex:i]).name;
        [button addSubview:label];
        [button setTag:i];
     

        [_scrollView addSubview:button];
    
        if (i == d.count-1) {
            x = CGRectGetMaxX(button.frame)+30;
        }
        
    }
    
    _scrollView.contentSize = CGSizeMake(x, _scrollView.frame.size.height);
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    //button
    [_button setTitleColor:_key ==1? [UIColor colorWithRed:0.0/255.0 green:152.0/255.0 blue: 0.1/255.0 alpha:1.0]: [UIColor redColor] forState:UIControlStateNormal];
    //for date
    [_sum addTarget:self
             action:@selector(textFieldDidChange:)
   forControlEvents:UIControlEventEditingChanged];
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    [self.date setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[toolBar setTintColor:[UIColor grayColor]];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Готово" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.date setInputAccessoryView:toolBar];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
