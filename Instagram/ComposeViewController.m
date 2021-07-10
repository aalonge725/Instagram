#import "ComposeViewController.h"
#import "Post.h"
#import "SceneDelegate.h"
#import "HomeViewController.h"

@interface ComposeViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UITextView *caption;

- (IBAction)didTapCancel:(UIBarButtonItem *)sender;
- (IBAction)didTapSubmit:(UIBarButtonItem *)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextView];
}

- (IBAction)onTap:(id)sender {
    [self createAndShowImagePicker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resized = [self resizeImage:editedImage withSize:CGSizeMake(300, 300)];

    [self.image setImage:resized];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    resizedImage.contentMode = UIViewContentModeScaleAspectFill;
    resizedImage.image = image;

    UIGraphicsBeginImageContext(size);
    [resizedImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

- (IBAction)didTapSubmit:(UIBarButtonItem *)sender {
    [Post postUserImage:self.image.image withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error == nil) {
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                        myDelegate.window.rootViewController = homeViewController;
        }
    }];
}

- (IBAction)didTapCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)configureTextView {
    self.caption.layer.borderWidth = 2.0f;
    self.caption.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.caption.layer.cornerRadius = 5;
}

- (void)createAndShowImagePicker {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
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
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

@end
