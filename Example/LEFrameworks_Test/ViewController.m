//
//  ViewController.m
//  LEFrameworks_Test
//
//  Created by emerson larry on 16/7/4.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "ViewController.h"



@interface TestLEbaseTableViewCell : LEBaseTableViewCell
@end
@implementation TestLEbaseTableViewCell{
    UILabel *curLabel;
}
-(void) initUI{
    curLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:0 Font:LEBoldFont(LayoutFontSize14) Width:self.globalVar.ScreenWidth-LayoutSideSpace*2 Height:0 Color:ColorTextBlack Line:0 Alignment:NSTextAlignmentLeft]];//Line=0表示可以换行
}
-(void) setData:(id)data IndexPath:(NSIndexPath *)path{
    [super setData:data IndexPath:path];
    [curLabel leSetText:[NSString stringWithFormat:@"%zd- %@",path.row+1,data]];//设置文字需使用le开头的方法，类似的有leSetSize、leSetFrame、leSetOffset
    [curLabel leSetLineSpace:LayoutTextLineSpace];//设置行间距
    [self setCellHeight:curLabel.bounds.size.height+LayoutSideSpace*2];//文字刷新后即可重新设置Cell的高度了
}
@end

@interface TestExcelViewCell : LEExcelViewTableViewCell
@end
@implementation TestExcelViewCell{
    UILabel *labelLeft;
    UILabel *labelRight;
}
-(void) initUIForExcelView{
    [self.immovableView setBackgroundColor:[UIColor colorWithRed:0.8947 green:0.527 blue:0.3107 alpha:1.0]];
    [self.movableView setBackgroundColor:[UIColor colorWithRed:0.6922 green:0.4729 blue:0.6923 alpha:1.0]];
    [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView EdgeInsects:UIEdgeInsetsZero] Image:[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"lewave"]];
    [self addBottomSplitWithColor:ColorRed Offset:CGPointZero Width:self.bounds.size.width];
    labelLeft=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.immovableView Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
    labelRight=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace20, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
}
-(void) setData:(id)data IndexPath:(NSIndexPath *)path{
    [super setData:data IndexPath:path];
    [labelLeft leSetText:[NSString stringWithFormat:@"第%zd行",path.row]];
    [labelRight leSetText:[NSString stringWithFormat:@"第%zd行右侧可移动的内容，我是第%zd行内容",path.row,path.row]];
}
@end

