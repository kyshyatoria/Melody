//
//  SingersListTableViewController.m
//  Melody
//
//  Created by Kanchan Yadav on 19/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//

#import "SingersListTableViewController.h"
#import "Constants.h"
#import "SongsListTableViewController.h"

@interface SingersListTableViewController()

@property (nonatomic) NSArray *singersList;
@property (nonatomic) NSString *imagePath;

@end

@implementation SingersListTableViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    self.title = @"Select your favourite singer";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"songs" ofType:@"plist"];
    self.singersList = [NSArray arrayWithContentsOfFile:filePath];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.singersList count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = SINGERS_TABLE_VIEW_CELL_IDENTIFIER;
    
    UITableViewCell *singersCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(singersCell == nil){
        
        singersCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [singersCell.textLabel setText:[self getSingerName:indexPath.row ]];
    
    [singersCell.imageView setImage:[UIImage imageNamed:_imagePath]];
    
    return  singersCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150.0f;
}

-(NSString *)getSingerName:(NSInteger )row{

    NSString *singerName ;
    if(row <= [self.singersList count]){
    
       singerName = [[self.singersList objectAtIndex:row] objectForKey:@"singer"];
        self.imagePath = [[self.singersList objectAtIndex:row]objectForKey:@"image"];
        
    }else{
        singerName = nil;
        [NSException raise:@"IndexOutOfBounds" format:@"indexoutofBounds"];
        
    }
    return singerName;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:SEGUE_SHOW_SONGS_LIST sender:indexPath ];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:SEGUE_SHOW_SONGS_LIST]){
    
        SongsListTableViewController *songsListController = (SongsListTableViewController *)[segue destinationViewController];
        songsListController.currentIndexPath = sender;
        
    }
}

@end
