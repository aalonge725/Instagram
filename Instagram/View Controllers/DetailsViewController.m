#import "DetailsViewController.h"
#import "Post.h"
@import Parse;

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet PFImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *timestamp;
@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet UILabel *username;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData:self.post];
}

- (void)refreshData:(Post *)post {
    self.post = post;
    self.image.file = self.post.image;
    [self.image loadInBackground];
    self.caption.text = self.post.caption;
    self.username.text = self.post.author.username;
    self.timestamp.text = [NSDateFormatter localizedStringFromDate:self.post.createdAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

@end
