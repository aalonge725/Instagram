#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UITextView *caption;
- (IBAction)didTapCancel:(UIBarButtonItem *)sender;
- (IBAction)didTapSubmit:(UIBarButtonItem *)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.caption.layer.borderWidth = 2.0f;
    self.caption.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.caption.layer.cornerRadius = 5;
}

- (IBAction)onTap:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"Cam available");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Photo" message:@"Would you like to take or select a photo?" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }];
        [alert addAction:takePhotoAction];
        
        UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }];
        [alert addAction:selectPhotoAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    [self.image setImage:editedImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSubmit:(UIBarButtonItem *)sender {
    [Post postUserImage:self.image.image withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            // TODO: handle error
            NSLog(@"Error posting picture: %@", error.localizedDescription);
        } else {
            // TODO: handle successful post
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"Posted image successfully");
        }
    }];
}

- (IBAction)didTapCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
