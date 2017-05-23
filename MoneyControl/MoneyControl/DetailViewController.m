//
//  DetailViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 06.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "DetailViewController.h"
#import "RecordTableViewController.h"
#import "ViewController.h"


@interface DetailViewController ()

//@property(nonatomic,strong) IBOutlet UINavigationBar *navBar;
//@property (nonatomic,strong) IBOutlet UIButton *photo;
//@property (nonatomic,strong) IBOutlet UILabel *sum;
//@property (nonatomic,strong) IBOutlet UILabel *date;
//@property (nonatomic,strong) IBOutlet UITextView *descr;

@end

@implementation DetailViewController

- (IBAction)deleteRecord:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Удаление объекта"
                                                                   message:@"Успешно удалено!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          [_user removeRecord:_record];
                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
//    
//    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Изменить" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];//!!!!!!!!!!!!!!!!!!!!!
//    self.navigationItem.rightBarButtonItem = anotherButton;
//    self.navigationItem.title = _record.categoryName;
//    self.sum.text = _record.price;
//    self.date.text = _record.date;
//    self.descr.text = [NSString stringWithFormat:@"%@. %@", _record.isIncome, _record.descr];
//    if ([_record ifImageIsNil]) {
//        [self.photo setTitle:@"Нет фото" forState:UIControlStateNormal];
//        [self.photo setEnabled:NO];
//    }
//    else {
//        [self.photo setEnabled:NO];
//        [self.photo setTitle:@"Показать" forState:UIControlStateNormal];
//    }

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed"]) {
        // can't assign the view controller from an embed segue via the storyboard, so capture here
        RecordTableViewController* myTable = (RecordTableViewController *)segue.destinationViewController;
        myTable.record = _record;
    }
//    if ([segue.identifier isEqualToString:@"segueRemove"]) {
//        ViewController* root = (ViewController *)segue.destinationViewController;
//    }
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
