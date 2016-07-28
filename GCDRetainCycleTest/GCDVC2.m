//
//  GCDVC.m
//  GCDRetainCycleTest
//
//  Created by Michael Mavris on 26/07/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import "GCDVC2.h"

typedef void(^CustomBlock)(void);

@interface GCDVC2 ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)NSMutableArray *proArray;
@property (nonatomic, copy) CustomBlock addObjectsBlock;
@property (nonatomic, copy) CustomBlock postGCDBlock;
@end

@implementation GCDVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.proArray = [[NSMutableArray alloc]init];
    
    
    self.postGCDBlock = ^{
        [self.proArray removeObject:@"3"];
        [self.activityIndicator stopAnimating];
    };
    
    self.addObjectsBlock = ^{
        
        [self.proArray addObject:@"2"];
        
        [NSThread sleepForTimeInterval:10];
        
        NSLog(@"%@",self.proArray);
        
        dispatch_async(dispatch_get_main_queue(),self.postGCDBlock);
    };
    
    
}

- (IBAction)startGCDRetainCycle:(id)sender {
    
    [self.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), self.addObjectsBlock);
    
}

@end
