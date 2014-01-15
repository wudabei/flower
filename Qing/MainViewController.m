//
//  MainViewController.m
//  Qing
//
//  Created by cannaan on 14-1-8.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "MainViewController.h"
#import "CustomCell.h"
#import "DetailViewsController.h"
#import "GroupBookViewController.h"
#import "GroupSelectDoneViewController.h"
#import "GroupSelectViewController.h"
#import "ProductModel.h"

#define originalHeight 180.0f
#define newHeight 325.0f


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"轻";
       

        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Left", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(left)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu1.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(left)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(right)];
    
    
    myTable = [[HVTableView alloc] initWithFrame:CGRectMake(0, 0, 600, 600) expandOnlyOneCell:YES enableAutoScroll:YES];
    myTable.HVTableViewDelegate = self;
    myTable.HVTableViewDataSource = self;
    [myTable reloadData];
    [self.view addSubview:myTable];
    
    
    // temp
    self.products = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 10; i++) {
        
        NSString *image = [NSString stringWithFormat:@"%d.png",(i + 1)];
        NSDictionary *dic = @{@"image":image,
                              @"description":@"",
                              @"name":@"",
                              @"details":@"",
                              @"imageURL":@""};
    ProductModel *prodect = [[ProductModel alloc] initWithDataDic:dic];
        [self.products addObject:prodect];
    }
}



- (void)left {
    [self.drawerController toggleDrawerSide:XHDrawerSideLeft animated:YES completion:NULL];
}

- (void)right {
    [self.drawerController toggleDrawerSide:XHDrawerSideRight animated:YES completion:^(BOOL finished) {
        
    }];
}

#pragma mark - HVTableView delegate

-(void)tableView:(UITableView *)tableView expandCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainBGLeft.png"]];
    imageView1.frame = CGRectMake(0, 180, 160, 145);
    [btn1 setFrame:imageView1.bounds];
    [imageView1 addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
     UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainBG.png"]];
    imageView2.frame = CGRectMake(160, 180, 160, 145);
    [btn2 setFrame:imageView2.bounds];
    [imageView2 addSubview:btn2];
    imageView1.userInteractionEnabled = YES;
    imageView2.userInteractionEnabled = YES;
//    [btn1 setBackgroundImage:[UIImage imageNamed:@"mainBGLeft.png"] forState:UIControlStateNormal];
//    [btn2 setBackgroundImage:[UIImage imageNamed:@"mainBG.png"] forState:UIControlStateNormal];
    
    [btn1 setTitle:@"组合订购" forState:UIControlStateNormal];
    [btn2 setTitle:@"自由组合" forState:UIControlStateNormal];
//    btn2.titleLabel.text = @"组合订购";
//    btn1.titleLabel.text = @"自定义组合";
    
    btn2.titleLabel.textColor = [UIColor blackColor];
    btn1.titleLabel.textColor = [UIColor blackColor];

    [btn2 addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(push2) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:imageView1];
    [cell.contentView addSubview:imageView2];
    
}


//perform your collapse stuff (may include animation) for cell here. It will be called when the user touches an expanded cell so it gets collapsed or the table is in the expandOnlyOneCell satate and the user touches another item, So the last expanded item has to collapse
-(void)tableView:(UITableView *)tableView collapseCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
	//you can define different heights for each cell. (then you probably have to calculate the height or e.g. read pre-calculated heights from an array
	if (isexpanded)
		return newHeight;

	return originalHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
    
    static NSString *identify = @"tableCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    
    if (isExpanded) //prepare the cell as if it was collapsed! (without any animation!)
	{
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainBGLeft.png"]];
        imageView1.frame = CGRectMake(0, 180, 160, 145);
        [btn1 setFrame:imageView1.bounds];
        [imageView1 addSubview:btn1];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainBG.png"]];
        imageView2.frame = CGRectMake(160, 180, 160, 145);
        [btn2 setFrame:imageView2.bounds];
        [imageView2 addSubview:btn2];
        imageView1.userInteractionEnabled = YES;
        imageView2.userInteractionEnabled = YES;        //    [btn1 setBackgroundImage:[UIImage imageNamed:@"mainBGLeft.png"] forState:UIControlStateNormal];
        //    [btn2 setBackgroundImage:[UIImage imageNamed:@"mainBG.png"] forState:UIControlStateNormal];
        
        [btn1 setTitle:@"组合订购" forState:UIControlStateNormal];
        [btn2 setTitle:@"自由组合" forState:UIControlStateNormal];
//        btn2.titleLabel.text = @"组合订购";
//        btn1.titleLabel.text = @"自由组合";
        btn2.titleLabel.textColor = [UIColor blackColor];
        btn1.titleLabel.textColor = [UIColor blackColor];
        
        [btn2 addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:imageView2];
        [cell.contentView addSubview:imageView1];
    
    }
	
    cell.productModel = [self.products objectAtIndex:indexPath.row];
	return cell;
}



#pragma mark - target
- (void)push {
//    GroupBookViewController *vc = [[GroupBookViewController alloc] init];
    GroupSelectViewController *vc = [[GroupSelectViewController alloc] init];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

//    DetailViewsController *vc = [[DetailViewsController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)push2 {
//    GroupBookViewController *vc = [[GroupBookViewController alloc] init];
    DetailViewsController *vc = [[DetailViewsController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
