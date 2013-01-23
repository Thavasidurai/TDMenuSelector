//
//  ViewViewController.m
//  TDMenuSelector
//
//  Created by Purush V on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewViewController.h"

@implementation ViewViewController
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    menu = [[TDMenu alloc]initWithFrame:CGRectMake(10, 50, 300, 60)];
    menu.backgroundColor = [UIColor redColor];
    menu.numeberOfitems = 5;
    menu.delegate = self;
    [menu drawMenuItems];
    [self.view addSubview:menu];
    
    sampleView = [[UIView alloc]initWithFrame:CGRectMake(10, 170, 300, 240)];
    [self.view addSubview:sampleView];
    sampleView.backgroundColor = [UIColor blueColor];
}
- (void) SelectedMenu:(NSUInteger)selectedIndex
{
    NSLog(@"selectedIndex:::%d",selectedIndex);
    if (selectedIndex == 0) {
        
        sampleView.backgroundColor = [UIColor blueColor];

    }
    else if(selectedIndex == 1)
    {
        sampleView.backgroundColor = [UIColor yellowColor];

    }
    else if(selectedIndex == 2)
    {
        sampleView.backgroundColor = [UIColor orangeColor];

    }
    else if(selectedIndex == 3)
    {
        sampleView.backgroundColor = [UIColor brownColor];

    }
    else 
    {
        sampleView.backgroundColor = [UIColor purpleColor];

    }


}

- (void)viewDidUnload
{
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
