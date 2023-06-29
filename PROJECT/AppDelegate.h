#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) NSTextField *list1TextField;
@property (nonatomic, strong) NSTextField *list2TextField;
@property (nonatomic, strong) NSTextField *resultTextField;
@property (nonatomic, assign) struct Node *pbeg;
@property (nonatomic, assign) struct Node *pend;
@property (nonatomic, assign) struct Node *pbeg1;
@property (nonatomic, assign) struct Node *pend1;
@property (nonatomic, assign) BOOL isDarkModeEnabled;

@end

