#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "DetailsViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<Post *> *posts;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (IBAction)didTapLogout:(UIBarButtonItem *)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    if (selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:animated];
    }
}

- (void)fetchPosts {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKeys:@[@"author", @"createdAt", @"username"]];
    postQuery.limit = 20;

    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
}

- (IBAction)didTapLogout:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                                            
        [[UIApplication sharedApplication].keyWindow setRootViewController:loginViewController];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.posts[indexPath.row];
    [cell setData:post];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"detailsSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        
        DetailsViewController *detailViewController = [segue destinationViewController];
                
        detailViewController.post = post;        
    }
}

@end
