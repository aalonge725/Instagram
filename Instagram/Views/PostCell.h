#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *timestamp;
@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) Post *post;

- (void)refreshData:(Post *)post;

@end

NS_ASSUME_NONNULL_END
