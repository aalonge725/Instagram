@import Parse;
#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"

@interface ProfileViewController ()

- (IBAction)didTapLogout:(UIButton *)sender;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapLogout:(UIButton *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                                            
        [[UIApplication sharedApplication].keyWindow setRootViewController:loginViewController];
    }];
}

@end
