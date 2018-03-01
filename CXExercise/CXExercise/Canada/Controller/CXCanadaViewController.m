//
//  CXCanadaViewController.m
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXCanadaViewController.h"

#import "CXCanadaCell.h"
#import "CXCanadaLayout.h"

/// 重用标示符
static NSString *const kCXCanadaCellIdentifier = @"CXCanadaCellID";

@interface CXCanadaViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_title;
    
    NSInteger _limitPage;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, copy) NSMutableArray *datasource;

@end

@implementation CXCanadaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMainTableView];
    
    [self requestData];
}
    
- (void)setUpMainTableView {
    
    __weak typeof(self) weakSelf = self;
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _limitPage = 1;
        [weakSelf requestData];
    }];
    _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _limitPage++;
        [weakSelf requestData];
    }];
}


#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CXCanadaCell *cell = [tableView dequeueReusableCellWithIdentifier:kCXCanadaCellIdentifier];
    if (!cell) {
        cell = [[CXCanadaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCXCanadaCellIdentifier];
    }
    
    CXCanadaLayout *layout = _datasource[indexPath.row];
    [cell setLayout:layout];
    
    // 下载图片
    if (layout.canada.canada_imageHref.length > 0 && !layout.canada.canada_img) {
        [self startPicDownload:layout forIndexPathRow:indexPath.row];
    }
    
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((CXCanadaLayout *)self.datasource[indexPath.row]).height + 20;
}

#pragma mark - lazy
- (NSMutableArray *)datasource {
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    
    return _datasource;
}


#pragma mark - Http
- (void)requestData {
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://thoughtworks-ios.herokuapp.com/facts.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [_mainTableView.mj_header endRefreshing];
            [_mainTableView.mj_footer endRefreshing];
        } else {
            _title = responseObject[@"title"] ? responseObject[@"title"] : @"title";
            weakSelf.title = _title;
            
            if (_limitPage == 1) {
                [weakSelf.datasource removeAllObjects];
            }
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:[CXCanadaModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]]];
            for (CXCanadaModel *model in tempArray) {
                if (model.canada_title.length == 0 && model.description.length == 0 && model.canada_imageHref.length == 0) {
                    NSLog(@"无效数据");
                } else {
                    CXCanadaLayout *layout = [[CXCanadaLayout alloc] initWithCanada:model];
                    [weakSelf.datasource addObject:layout];
                }
            }
          
            [weakSelf.mainTableView reloadData];
            [_mainTableView.mj_header endRefreshing];
            [_mainTableView.mj_footer endRefreshing];
        }
    }];
    [dataTask resume];
}
    
//开始下载图像
- (void)startPicDownload:(CXCanadaLayout *)item forIndexPathRow:(NSInteger)row {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:[NSURL URLWithString:item.canada.canada_imageHref] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (image) { // 图片下载成功，刷新界面
            NSLog(@"终于下载成功了！");
            //一个cell刷新
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:0];
            [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            NSLog(@"图片链接有问题！%@", imageURL);
        }

    }];
    
}
@end
