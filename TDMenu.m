//
//  TDMenu.m
//  TDMenuSelector
//
//  Created by Purush V on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TDMenu.h"
#import <QuartzCore/QuartzCore.h>
@implementation TDMenu
@synthesize numeberOfitems,delegate;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // setup the initial properties of the
        
        // draggable item
        
//        [self setItemPropertiesToDefault:self];
        
    }
    
    return self;
    
}

-(void)setNumeberOfitems:(NSUInteger)numeberOfitem
{
    numeberOfitems = numeberOfitem;
}

-(void)drawMenuItems
{    //5px is space between the items
    int spaceWidth = 0;
    //Subtracting space between items
    float space = (numeberOfitems -1)*spaceWidth;
    
    //Finding menu items width
    float itemWidth = (self.frame.size.width - space)/numeberOfitems;
    float itemHeight = self.frame.size.height;
    float itemX = 0;
    float itemY = 0;
    
    NSMutableArray * colorAry = [[NSMutableArray alloc]initWithObjects:[UIColor blueColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor brownColor],[UIColor purpleColor], nil];
    //creating items
    itemsAry = [[NSMutableArray alloc]init];
    itemsXPositionAry = [[NSMutableArray alloc]init];
    for (int i =0; i<numeberOfitems; i++) {
        
        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(itemX, itemY, itemWidth, itemHeight)];
        itemView.backgroundColor = [colorAry objectAtIndex:i];
        itemView.tag = i;
        itemView.userInteractionEnabled = YES;
        [self addSubview:itemView];
        itemX = itemView.frame.origin.x + itemWidth + spaceWidth;
        [itemsAry addObject:itemView];
        [itemsXPositionAry addObject:[NSString stringWithFormat:@"%f",itemView.frame.origin.x]];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [singleTap setNumberOfTapsRequired:1];
        [singleTap setNumberOfTouchesRequired:1];
        [itemView addGestureRecognizer:singleTap];
        
    }
    
    if ([itemsAry count]>0) {
        
        [self creatingSelectorView:0 y:itemY width:itemWidth height:itemHeight];

    }
    

}
-(void)creatingSelectorView:(float)x y:(float)y width:(float)width height:(float)height
{
    //Creating selector view and placing it in first item
    UIView *selectorView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    selectorView.backgroundColor = [UIColor greenColor];
    UIView *lastView = [itemsAry lastObject];
    selectorView.tag = [lastView tag]+1;
    lastView.userInteractionEnabled = YES;
    [itemsAry addObject:selectorView];
    [self addSubview:selectorView];
    
    //Set moving property
    [self setPanGestureRecognizer:selectorView];
    
    
}
-(void)setPanGestureRecognizer:(UIView *)view
{
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.delegate = self; // Very important
    [view addGestureRecognizer:panRecognizer];
    
}
- (void)handleTap:(UIPanGestureRecognizer *)recognizer {
    
    float tappedViewX = recognizer.view.frame.origin.x;
    UIView *view = [itemsAry lastObject];
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.5f];
    view.frame = CGRectMake(tappedViewX, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    [UIView commitAnimations];
    
    float selectedViewX =view.frame.origin.x;
    NSUInteger index = [itemsXPositionAry indexOfObject:[NSString stringWithFormat:@"%f",selectedViewX]];
    [delegate SelectedMenu:index];

}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    
    CGPoint translation = [recognizer translationInView:self];    
    CGFloat newX = MIN(recognizer.view.frame.origin.x + translation.x, self.frame.size.width - recognizer.view.frame.size.width);
    CGRect newFrame = CGRectMake( newX,recognizer.view.frame.origin.y, recognizer.view.frame.size.width, recognizer.view.frame.size.height);
    recognizer.view.frame = newFrame;
    [recognizer setTranslation:CGPointZero inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [self calculateAppropriateSelectorXposition:recognizer.view];
    }

}
-(void)calculateAppropriateSelectorXposition:(UIView *)view
{
    float selectorViewX = view.frame.origin.x;
    float itemXposition;
    for (int i =0; i<[itemsXPositionAry count]; i++) {
         itemXposition = [[itemsXPositionAry objectAtIndex:i]floatValue];
        if (selectorViewX < itemXposition)
            break;
    }
    
    if (selectorViewX > 0) {
        
        if ((itemXposition - selectorViewX)< (view.frame.size.width)/2) {
           
            view.frame = CGRectMake(view.frame.origin.x + itemXposition - selectorViewX, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            
        }
        else{
            
            view.frame = CGRectMake(itemXposition - view.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            
        }
        

    }
    else{
        
        view.frame = CGRectMake(0, view.frame.origin.y, view.frame.size.width, view.frame.size.height);

    }
    
    float selectedViewX =view.frame.origin.x;
    NSUInteger index = [itemsXPositionAry indexOfObject:[NSString stringWithFormat:@"%f",selectedViewX]];
   [delegate SelectedMenu:index];
  
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
