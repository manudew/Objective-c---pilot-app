//
//  ViewController.m
//  ican_login
//
//  Created by iCan Lanka on 2022/11/10.
//

#import "ViewController.h"
#import "SecondVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIView *nameView;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UIView *passwordview;
@property (weak, nonatomic) IBOutlet UIImageView *splash;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameView.layer.cornerRadius = 16;
    self.passwordview.layer.cornerRadius = 16;
    [self pulse: _splash toSize:1.5 withDuration: 2];
    
}

-(void)dataPost{
    NSString *title = self.mobileTextField.text;
    NSString *body = self.usernameTextField.text;
    NSString *userId = @"1";
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"]];

    NSString *userUpdate =[NSString stringWithFormat:@"title=%@&body=%@&userId=%@",title,body,userId];

    //create the Method "GET" or "POST"
    [urlRequest setHTTPMethod:@"POST"];

    //Convert the String to Data
    NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];

    //Apply the data to the body
    [urlRequest setHTTPBody:data1];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if(httpResponse.statusCode == 200)
//        {
//            NSError *parseError = nil;
//            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//            NSLog(@"The response is - %@",responseDictionary);
//            NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
//            if(success == 1)
//            {
//                NSLog(@"Login SUCCESS");
//            }
//            else
//            {
//                NSLog(@"Login FAILURE");
//            }
//        }
//        else
//        {
//            NSLog(@"Error");
//        }
    }];
    [dataTask resume];
}

- (IBAction)formSubmitted:(id)sender {

//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SecondVC *View = [board instantiateViewControllerWithIdentifier:@"SecondVC"];
//
//    [self.navigationController pushViewController:View animated:YES];
    
    
    
    UIStoryboard *board;
            board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SecondVC *View = [board instantiateViewControllerWithIdentifier:@"SecondVC"];
            View.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:View animated:YES];
            [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    UIStoryboard *board;
//            board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            SecondVC *View = [board instantiateViewControllerWithIdentifier:@"SecondVC"];
//            View.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:View animated:YES];
//            [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    [self dataPost];
}

- (void)pulse:(UIImageView*)view toSize: (float) value withDuration:(float) duration
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = duration;
    pulseAnimation.toValue = [NSNumber numberWithFloat:value];;
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
   
    [view.layer addAnimation:pulseAnimation forKey:nil];
}


@end


