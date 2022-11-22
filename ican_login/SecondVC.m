//
//  SecondVC.m
//  ican_login
//
//  Created by iCan Lanka on 2022/11/11.
//

#import "SecondVC.h"
#import "ViewController.h"
#import "ProfileCell.h"

@interface SecondVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *imageNameArray;
    
    __weak IBOutlet UITableView *table;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property  NSInteger selectedIndex;

@end

@implementation SecondVC
@synthesize selectedIndex;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedIndex = -1;
 
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *result = [self getDataFrom:@"https://jsonplaceholder.typicode.com/posts"];

    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    cell.avatar.image = [UIImage imageNamed:@"person-circle"];
    cell.nameLbl.text = @"Manuka Dewanarayana";
    cell.descLbl.text = [[result valueForKey:@"body"] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
//    if (selectedIndex == -1)
//    {
//        NSIndexPath *prev = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
//        selectedIndex=indexPath.row;
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prev] withRowAnimation:UITableViewRowAnimationFade];
//    }
    selectedIndex=indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    selectedIndex= indexPath.row;
//    NSLog(@"%d", selectedIndex);
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedIndex == indexPath.row){
        return 120;
    }
    else{
        return 70;
    }
}


- (NSMutableDictionary *) getDataFrom:(NSString *)url{
    __block NSMutableDictionary *resultsDictionary;
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: @"userId",@"id",@"title",@"body", nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    resultsDictionary = [NSJSONSerialization JSONObjectWithData:oResponseData options:NSJSONReadingMutableLeaves error:&error];
    return resultsDictionary;
}

@end


//    static NSString *cellIdentifier = @"cellID";
//    NSMutableDictionary *result = [self getDataFrom:@"https://jsonplaceholder.typicode.com/posts"];
//    imageNameArray = [NSMutableArray arrayWithArray:@[@"2.jpg"]];

//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:
//        UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
     
//    NSNumber *id = [[result valueForKey:@"id"] objectAtIndex:indexPath.row];
//    cell.textLabel.text = [id stringValue];
//    cell.description
//    cell.textLabel.text = [[result valueForKey:@"title"] objectAtIndex:indexPath.row];


//    NSLog(@"Hello1");
//    NSMutableDictionary *result = [self getDataFrom:@"https://jsonplaceholder.typicode.com/posts"];
//    NSLog(@"%@",result);
//    NSLog(@"Hello123");
