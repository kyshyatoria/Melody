//
//  SongsListTableViewController.m
//  Melody
//
//  Created by Kanchan Yadav on 19/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//

#import "SongsListTableViewController.h"
#import "Constants.h"


@interface SongsListTableViewController ()

@property (nonatomic)NSArray *songsList;
@property (strong, nonatomic)  NSString *singerName;
@property (nonatomic)NSInteger selectedRow;
@end

@implementation SongsListTableViewController{
    int cellHeight;
    int newCellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cellHeight = 30;
    [self extractSongsAndSingerNameFromPlist];
    self.title = [NSString stringWithFormat:@"Songs from %@",self.singerName];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.songsList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == _selectedRow){
        
        return newCellHeight;
    }else{
    
        return cellHeight;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *songsCell = [tableView dequeueReusableCellWithIdentifier:SONGS_TABLE_VIEW_CELL_IDENTIFIER];
    
    if(songsCell == nil){

        songsCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SONGS_TABLE_VIEW_CELL_IDENTIFIER];
    }
    
    [songsCell.textLabel setText: [[self.songsList objectAtIndex:indexPath.row] objectForKey:SONG_NAME_KEY]];
    
    [songsCell.contentView addSubview:[self createLyricsButton:songsCell.contentView.frame withSelectedRow:indexPath.row]];
    
    return songsCell;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


-(void)extractSongsAndSingerNameFromPlist{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:SONGS_PLIST_FILE_NAME ofType:@"plist"];
    NSArray *songsArray = [NSArray arrayWithContentsOfFile:filePath];
    if(songsArray.count){
        
        self.singerName = [[songsArray objectAtIndex:self.currentIndexPath.row] objectForKey:SINGER_NAME_KEY];
        self.songsList = [[songsArray objectAtIndex:self.currentIndexPath.row] objectForKey:SONGS_ARRAY_KEY];
    }
}


-(UIButton *)createLyricsButton:(CGRect)contentViewFrame withSelectedRow:(NSInteger)row{
    
    UIButton *lyricsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    NSInteger buttonYPositionForCenterAlignment = contentViewFrame.origin.y+ (contentViewFrame.size.height - 20)/2;
    [lyricsButton setFrame:CGRectMake(contentViewFrame.size.width-60, buttonYPositionForCenterAlignment, 50, 20)];
    [lyricsButton setTitle:@"Lyrics" forState:UIControlStateNormal];
    [lyricsButton setBackgroundColor:[UIColor greenColor]];
    [lyricsButton addTarget:self action:@selector(showLyricsScreen:) forControlEvents:UIControlEventTouchUpInside];
    return lyricsButton;
}

-(void)showLyricsScreen:(NSInteger) row{

    newCellHeight = 100;
    _selectedRow = row;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
@end
