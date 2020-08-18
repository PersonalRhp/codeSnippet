//
//  ViewController.m
//  tableViewPreload
//
//  Created by 饶鸿平 on 2020/8/7.
//  Copyright © 2020 饶鸿平. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "CustomCodeTableViewCell.h"
#import "BaseModel.h"
#import <MJExtension/MJExtension.h>

@interface ViewController () <
UITableViewDelegate,
UITableViewDataSource,
NSURLSessionDelegate,
NSURLSessionTaskDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, strong) BaseModel *model;  //

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];

    [self loadData];
}

- (void)setUpView {
    [self.view addSubview:self.tableView];
}

- (void)loadData {
    NSURL *url = [NSURL URLWithString:@"https://api.timing360.com/page-circle-homepage/home-page-recommend"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"userID=%d&userKey=%@",1529908, @"ewT44p8szg7F6JBiyZDVGo32TvSSL-rR"];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    request.timeoutInterval = 30.0;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        self.model = [BaseModel mj_objectWithKeyValues:dict];
        NSLog(@"======%@", self.model);
        BaseModel *model = [self.model copy];
        NSLog(@"============%@", model);
        NSLog(@"======%@", [self.model mutableCopy]);
        self.lists = dict[@"list"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [sessionDataTask resume];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *cardData = self.lists[indexPath.row][@"cardData"];
    NSArray *imageList = cardData[@"imageList"];
    NSString *imageUrl;
    
    if (imageList.count > 0) {
        imageUrl = imageList[0][@"url"];
    } else {
        imageUrl = cardData[@"video"][@"cover"][@"url"];
    }
    
    [cell setUpCustomCellImageUrl:imageUrl];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomTableViewCell class])];
        [_tableView registerClass:[CustomCodeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CustomCodeTableViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)lists {
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    return _lists;
}

@end
