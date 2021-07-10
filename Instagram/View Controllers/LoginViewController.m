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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Signup" message:@"Username and password must be nonempty" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error == nil) {
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
        }];
    }
}

- (IBAction)didTapLogin:(UIButton *)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Login" message:@"Username and password must be nonempty" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error == nil) {
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
        }];
    }
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

@end
