#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)didTapLogin:(UIButton *)sender;
- (IBAction)didTapSignUp:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapSignUp:(UIButton *)sender {
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        // TODO: alert
    } else {
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
        }];
    }
}

- (IBAction)didTapLogin:(UIButton *)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        // TODO: alert
    } else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
        }];
    }
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