@interface TestExcelViewTabbar : LEExcelViewTabbar
@end
@implementation TestExcelViewTabbar
-(void) initUIForExcelViewTabbar{
    [self.immovableView setBackgroundColor:[UIColor colorWithRed:0.9991 green:0.5522 blue:0.9683 alpha:1.0]];
    [self.movableView setBackgroundColor:[UIColor colorWithRed:0.4642 green:0.6434 blue:0.9982 alpha:1.0]];
    [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView EdgeInsects:UIEdgeInsetsZero] Image:[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"lewave"]];
    [LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.immovableView Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"左侧行数" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
    [LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace20, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"右侧内容1        右侧内容2" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
}
@end

@interface ViewControllerPage : LEBaseView<LEGetDataDelegate,LETableViewCellSelectionDelegate,LELineChartDelegate,LEBarChartDelegate>
@end
@implementation ViewControllerPage{
    
    UIButton *autoLayoutTopButton;
    int autoLayoutCounter;
    UILabel *autoLayoutLabel;
    UILabel *autoLayoutMultiLineLabel;
    
    //测试所需临时变量
    LEBaseTableViewWithRefresh *curTableView;
    UILabel *labelBarChart;
    UILabel *labelLineChart;
    LEWaveProgressView *curWaveProgressView;
    LECurveProgressView *curveProgress;
    LEExcelView *curExcelView;
}
-(void) setExtraViewInits{
    [self onTestLEBaseTableView];
}
//===================测试 LEBaseTableView TableView的封装
-(void) onTestLEBaseTableView{
    curTableView=[[LEBaseTableViewWithRefresh alloc] initWithSettings:[[LETableViewSettings alloc] initWithSuperViewContainer:self ParentView:self.viewContainer TableViewCell:@"TestLEbaseTableViewCell" EmptyTableViewCell:nil GetDataDelegate:self TableViewCellSelectionDelegate:self AutoRefresh:NO]];
//    [curTableView setBottomRefresh:NO];
}
-(void) onRefreshData{
    NSMutableArray *muta=[[NSMutableArray alloc] init];
    [muta addObject:@"LEFrameworks测试 之 LESegmentView"];
    [muta addObject:@"LEFrameworks测试 之 LEWebView"];
    [muta addObject:@"LEFrameworks测试 之 圆弧进度条 LECurveProgressView"];
    [muta addObject:@"LEFrameworks测试 之 折线走势图 LELineChart"];
    [muta addObject:@"LEFrameworks测试 之 柱状走势图 LEBarChart"];
    [muta addObject:@"LEFrameworks测试 之 波浪滚动上涨下落进度球 LEWaveProgressView"];
    [muta addObject:@"LEFrameworks测试 之 Excel表格化查阅框架 LEExcelView"];
    [muta addObject:@"LEFrameworks测试 之 自动排版 LEUIFramework"];
    [muta addObject:@"LEFrameworks测试 之 图片多选 LEMultiImagePicker"];
    [curTableView onRefreshedWithData:muta];
}
-(void) onTableViewCellSelectedWithInfo:(NSDictionary *)info{
    NSIndexPath *index=[info objectForKey:KeyOfCellIndexPath];
    switch (index.row) {
        case 0:
            [self onTestSegmentView];
            break;
        case 1:
            [self onTestWebview];
            break;
        case 2:
            [self onTestCurveProgressView];
            break;
        case 3:
            [self onTestLELineChart];
            break;
        case 4:
            [self onTestBarChart];
            break;
        case 5:
            [self onTestWaveProgressView];
            break;
        case 6:
            [self onTestExcelView];
            break;
        case 7:
            [self onTestAutoLayout];
            break;
        case 8:
        {
            LEMultiImagePicker *vc=[[LEMultiImagePicker alloc] initWithImagePickerDelegate:nil];
            [self.curViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
//===================测试Webview
-(void) onTestWebview{
    LEWebView *vc=[[LEWebView alloc] initWithURLString:@"http://www.baidu.com"];
    [vc setNavigationTitle:@"LEWebView"];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
//===================测试SegmentView
-(void) onTestSegmentView{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LESegmentView"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    UIView *v1=[[UIView alloc] init];
    [v1 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5216 blue:0.563 alpha:1.0]];
    UIView *v2=[[UIView alloc] init];
    [v2 setBackgroundColor:[UIColor colorWithRed:0.7397 green:1.0 blue:0.795 alpha:1.0]];
    UIView *v3=[[UIView alloc] init];
    [v3 setBackgroundColor:[UIColor colorWithRed:0.6962 green:0.7723 blue:1.0 alpha:1.0]];
    UIView *v4=[[UIView alloc] init];
    [v4 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.7302 blue:0.9259 alpha:1.0]];
    UIView *v5=[[UIView alloc] init];
    [v5 setBackgroundColor:[UIColor colorWithRed:0.9925 green:0.909 blue:0.7724 alpha:1.0]];
    LESegmentView *segment=[[LESegmentView alloc] initWithTitles:nil Pages:nil ViewContainer:view.viewContainer SegmentHeight:40 Indicator:[ColorRed imageWithSize:CGSizeMake(20, 6)] SegmentSpace:20];
    [segment onSetTitles:@[@"One",@"第二页",@"再来一个",@"这一个应该可以超出屏幕宽了吧",@"好了可以结束了"]];
    [segment onSetPages:@[v1,v2,v3,v4,v5]];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
//===================测试CurveProgressView
-(void) onTestCurveProgressView{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LECurveProgressView"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    curveProgress=[[LECurveProgressView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorInsideBottomCenter Offset:CGPointMake(0, StatusBarHeight) CGSize:CGSizeMake(240, 240)] MinAngle:-225 MaxAngle:45 Color:[UIColor colorWithRed:0.345 green:0.748 blue:0.885 alpha:1.000] ShadowColor:[UIColor colorWithRed:0.271 green:0.496 blue:0.712 alpha:1.000] LineWidth:12 ShadowLineWidth:6 Progrss:12];
    [curveProgress strokeChart];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onCheckCurveProgressView) userInfo:nil repeats:YES];
}
-(void) onCheckCurveProgressView{
    [curveProgress growChartByAmount:12];
}
//===================测试折线走势图
-(void) onTestLELineChart{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LELineChart"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    LELineChart *line=[[LELineChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth, self.curFrameWidth/2)] LineWidth:2 RulerLineWidth:1 Color:ColorRed RulerColor:[UIColor greenColor] Padding:14 VerticalPadding:20 Target:self];
    labelLineChart=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:line Offset:CGPointMake(0, LayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorRed Line:1 Alignment:NSTextAlignmentCenter]];
    [line onSetData:@[@"10",@"100",@"50",@"60",@"20",@"5",@"90",@"100",@"40",@"80"] Min:5 Max:100];
    [line setBackgroundColor:[UIColor colorWithRed:0.4686 green:0.7222 blue:0.8368 alpha:1.0]];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onLineChartSelection:(NSUInteger)index{
    [labelLineChart leSetText:[NSString stringWithFormat:@"当前移动到了第%zd个位置",index+1]];
}
//===================测试测试柱状走势图
-(void) onTestBarChart{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LEBarChart"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    LEBarChart *bar=[[LEBarChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth, self.curFrameWidth/2)] BarChartSettings:[[LEBarChartSettings alloc] init] Delegate:self];
    labelBarChart=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:bar Offset:CGPointMake(0, LayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorRed Line:1 Alignment:NSTextAlignmentCenter]];
    [bar onSetValues:@[@"10",@"100",@"50",@"60",@"20",@"5",@"90",@"100",@"40",@"80"] Tags:@[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine",@"Ten"]];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onBarSelectedWithIndex:(int)index{
    [labelBarChart leSetText:[NSString stringWithFormat:@"当前点击了第%d个bar",index+1]];
}
//===================测试 波浪滚动上涨下落进度球
-(void) onTestWaveProgressView{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LEWaveProgressView"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    curWaveProgressView=[[LEWaveProgressView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, NavigationBarHeight) CGSize:CGSizeMake(250, 260)]];
    [curWaveProgressView setBackgroundColor:[UIColor colorWithRed:0.3515 green:0.7374 blue:1.0 alpha:1.0]];
    [curWaveProgressView setPercentage:0];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onWaveTimer) userInfo:nil repeats:YES];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onWaveTimer{
    [curWaveProgressView setPercentage:rand()%10*1.0/10];
}
//===================测试 Excel表格化查阅框架
-(void) onTestExcelView{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LEExcelView"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    curExcelView=[[LEExcelView alloc] initWithSettings:[[LETableViewSettings alloc] initWithSuperViewContainer:view ParentView:view.viewContainer TableViewCell:@"TestExcelViewCell" EmptyTableViewCell:nil GetDataDelegate:self TableViewCellSelectionDelegate:self] ImmovableViewWidth:120 MovableViewWidth:300 TabbarHeight:BottomTabbarHeight TabbarClassname:@"TestExcelViewTabbar"];
    [curExcelView onRefreshedWithData:[@[@"",@"",@"",@"",@"",@"",@"",@""]mutableCopy]];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
//===================测试 自动排版
-(void) onTestAutoLayout{
    LEBaseViewController *vc=[[LEBaseViewController alloc] init];
    [vc setNavigationTitle:@"LEUIFramework 自动排版"];
    LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
    autoLayoutCounter=0;
    autoLayoutTopButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, 10) CGSize:CGSizeMake(100, 100)] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:@"点击改变大小" FontSize:10 Font:nil Image:[[UIColor redColor] imageWithSize:CGSizeMake(20, 20)] BackgroundImage:[[[UIColor yellowColor] imageWithSize:CGSizeMake(1,1)] middleStrechedImage] Color:ColorBlack SelectedColor:ColorMask5 MaxWidth:100 SEL:@selector(onClickForAutoLayout) Target:self]];
    autoLayoutLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:autoLayoutTopButton Offset:CGPointMake(0, 10) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:10 Font:nil Width:0 Height:0 Color:ColorBlack Line:1 Alignment:NSTextAlignmentCenter]];
    autoLayoutMultiLineLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorInsideBottomCenter  Offset:CGPointMake(0, -10) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:15 Font:nil Width:self.curFrameWidth-20 Height:0 Color:ColorBlack Line:0 Alignment:NSTextAlignmentCenter]];
    [LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.viewContainer Anchor:LEAnchorOutsideTopCenter RelativeView:autoLayoutMultiLineLabel Offset:CGPointMake(0, -10) CGSize:CGSizeMake(100, 30)] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:@"Label会把我顶上去" FontSize:10 Font:nil Image:[[UIColor redColor] imageWithSize:CGSizeMake(20, 20)] BackgroundImage:[[[UIColor yellowColor] imageWithSize:CGSizeMake(1,1)] middleStrechedImage] Color:ColorBlack SelectedColor:ColorMask5 MaxWidth:0 SEL:@selector(onClickForAutoLayout) Target:self]];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onClickForAutoLayout{
    autoLayoutCounter++;
    CGSize size=autoLayoutTopButton.bounds.size;
    size.width+=5;
    size.height+=5;
    [autoLayoutLabel leSetText:[NSString stringWithFormat:@"点击了第%d次，目前按钮大小为%@",autoLayoutCounter,NSStringFromCGSize(size)]];
    [autoLayoutTopButton leSetSize:size];
    NSString *text=@"";
    for (int i=0; i<autoLayoutCounter; i++) {
        text=[text stringByAppendingString:@"测试的句子"];
    }
    [autoLayoutMultiLineLabel leSetText:text];
}
@end


@interface ViewController ()
@end
@implementation ViewController{
    ViewControllerPage *curPage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    curPage=[[ViewControllerPage alloc] initWithViewController:self];
    [self.navigationItem setTitle:@"LEFrameworks 测试"];
}
@end
