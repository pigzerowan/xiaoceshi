//
//  GuideController.m
//  GoldGiant
//
//  Created by Fuer on 15/2/13.
//  Copyright (c) 2015年 Sany. All rights reserved.
//

#import "GuideController.h"
//#import "UIColor+Extend.h"

@interface GuideController ()
{
    UIPageControl * m_pageControl;//
}
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) NSArray *imageNames;
@end

@implementation GuideController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
- (instancetype)initWithImgNames:(NSArray *)imageNames
{
    if (self = [super init]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self = [self initWithCollectionViewLayout:layout];
        self.view.frame = [UIScreen mainScreen].bounds;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, [UIScreen mainScreen].bounds.size.width);
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.bounces = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.imageNames = imageNames;
        /**
         
         m_pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 30)];
         [m_pageControl setBackgroundColor:[UIColor clearColor]];
         m_pageControl.currentPage = 0;
         m_pageControl.numberOfPages = self.imageNames.count;
         m_pageControl.pageIndicatorTintColor = [UIColor colorWithHexColorString:@"#e5e5e5"];
         m_pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexColorString:@"#999999"];
         [self.view addSubview:m_pageControl];
         
         **/
       
       
    }
    return self;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    [cell addSubview:imageView];
    
    return cell;
}


#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)sView
{
    m_pageControl.currentPage = sView.contentOffset.x/self.view.frame.size.width;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == [UIScreen mainScreen].bounds.size.width * _imageNames.count) {
        [self willMoveToParentViewController:nil]; //1
        [self.view removeFromSuperview]; //2
        [self removeFromParentViewController];//3
        if(self.guideViewCompletionBlock){
            self.guideViewCompletionBlock();
            self.guideViewCompletionBlock = nil;
        }
    }
}
-(void)finishGuideViewCompletion:GuideViewControllerCompletionBlock
{
    self.guideViewCompletionBlock = GuideViewControllerCompletionBlock;
}
@end
