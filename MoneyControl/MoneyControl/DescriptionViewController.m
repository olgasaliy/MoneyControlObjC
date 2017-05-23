//
//  DescriptionViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 11.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()<UITextViewDelegate>



@end

@implementation DescriptionViewController
//- (IBAction)hide:(id)sender {
//        [self.view endEditing:YES];
//    
//}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    //handle user taps text view to type text
}

//-(void)textViewDidChangeSelection:(UITextView *)textView {
//    NSLog(@"textViewDidChangeSelection");
//}

-(void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textViewDidChange");
    [_record setDescr:_text.text];
}
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    NSLog(@"textViewDidEndEditing");
//    [_record setDescr:_text.text];
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch * touch = [touches anyObject];
//    if(touch.phase == UITouchPhaseBegan) {
//        [_text resignFirstResponder];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Назад";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    _text = [[UITextView alloc] initWithFrame:self.view.frame];
    [_text setFont:[UIFont systemFontOfSize:17.0]];
    _text.delegate = self;
    [self.view addSubview:_text];
    [self.text setText:_record.descr];

    // Do any additional setup after loading the view.
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
