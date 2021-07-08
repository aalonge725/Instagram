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

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    [self.image setImage:originalImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
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
