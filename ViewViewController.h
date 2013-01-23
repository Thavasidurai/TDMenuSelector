//
//  ViewViewController.h
//  TDMenuSelector
//
//  Created by Purush V on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDMenu.h"
@interface ViewViewController : UIViewController<TDMenuDelegate>
{
    TDMenu *menu;
    UIView *sampleView;
}
@end
