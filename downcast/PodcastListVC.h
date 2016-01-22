//
//  ViewController.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+EmptyDataSet.h>

@interface PodcastListVC : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

- (IBAction)refreshList:(id)sender;

@end
