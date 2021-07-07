#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"

@interface HomeViewController ()

- (IBAction)didTapLogout:(UIBarButtonItem *)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapLogout:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                                            
        [[UIApplication sharedApplication].keyWindow setRootViewController:loginViewController];
    }];
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
