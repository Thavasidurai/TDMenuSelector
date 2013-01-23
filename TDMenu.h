//
//  TDMenu.h
//  TDMenuSelector
//
//  Created by Purush V on 23/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TDMenuDelegate <NSObject>

@required
- (void) SelectedMenu:(NSUInteger)selectedIndex;
@end

@interface TDMenu : UIView<UIGestureRecognizerDelegate>
{
    NSUInteger numeberOfitems;
    NSMutableArray *itemsAry;
    NSMutableArray *itemsXPositionAry;
    
    id<TDMenuDelegate>delegate;

}
@property(nonatomic,assign)NSUInteger numeberOfitems;
@property(nonatomic,strong)id<TDMenuDelegate>delegate;
-(void)setNumeberOfitems:(NSUInteger)numeberOfitem;
-(void)drawMenuItems;
@end
