//
//  RecordTableViewController.m
//  MoneyControl
//
//  Created by Olga Saliy on 09.05.17.
//  Copyright © 2017 home. All rights reserved.
//

#import "RecordTableViewController.h"
#import "CategoriesTableViewController.h"
#import "DescriptionViewController.h"
#import "PhotoViewController.h"

@interface RecordTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIDatePicker *datePicker;
}
@property (weak, nonatomic) IBOutlet UITextField *sum;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UIImageView *category;
@property (weak, nonatomic) IBOutlet UILabel *descr;

@end

@implementation RecordTableViewController


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    //self.imageView.image = chosenImage;
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
    UIAlertAction * viewAction = [UIAlertAction actionWithTitle:@"Просмотреть фото" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        PhotoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"photo"];;
        vc.record = _record;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:cameraAction];
    [alertController addAction:galleryAction];
    if (_record.img)
        [alertController addAction:viewAction];
    return alertController;
}


-(IBAction)pressedPhoto:(id)sender {
    [self presentViewController:[self prepareActionSheet] animated: YES completion: nil];
}

//for reloading row
-(void)viewWillAppear:(BOOL)animated {
    [self.categoryName setText:_record.category.name];
    [self.category setImage:_record.category.image];
    [self.descr setText:_record.descr];
}

- (IBAction)pressed:(id)sender {
}

-(void)textFieldDidChange :(UITextField *) textField{
    self.record.price = (NSUInteger)[textField.text integerValue];
    //[self.tableView reloadData];
}

-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd.MM.YYYY"];
    self.dateTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.dateTextField resignFirstResponder];
    self.record.d = datePicker.date;
    self.record.date = self.dateTextField.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.sum setText:[NSString stringWithFormat:@"%lu",_record.price]];
    [self.sum setTextColor: _record.category.isIncoming? [UIColor colorWithRed:0.0/255.0 green:152.0/255.0 blue: 0.1/255.0 alpha:1.0] : [UIColor redColor]];
    [self.dateTextField setText:_record.date];
    
    
    
    [_sum addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    [self.dateTextField setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[toolBar setTintColor:[UIColor grayColor]];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Готово" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.dateTextField setInputAccessoryView:toolBar];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueCategory"]) {
        CategoriesTableViewController *ctvc = (CategoriesTableViewController*)segue.destinationViewController;
        ctvc.record = _record;
        
    }
    if ([segue.identifier isEqualToString:@"segueDescr"]) {
        DescriptionViewController *svc = (DescriptionViewController*)segue.destinationViewController;
        svc.record = _record;
        
    }
//    if ([segue.identifier isEqualToString:@"seguePhoto"]) {
//        if (_record.img) {
//            PhotoViewController *pvc = (PhotoViewController*)segue.destinationViewController;
//            pvc.record = _record;
//        }
//    }
}


@end
