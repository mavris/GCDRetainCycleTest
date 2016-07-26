//
//  GCDVC.m
//  GCDRetainCycleTest
//
//  Created by Michael Mavris on 26/07/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import "GCDVC.h"

@interface GCDVC ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)NSMutableArray *proArray;
@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.proArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startGCD:(id)sender {

    GCDVC* __weak weakSelf = self;
    
    [self.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        
        // VC2* __strong strongSelf = weakSelf;
        
        [weakSelf.proArray addObject:@"2"];
        
        [NSThread sleepForTimeInterval:10];
        
        NSLog(@"%@",weakSelf.proArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
            [weakSelf.activityIndicator stopAnimating];
        });
    });

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
