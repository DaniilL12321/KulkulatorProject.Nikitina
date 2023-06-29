//Задача 30. Написать программу, которая формирует списки из вещественных значений a и b. Для каждого из введенных списков вычисляет s=∑_(i=1)^n▒p_i+q_i, выбирая в качестве p сначала элементы списка a, затем элементы списка b. Значение х и значения элементов списка вводятся с клавиатуры. Условие завершения ввода элементов каждого списка – ввод 0.

#import "AppDelegate.h"
#import <Cocoa/Cocoa.h>

struct Node {
    float d;
    struct Node *next;
};

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 400, 300)
                                              styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    [self.window setTitle:@"Калькулятор двух списков"];
    [self.window center];
    
    [self.window setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameVibrantDark]];
    
    NSButton *executeButton = [[NSButton alloc] initWithFrame:NSMakeRect(15, 20, 100, 30)];
    [executeButton setTitle:@"Выполнить"];
    [executeButton setTarget:self];
    [executeButton setAction:@selector(executeButtonClicked:)];
    [executeButton setBezelStyle:NSBezelStyleRounded];
    [[executeButton cell] setBackgroundStyle:NSBackgroundStyleNormal];
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:[executeButton title] attributes:@{NSForegroundColorAttributeName: NSColor.whiteColor}];
    [[executeButton cell] setAttributedStringValue:buttonTitle];
    [[self.window contentView] addSubview:executeButton];
    
    self.list1TextField = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 250, 360, 22)];
    [self.list1TextField setPlaceholderString:@"Введите элементы первого списка"];
    [[self.list1TextField cell] setBackgroundStyle:NSBackgroundStyleNormal];
    [[self.list1TextField cell] setTextColor:NSColor.whiteColor];
    [[self.window contentView] addSubview:self.list1TextField];
    NSAttributedString *list1Placeholder = [[NSAttributedString alloc] initWithString:[self.list1TextField placeholderString] attributes:@{NSForegroundColorAttributeName: NSColor.whiteColor}];
    [[self.list1TextField cell] setPlaceholderAttributedString:list1Placeholder];
    [[self.window contentView] addSubview:self.list1TextField];
    
    self.list2TextField = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 220, 360, 22)];
    [self.list2TextField setPlaceholderString:@"Введите элементы второго списка"];
    [[self.list2TextField cell] setBackgroundStyle:NSBackgroundStyleNormal];
    [[self.list2TextField cell] setTextColor:NSColor.whiteColor];
    [[self.window contentView] addSubview:self.list2TextField];
    NSAttributedString *list2Placeholder = [[NSAttributedString alloc] initWithString:[self.list2TextField placeholderString] attributes:@{NSForegroundColorAttributeName: NSColor.whiteColor}];
    [[self.list2TextField cell] setPlaceholderAttributedString:list2Placeholder];
    [[self.window contentView] addSubview:self.list2TextField];
    
    self.resultTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 70, 360, 22)];
    [self.resultTextField setEditable:NO];
    [[self.resultTextField cell] setBackgroundStyle:NSBackgroundStyleNormal];
    [[self.resultTextField cell] setTextColor:NSColor.whiteColor];
    [[self.window contentView] addSubview:self.resultTextField];
    
    [self.window makeKeyAndOrderFront:nil];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void)executeButtonClicked:(id)sender {
    NSString *list1Input = [[self.list1TextField stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *list2Input = [[self.list2TextField stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Обработка входных данных и вычисление сумму
    self.pbeg = NULL;
    self.pend = NULL;
    
    // Добавление элементов в первый список на основе list1Input
    NSArray<NSString *> *list1Elements = [list1Input componentsSeparatedByString:@" "];
    for (NSString *element in list1Elements) {
        float value = [element floatValue];
        add(&(self->_pend), value);
        if (self->_pbeg == NULL) {
            self->_pbeg = self->_pend;
        }
    }
    
    self->_pbeg1 = NULL;
    self->_pend1 = NULL;
    
    // Добавление элементов во второй список на основе list2Input
    NSArray<NSString *> *list2Elements = [list2Input componentsSeparatedByString:@" "];
    for (NSString *element in list2Elements) {
        float value = [element floatValue];
        add(&(self->_pend1), value);
        if (self->_pbeg1 == NULL) {
            self->_pbeg1 = self->_pend1;
        }
    }
    
    float sum = 0;
    struct Node *p = self->_pbeg;
    while (p) {
        sum += p->d;
        p = p->next;
    }
    p = self->_pbeg1;
    while (p) {
        sum += p->d;
        p = p->next;
    }
    
    NSString *resultString = [NSString stringWithFormat:@"Сумма элементов двух списков: %.2f", sum];
    NSAttributedString *resultAttributedString = [[NSAttributedString alloc] initWithString:resultString attributes:@{NSForegroundColorAttributeName: NSColor.whiteColor}];
    [self.resultTextField setAttributedStringValue:resultAttributedString];
}


// Создание списка с одним элементом
struct Node* create_list(float d) {
    struct Node *pv = (struct Node *)malloc(sizeof(struct Node));
    pv->d = d;
    pv->next = NULL;
    return pv;
}

// Добавление элемента в конец списка
void add(struct Node **pend, float d) {
    struct Node *pv = (struct Node *)malloc(sizeof(struct Node));
    pv->d = d;
    pv->next = NULL;
    if (*pend == NULL) {
        *pend = create_list(d);
    }
    else {
        (*pend)->next = pv;
        *pend = pv;
    }
}

// Печать списка
void print_list(struct Node *pbeg) {
    struct Node *p = pbeg;
    while (p) {
        NSLog(@"%f ", p->d);
        p = p->next;
    }
}

// Освобождение памяти, занятой списком
void delete_list(struct Node *pbeg) {
    struct Node *p = pbeg;
    while (p) {
        struct Node *tmp = p->next;
        free(p);
        p = tmp;
    }
}

@end
