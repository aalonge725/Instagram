#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *image;
@property (strong, nonatomic) IBOutlet UITextView *caption;
@property (strong, nonatomic) Post *post;

- (void)refreshData:(Post *)post;

@end

NS_ASSUME_NONNULL_END
