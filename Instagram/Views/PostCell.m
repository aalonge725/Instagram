#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)refreshData:(Post *)post {
    self.post = post;
    self.image.file = self.post.image;
    [self.image loadInBackground];
    self.caption.text = self.post.caption;
    self.timestamp.text = [NSDateFormatter localizedStringFromDate:self.post.createdAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

@end
