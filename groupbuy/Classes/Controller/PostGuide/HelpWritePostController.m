//
//  HelpWritePostController.m
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HelpWritePostController.h"
#import "HelpWritePostCell.h"

@implementation HelpWritePostController

@synthesize delegate;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    [self setNavigationRightButton:NSLS(@"kWriteDone") action:@selector(clickWriteDone:)];
    self.navigationItem.title = NSLS(@"kHelpWrite");
    
    manager = [[PostHelpQuestionManager alloc] init];    
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [manager release];
    manager = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)keyboardDidShowWithRect:(CGRect)keyboardRect
{
    CGRect tableRect = self.dataTableView.frame;
    tableRect.size.height = 480 - keyboardRect.size.height - 55 - 20 ;
    self.dataTableView.frame = tableRect;
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    CGRect tableViewRect = self.view.bounds;
    self.dataTableView.frame = tableViewRect;
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [HelpWritePostCell getCellHeight];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [manager.questionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [HelpWritePostCell getCellIdentifier];
    
    HelpWritePostCell *cell = (HelpWritePostCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [HelpWritePostCell createCell:self];
    }
    
    // Configure the cell...
    NSString* question = [manager.questionList objectAtIndex:indexPath.row];
    cell.questionLabel.text = question;
    cell.indexPath = indexPath;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

+ (HelpWritePostController*)showHelpWritePostController:(UIViewController<HelpWritePostControllerDelegate>*)superController
{
    HelpWritePostController* controller = [[[HelpWritePostController alloc] init] autorelease];
    controller.delegate = superController;
    [superController.navigationController pushViewController:controller animated:YES];
    return controller;
}

- (void)textDidBeginEditing:(id)sender atIndexPath:(NSIndexPath*)indexPath
{
    [self.dataTableView scrollToRowAtIndexPath:indexPath 
                              atScrollPosition:UITableViewScrollPositionTop 
                                      animated:YES];
}

- (void)textDidEndOnExit:(id)sender atIndexPath:(NSIndexPath*)indexPath
{
    int row;
    if (indexPath.row == [manager.questionList count] - 1)
        row = 0;
    else
        row = indexPath.row + 1;

    NSIndexPath* nextIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    HelpWritePostCell* cell = (HelpWritePostCell*)[self.dataTableView cellForRowAtIndexPath:nextIndexPath];
    [cell.answerTextField becomeFirstResponder];
}

- (void)textDidChange:(id)sender atIndexPath:(NSIndexPath*)indexPath
{
    // update data
    HelpWritePostCell* cell = (HelpWritePostCell*)[self.dataTableView cellForRowAtIndexPath:indexPath];
    [manager.answerList replaceObjectAtIndex:indexPath.row withObject:cell.answerTextField.text];
//    NSLog(@"answer list = %@", [manager.answerList description]);
}

- (void)clickWriteDone:(id)sender
{
    if ([manager validateAnswer] == NO){
        [self popupUnhappyMessage:NSLS(@"kNoAnswer") title:nil];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(helpWritePostDone:)]){
        [delegate helpWritePostDone:[manager genderatePost]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
